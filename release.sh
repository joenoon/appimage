#!/bin/bash

TAG="node6ruby2.1.2a"
docker build --rm=true -t "joenoon/appimage:$TAG" .
docker push "joenoon/appimage:$TAG"
