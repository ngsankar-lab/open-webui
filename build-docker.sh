#!/bin/bash

# Build and Push Script for LZB AI Platform Docker Image
# This script builds the Docker image and pushes it to Docker Hub

set -e  # Exit on any error

# Configuration
DOCKER_HUB_USERNAME="${DOCKER_HUB_USERNAME:-ngsankar}"  # Replace with your Docker Hub username
IMAGE_NAME="lzb-ai-platform"
VERSION=$(grep '"version"' package.json | sed 's/.*"version": *"\([^"]*\)".*/\1/')
BUILD_HASH=$(git rev-parse --short HEAD)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🐳 Building LZB AI Platform Docker Image${NC}"
echo -e "${YELLOW}Version: ${VERSION}${NC}"
echo -e "${YELLOW}Build Hash: ${BUILD_HASH}${NC}"
echo -e "${YELLOW}Docker Hub: ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}${NC}"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}❌ Docker is not running. Please start Docker Desktop first.${NC}"
    exit 1
fi

# Check if logged in to Docker Hub
if ! docker info | grep -q "Registry: https://index.docker.io/v1/"; then
    echo -e "${YELLOW}🔑 Please log in to Docker Hub first:${NC}"
    echo "docker login"
    echo ""
    read -p "Press enter after logging in..."
fi

echo -e "${BLUE}🔨 Building Docker image...${NC}"

# Build the image with multiple tags
docker build \
    --build-arg BUILD_HASH=${BUILD_HASH} \
    --platform linux/amd64,linux/arm64 \
    -t ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${VERSION} \
    -t ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest \
    -t ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:v${VERSION} \
    . || {
    echo -e "${RED}❌ Docker build failed!${NC}"
    exit 1
}

echo -e "${GREEN}✅ Docker image built successfully!${NC}"
echo ""

# Show image size
echo -e "${BLUE}📊 Image Information:${NC}"
docker images ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest

echo ""
echo -e "${BLUE}🚀 Pushing to Docker Hub...${NC}"

# Push all tags
docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${VERSION}
docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest
docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:v${VERSION}

echo ""
echo -e "${GREEN}🎉 Successfully pushed to Docker Hub!${NC}"
echo ""
echo -e "${BLUE}📋 Available tags:${NC}"
echo -e "  • ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest"
echo -e "  • ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${VERSION}"
echo -e "  • ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:v${VERSION}"
echo ""
echo -e "${BLUE}🐳 Run your image:${NC}"
echo "docker run -d -p 3000:8080 --name lzb-ai-platform ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest"
echo ""
echo -e "${BLUE}🔗 Docker Hub URL:${NC}"
echo "https://hub.docker.com/r/${DOCKER_HUB_USERNAME}/${IMAGE_NAME}"