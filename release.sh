#!/bin/bash

v=v20170909a
docker build --rm=true -t joenoon/appimage:"$v" .
docker push joenoon/appimage:"$v"
