#!/bin/bash

sudo docker stop sshbastion
sudo docker rm sshbastion

for user in ./users/*; do \
      username=$(basename $user); \
      mkdir -p ./home/$username; \
      chown 1000:1000 ./home/$username; \
done

sudo docker run -d \
  --name sshbastion \
  --hostname gateway \
  --restart unless-stopped \
  -p 2222:2222 \
  sshbastion

#  -v ./home:/home:rw \
#  --user 1000:1000 \