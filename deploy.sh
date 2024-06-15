#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Build and deploy meg service
echo "Building meg service..."
cd ../meg
./gradlew build

echo "Building Docker image for meg service..."
docker build -t meg:latest .

# Build vc-assistant service
echo "Building vc-assistant service..."
cd ../senna
./gradlew build

echo "Building Docker image for vc-assistant service..."
docker build -t senna:latest .

# Run Docker Compose
echo "Running Docker Compose..."
docker-compose up --build -d
