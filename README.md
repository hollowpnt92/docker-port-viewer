# Docker Port Viewer 

A modern web application for viewing and interacting with Docker container ports. Built with TypeScript, React, and Material-UI, it provides a user-friendly interface to manage and access your Docker containers.

![Docker Port Viewer Interface](https://github.com/user-attachments/assets/0c331919-3cc7-4ef0-91b4-5f80fd9adb6e)

## Features

- View all running Docker containers and their exposed ports
- Search containers by name
- Sort containers by name or creation date
- View container details including:
  - Container name
  - Image name
  - Status
  - Start time
  - Exposed ports
- Direct access to container web interfaces through:
  - Built-in iframe viewer
  - New tab option
- Customizable hostname for accessing containers
- Secure Docker socket proxy integration
- Responsive Material-UI design

## Prerequisites

- Docker and Docker Compose installed
- Access to the Docker socket

## Quick Start

### Using Pre-built Image

1. Pull the pre-built image:
```bash
docker pull hollowpnt/docker-port-viewer:latest
```

2. Run using Docker Compose:
```bash
docker-compose up -d
```

The application will be available at `http://localhost:3003`

### Local Development

1. Clone the repository:
```bash
git clone <repository-url>
cd docker-port-viewer
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm start
```

4. For production build:
```bash
npm run build
```

### Building Docker Image

To build the Docker image locally:

```bash
docker build -t docker-port-viewer:latest .
```

For cross-platform builds (e.g., building for Linux from macOS):
```bash
docker build --platform linux/amd64 -t docker-port-viewer:latest .
```

## CI/CD and Automation

This repository includes automated workflows for dependency updates and Docker image builds.

### Automated Dependency Updates

Dependabot is configured to automatically check for dependency updates weekly (every Monday at 9:00 AM). It will:
- Create pull requests for npm dependency updates
- Group production and development dependencies separately
- Label PRs with `dependencies` and `npm` labels

### Automated Docker Image Builds

GitHub Actions automatically builds and pushes Docker images to Docker Hub on:
- Pushes to `main` or `master` branch
- Tagged releases (tags starting with `v`)
- Manual workflow dispatch

**Setup Instructions:**

1. **Create Docker Hub Access Token:**
   - Go to [Docker Hub Account Settings](https://hub.docker.com/settings/security)
   - Click "New Access Token"
   - Create a token with read/write permissions
   - Copy the token (you won't see it again!)

2. **Configure GitHub Secrets:**
   - Go to your GitHub repository settings
   - Navigate to `Settings` → `Secrets and variables` → `Actions`
   - Add the following secrets:
     - `DOCKERHUB_USERNAME`: Your Docker Hub username (`hollowpnt`)
     - `DOCKERHUB_TOKEN`: The access token you created in step 1

3. **Verify Setup:**
   - Push a commit to the `main` branch
   - Check the `Actions` tab in GitHub to see the workflow running
   - Once complete, verify the image is pushed to Docker Hub

**Image Tags:**
- `latest` - Latest build from main/master branch
- `main` or `master` - Branch-specific tags
- `v1.0.0`, `v1.0`, `v1` - Semantic version tags
- `main-<sha>` - Commit SHA tags for branch builds

## Architecture

The application consists of two main components:

1. **Frontend**: A React application built with TypeScript and Material-UI
2. **Backend**: Nginx server that proxies requests to the Docker socket

### Security

The application uses a Docker socket proxy (`tecnativa/docker-socket-proxy`) to ensure secure access to the Docker API. The proxy is configured to:
- Allow only container listing
- Disable POST, PUT, and DELETE operations
- Mount the Docker socket as read-only

## Configuration

The application can be configured through the following environment variables:

- `PORT`: The port on which the application runs (default: 3003)
- `DOCKER_SOCKET`: Path to the Docker socket (default: /var/run/docker.sock)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

ISC
