#!/bin/zsh

aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 797857744011.dkr.ecr.ap-northeast-1.amazonaws.com

# image id, repository url
docker tag $1 $2

docker push $2