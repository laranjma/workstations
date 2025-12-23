# ros2_jazzy_ws

Docker files to generate an Ubuntu 24.04 with ROS Jazzy image and associated container.

## Usage

To build a new image:
```
docker compose build
```
If you want to update the image type:
```
docker compose build --pull --no-cache jazzy-ws-srv
```
Start a new container (check if none running with `docker ps -a`):
```
docker compose up -d 
```
Enter in a running container:
```
docker exec -it jazzy-ws bash
```
Stop a running contrainer:
```
docker compose down -v
```

