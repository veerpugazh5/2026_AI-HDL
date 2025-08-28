#!/bin/bash
# AI-HDL Docker Build Script

set -e

# Configuration
IMAGE_NAME="aihdl/competition-env"
TAG="2025"
DOCKERFILE="Dockerfile"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}======================================"
echo -e "AI-HDL Docker Build Script"
echo -e "======================================${NC}"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}Error: Docker is not running or not accessible${NC}"
    exit 1
fi

# Check if Dockerfile exists
if [[ ! -f "$DOCKERFILE" ]]; then
    echo -e "${RED}Error: Dockerfile not found${NC}"
    exit 1
fi

echo -e "${YELLOW}Building Docker image...${NC}"
echo "Image: $IMAGE_NAME:$TAG"
echo "Dockerfile: $DOCKERFILE"
echo ""

# Build the image
docker build \
    --tag "$IMAGE_NAME:$TAG" \
    --file "$DOCKERFILE" \
    --progress=plain \
    .

if [[ $? -eq 0 ]]; then
    echo -e "${GREEN}✓ Build completed successfully!${NC}"
    echo ""
    echo "Image details:"
    docker images "$IMAGE_NAME:$TAG"
    echo ""
    echo "To run the container:"
    echo "  docker run --rm -it $IMAGE_NAME:$TAG"
    echo ""
    echo "To run with workspace mounted:"
    echo "  docker run --rm -it -v \"\$(pwd)\":/home/student/workspace $IMAGE_NAME:$TAG"
else
    echo -e "${RED}✗ Build failed!${NC}"
    exit 1
fi
