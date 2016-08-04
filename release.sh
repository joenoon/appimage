#!/bin/bash

docker build --rm=true -t joenoon/appimage:v2 .
docker push joenoon/appimage:v2
