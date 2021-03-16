deploy_to_gcr () {
    GCP_PROJECT=$1
    GCP_SERVICE=$2
    tag=$(git rev-parse HEAD)
    image="gcr.io/$GCP_PROJECT/$GCP_SERVICE:$tag"
    echo image

    # gcloud builds submit --conifg _build/cloudbild.yaml --substitutions _IMAGE=$image

    #     exec ["gcloud", "beta", "run", "deploy", SERVICE,
    #     "--platform", "managed", "--region", "us-central1", 
    #     "--allow-unauthenticated", "--image", image, "--concurrency", "80"]

}

"$@"