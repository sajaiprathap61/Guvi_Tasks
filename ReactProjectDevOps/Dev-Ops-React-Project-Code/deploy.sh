#!/bin/bash

# Set to exit if any command fails
set -e

# Variables
EC2_USER="ubuntu"
EC2_IP="18.136.196.121" # EC2 public IP address
DOCKER_IMAGE="88b7abd1d97d" # Docker image to pull
DOCKER_TAG="latest" # Docker tag (e.g., latest or any version)
CONTAINER_NAME="devops-build-devops-react-app-1" # Name for the container
SSH_KEY_PATH=$1

# Optional: SSH key path
# SSH_KEY_PATH="./key.pem" # Path to your EC2 private key file

# SSH into EC2 instance and execute commands
ssh -T -i "$SSH_KEY_PATH" -o StrictHostKeyChecking=no "$EC2_USER@$EC2_IP" << EOF
  # Update packages
  sudo apt update -y

  # Install Docker (if not installed)
  if ! command -v docker &> /dev/null
  then
    echo "Docker could not be found, installing Docker..."
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
  else
    echo "Docker is already installed"
  fi

  # Pull Docker image from Docker Hub
  echo "Pulling Docker image $DOCKER_IMAGE:$DOCKER_TAG"
  sudo docker pull $DOCKER_IMAGE:$DOCKER_TAG

  # Stop and remove any existing container with the same name (optional)
  echo "Stopping and removing any existing container with name $CONTAINER_NAME"
  sudo docker stop $CONTAINER_NAME || true
  sudo docker rm $CONTAINER_NAME || true

  # Run the Docker container
  echo "Deploying Docker container $CONTAINER_NAME"
  sudo docker run -d --name $CONTAINER_NAME -p 80:80 $DOCKER_IMAGE:$DOCKER_TAG

  # Check if the container is running
  sudo docker ps
EOF

echo "Deployment script completed."

