# frps-docker

## How to use it:
1. Edit or copy the [env_file_example](env_file_example)
2. `docker run -it -d --rm --env-file=env_file_example -p 0.0.0.0:7000:7000 --restart=always --name=frps whojk/frps-multiuser`

## Environment Variables

1. `FRP_UPDATE` : `0/1`, update frp at startup
    `FRP_UPDATE_INTERVAL`
1. `FRPS` : `0/1`, run frps
    1. `FRPS_PORT`
    1. `FRPS_KCP_PORT` 
    1. `FRPS_MULTIUSER_SERVICE_PORT`
    1. `FRP_USER_*`
1. `FRPC` : `0/1`, run frpc
    1. `FRPC_CONN`
    1. `FRPC_CONN_PORT`
    1. `FRPC_USER`
    1. `FRPC_TOKEN`
    1. `FRPC_PROTO`
    1. `FRPC_PROXY_TYPE`
    1. `FRPC_LOCAL_PORT`
    1. `FRPC_REMOTE_PORT`

You can checkout this example environment variables file: [env_file_example](env_file_example)


## How to build it

Prepare build kit
```
# make your computer able to rum arm64 binary
docker run --rm --privileged docker/binfmt:820fdd95a9972a5308930a2bdfb8573dd4447ad3
# enable expremental feature
export DOCKER_CLI_EXPERIMENTAL=enabled
export DOCKER_BUILDKIT=1
docker buildx create --name mybuilder_f --driver docker-container
docker buildx use mybuilder_f
```

Build
```bash
docker buildx build  --platform linux/amd64 -t whojk/frps-multiuser . --output="type=docker"
docker push whojk/frps-multiuser

#Test in localhost
docker run -it --rm --env-file=env_file_example --name=frps whojk/frps-multiuser
```

Build and push to dockerhub
```bash
docker buildx build --platform linux/arm64,linux/amd64 -t whojk/frps-multiuser . --push
```
