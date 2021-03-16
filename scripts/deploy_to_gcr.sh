deploy_to_gcr () {
    GCP_PROJECT = $1
    GCP_SERVICE = $2
    tag=$(git rev-parse HEAD)

    image = "gcr.io/$GCP_PROJECT/$GCP_SERVICE:$tag"
    echo image
}

"$@"