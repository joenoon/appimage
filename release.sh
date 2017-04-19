#!/bin/bash

TAG="node7ruby2.4.1a"
docker build --rm=true -t "joenoon/appimage:$TAG" .
docker push "joenoon/appimage:$TAG"
