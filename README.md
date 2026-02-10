# Workstations

Collection of Docker-based workstation environments.

## Repository Layout

Current workstations:

- `ros2_jazzy/`: Ubuntu 24.04 + ROS 2 Jazzy development workstation.

Each workstation folder contains its own `Dockerfile`, `docker-compose.yaml`, and detailed usage notes.

## Quick Start

Read the specific workstation documentation. Otherwise, from the repository root:

1. Build a workstation image:
   ```bash
   docker compose -f <MY_WORKSTATION>/docker-compose.yaml build
   ```
2. Rebuild from scratch with latest base image:
   ```bash
   docker compose -f <MY_WORKSTATION>/docker-compose.yaml build --pull --no-cache <MY_WORKSTATION_SRV_NAME>
   ```
3. Start the workstation container:
   ```bash
   docker compose -f <MY_WORKSTATION>/docker-compose.yaml up -d
   ```
4. Open a shell in the running container:
   ```bash
   docker exec -it <MY_WORKSTATION_NAME> zsh
   ```
5. Stop and remove the container:
   ```bash
   docker compose -f <MY_WORKSTATION>/docker-compose.yaml down -v
   ```
