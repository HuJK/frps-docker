# Git sync

## How to build it

Prepare build kit
```
# make your computer able to rum arm64 binary
docker run --rm --privileged docker/binfmt:820fdd95a9972a5308930a2bdfb8573dd4447ad3
# enable expremental feature
export DOCKER_CLI_EXPERIMENTAL=enabled
export DOCKER_BUILDKIT=1
docker buildx create --name mybuilder_az --driver docker-container
docker buildx use mybuilder_az
```

Build
```bash
#In this case, we use "ubuntu-test" as image name. you can use wathever you want.
docker buildx build  --platform linux/arm64,linux/amd64 -t whojk/git-sync . --output="type=docker"
docker push whojk/git-sync

#Test in localhost
docker run -it ubuntu-test
```

## How to use it:
Upload to the docker hub, and deploy it to azure app service
![Azure deploy example](https://i.imgur.com/uox9lwO.png)

## Boot order
1. /etc/init.d/rcS
2. /etc/rc.local
3. all services stored at /etc/sv

## Environment Variables

1. `APT_UPDATE` : `0/1`, run `apt update` at startup
1. `APT_UPGRADE` : `0/1`, run `apt upgrade` at startup

1. Git syncing related variables.
    1. `GIT_SSH_KEY`
    1. `GIT_EMAIL` 
    1. `GIT_NAME` 
    1. `GIT_REPO_URL` 
    1. `GIT_SYNC_INTERVAL`


You can checkout this example environment variables file: [env_file_example](env_file_example)