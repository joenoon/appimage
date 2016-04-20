FROM ubuntu:14.04

ADD https://github.com/Yelp/dumb-init/releases/download/v1.0.1/dumb-init_1.0.1_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

RUN apt-get update \
   && apt-get install -y curl \
   && curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - \
   && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 \
   && sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list' \
   && apt-get update \
   && apt-get install -y nodejs build-essential graphicsmagick apt-transport-https ca-certificates passenger \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
