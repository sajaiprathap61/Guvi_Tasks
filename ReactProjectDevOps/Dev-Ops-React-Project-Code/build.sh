#!/bin/bash

docker login -u sajaiprathap -p dckr_pat_BxOBHLxn3P7InN-vppZwSJwoj8E
# Build Docker image
docker build -t sajaiprathap/dev .

# Tag and push the dev image to the public Docker Hub
# docker tag app:dev sajaiprathap/dev:latest
docker push sajaiprathap/dev

# Build Docker image for production private repository
docker build -t sajaiprathap/prod .

# Tag and push the production image to the private Docker Hub repository
# docker tag app:prod sajaiprathap/prod:latest
docker push sajaiprathap/prod
