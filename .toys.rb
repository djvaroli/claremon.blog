LOCAL_IMAGE = "claremon-blog"
PROJECT = "claremon-blog"
SERVICE = "claremon-blog"


tool "run-local" do
    flag :no_cache
    include :exec, exit_on_nonzero_status: true
    def run
      cache_args = no_cache ? ["--pull", "--no-cache"] : []
      exec ["docker", "build"] + cache_args +
           ["-t", LOCAL_IMAGE, "-f", "gcp_build/Dockerfile", "."]
      puts "Running on http://localhost:8080"
      exec ["docker", "run", "--rm", "-it", "-p", "8080:8080", LOCAL_IMAGE]
    end
  end


tool "deploy" do
    optional_arg :tag
    include :exec, exit_on_nonzero_status: true
    def run
        if tag.nil?
          tag = `git rev-parse HEAD`[0..-2]
          puts "Using current commit hash for tag: #{tag}"
        end
        image = "gcr.io/#{PROJECT}/#{SERVICE}:#{tag}"
        exec ["gcloud", "builds", "submit", "--config", "gcp_build/cloudbuild.yaml", 
        "--substitutions", "_IMAGE=#{image}"]
        exec ["gcloud", "beta", "run", "deploy", SERVICE,
        "--platform", "managed", "--region", "us-central1", 
        "--allow-unauthenticated", "--image", image, "--concurrency", "80"]
    end 
end

tool "greet" do
  desc "My First Tool!"
  flag :whom, default: "world"
  def run
      puts "Hello #{whom}"
  end
end

tool "qpush" do
  desc "Quick git push"
  optional_arg :message, default: "minor changes for quick push"
  include :exec, exit_on_nonzero_status: true
  def run
    exec ["git", "add", "."]
    exec ["git", "commit", "-m", message]
    exec ["git", "push"]
  end
end