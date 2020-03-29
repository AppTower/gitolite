![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/apptower/gitolite)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/apptower/gitolite)
![Docker Pulls](https://img.shields.io/docker/pulls/apptower/gitolite?color=00e68a)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/AppTower/gitolite?label=latest&sort=semver&color=cc99ff)

# What is this

Multiarch containerized gitolite server.

# How to use this image

### Start an instance

```
$ docker run -e ADMIN_PUBLIC_KEY="your public key" -p 8022:22 -d -t apptower/gitolite
```

### Start an instance with named volume

```
$ docker volume create gitolite-volume
$ docker run -e ADMIN_PUBLIC_KEY="your public key" -p 8022:22 -v gitolite-volume:/home/git -d -t apptower/gitolite
```

### Run gitolite via [docker-compose](https://github.com/docker/compose)

Example ` docker-compose.yml `
```
version: "3.7"

services:
  gitolite:
    image: apptower/gitolite
    restart: always
    tty: true
    volumes:
      - gitolite-volume:/home/git
    ports:
      - "8022:22"
    environment:
      ADMIN_PUBLIC_KEY: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILwUSh+mMHRBz3IJFvvEFwYGKmaHUCTEBYWc3878jrnn This is administrator's public key"

volumes:
  gitolite-volume:
  
```
Run ` docker-compose up -d `, wait for it to initialize completely.

# Environment Variables

`ADMIN_PUBLIC_KEY`

This variable is mandatory. It allows you to manage the gitolite server.

# Image Variants

### `apptower/gitolite` or `apptower/gitolite:latest`

The latest version of gitolite.

### `apptower/gitolite:<Version Number>`

This image point to a specific version of gitolite.

# Source

- https://github.com/AppTower/gitolite

# Reference

- [Gitolite Homepage](https://gitolite.com/gitolite)
