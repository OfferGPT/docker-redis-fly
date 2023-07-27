# docker-redis-fly

Redis docker image adapted for running on fly.io. This image is based on the official redis image, but enforced to run in LTS mode and import the redis config from the environment. This image also supports enabling swap space on Fly.io.

## Environment variables

Given the above, the following environment variables are supported:

- `REDIS_PORT`: The port to listen TLS on. Defaults to `6379`.
- `REDIS_PASSWORD`: The password to use for authentication. Required.
- `REDIS_TLS_CERT`: The TLS certificate to use. Defaults to no certificate. Required.
- `REDIS_TLS_KEY`: The TLS key to use. Defaults to no key. Required.
- `EXTRA_REDIS_CONFIG`: Any extra configuration to add to the redis config file. Defaults to no extra config.
- `SWAP`: Whether to enable swap space. Defaults to empty, i.e. not enabled.
- `SWAP_SIZE`: The size of the swap space to enable. Defaults to `512M`.
