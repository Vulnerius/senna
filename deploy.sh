Copy code
#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Start Minikube
minikube start --driver=docker

# Set the Docker environment to Minikube's Docker daemon
eval $(minikube docker-env)

# Build and deploy meg service
echo "Building meg service..."
cd ../meg
./gradlew build

echo "Building Docker image for meg service..."
docker build -t meg-service:latest .

# Build vc-assistant service
echo "Building vc-assistant service..."
cd ../senna
./gradlew build

echo "Building Docker image for vc-assistant service..."
docker build -t vc-assistant:latest .

# Apply Kubernetes configurations
echo "Applying Kubernetes configurations..."
kubectl apply -f kubernetes/meg-deployment.yml
kubectl apply -f kubernetes/meg-service.yml
kubectl apply -f kubernetes/vc-assistant-deployment.yml
kubectl apply -f kubernetes/vc-assistant-service.yml

# Get services status
echo "Getting services status..."
kubectl get services