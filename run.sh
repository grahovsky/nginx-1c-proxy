#!/bin/sh
docker rm -f nginx-1c-proxy 2> /dev/null

docker run --name nginx-1c-proxy \
  -it \
  --detach \
  --net my_app_net \
  -p 1540-1541:1540-1541 \
  -p 1560-1591:1560-1591 \
  -p 1545:1545 \
  --privileged \
  grahovsky/nginx-1c-proxy:latest