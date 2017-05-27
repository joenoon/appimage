FROM ubuntu:14.04

RUN locale-gen en_US.UTF-8

ENV HOME /root
ENV SHELL /bin/bash
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

RUN apt-get update \
   && apt-get install -y curl \
   && curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - \
   && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 \
   && sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list' \
   && apt-get update \
   && apt-get install -y nodejs build-essential graphicsmagick apt-transport-https ca-certificates passenger

RUN passenger-config install-agent

RUN curl -o- -L https://yarnpkg.com/install.sh | bash

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
