# Lix in Docker

1. This is basically a node image with lix installed
2. There is a web server running in the image which expose a REST API that allows:
    - Uploading files
    - Invoking lix
    - Invoking Haxe
    - Download files

## REST API

See `lix.service.api.controller.Root`

## Usage

The docker image is not hosted anywhere for now. So please build it yourself.

```bash
haxe controller.hxml
docker build -t lix-service .
```

Then run it:

```bash
docker run -p 8080:8080 lix-service
```

Then interact using the REST API:

```bash
curl -X POST --data '{"args":["-v"]}' localhost:8080/lix
```