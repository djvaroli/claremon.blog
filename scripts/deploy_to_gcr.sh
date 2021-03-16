deploy_to_gcr () {
    GCP_PROJECT=$1
    GCP_SERVICE=$2
    GCP_REGION=$3
    tag=$(git rev-parse HEAD)
    image="gcr.io/$GCP_PROJECT/$GCP_SERVICE:$tag"

    gcloud builds submit --config _build/cloudbild.yaml --substitutions _IMAGE=$image
    gcloud beta run deploy $GCP_SERVICE --platform managed --region $GCP_REGION --allow-unauthenticated --image $image --concurrency 80
}

"$@"