#!/bin/bash

docker build --rm=true -t joenoon/appimage .
docker push joenoon/appimage
