commit_hash=$(git rev-parse HEAD)

test_args () {
    echo $1
    echo $2
    echo "Here I am!"
}

"$@"