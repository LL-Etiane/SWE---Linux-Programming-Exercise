#!/bin/bash

# deploy script for task manager api

REPO_URL="https://github.com/LL-Etiane/SWE---Linux-Programming-Exercise.git"
PROJECT_DIR="$HOME/taskmanager-api"

# check if git is installed, install if not
echo "Checking for Git..."
if ! command -v git &> /dev/null; then
    echo "Git not found, installing..."
    sudo apt-get update -y
    sudo apt-get install -y git
fi
echo "Git is installed."

# check if docker is installed, install if not
echo "Checking for Docker..."
if ! command -v docker &> /dev/null; then
    echo "Docker not found, installing..."
    sudo apt-get update -y
    sudo apt-get install -y docker.io docker-compose
fi

if ! command -v docker-compose &> /dev/null; then
    sudo apt-get install -y docker-compose
fi
echo "Docker is installed."

# start and enable docker
echo "Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# clone the repo into home directory
echo "Cloning the repo..."
if [ -d "$PROJECT_DIR" ]; then
    echo "Folder already exists, pulling latest..."
    cd "$PROJECT_DIR"
    git pull
else
    git clone "$REPO_URL" "$PROJECT_DIR"
    cd "$PROJECT_DIR"
fi

# check that the important files are there
echo "Checking project files..."
if [ ! -f "package.json" ] || [ ! -f "Dockerfile" ] || [ ! -f "docker-compose.yml" ]; then
    echo "Some required files are missing (package.json, Dockerfile, or docker-compose.yml)"
    exit 1
fi
echo "All files found."

# build and run with docker compose
echo "Building and starting the app..."
sudo docker-compose up -d --build

echo ""
echo "Done! App is running at http://localhost:5500"
echo ""
