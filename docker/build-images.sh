#!/usr/bin/env bash

docker build --rm -f cdt-infra-base/ubuntu-16.04/Dockerfile -t cdt-infra-base:ubuntu-16.04 .
docker build --rm -f cdt-infra-eclipse-full/ubuntu-16.04/Dockerfile -t cdt-infra-eclipse-full:ubuntu-16.04 .
docker build --rm -f cdt-infra-platform-sdk/sdk4.9-ubuntu-16.04/Dockerfile -t cdt-infra-platform-sdk:sdk4.9-ubuntu-16.04 .
