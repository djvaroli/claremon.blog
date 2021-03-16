commit_hash=$(git rev-parse HEAD)
ruby_version=$(ruby -v)
echo $commit_hash
echo $ruby_version