#!/bin/sh
set -ex

curl -Lo /tmp/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x /tmp/kubectl

mkdir -p ~/.kube
cp deploy.config ~/.kube/config
/tmp/kubectl config set-credentials deploy --token="$KUBE_TOKEN"

IMAGE=$(docker inspect brianmay/linuxpenguins.xyz:latest | jq -r '.[0].RepoDigests[0]')
if [ -n "$IMAGE" ]
then
    /tmp/kubectl set image deployment/linuxpenguins linuxpenguins="$IMAGE"
fi
