# Whanos

Whanos is an automated pipeline to deploy applications written in any languages!

## Features

- Automatically poll git repository
- Automatic language detection
- Base and standalone images
- Support for Java, C, Python, Javascript and Befunge
- Automatic generation of a docker image
- Automatic deployment and scaling to Kubernetes

## Prerequisites

You have to clone this repository.

- You must have a local [docker](https://www.youtube.com/watch?v=iik25wqIuFo) installation
- You must have a local [kubernetes](https://www.youtube.com/watch?v=iik25wqIuFo) cluster running

## Usage

You can spin up the application using:

```bash
./scripts/build.sh
```

## Create a whanos compliant application

In order to have a whanos compliant application that is deployed on kubernetes you have to create a `whanos.yml` which follow this structure:

```yaml
# Example application
deployment:
    resources:
        limits:
            memory: "128M"
        requests:
            memory: "128M"
    ports:
        - 3000
```

## Development documentation

If you want to contribute to the project you can check out the [repository documentation](docs/README.md)
