FROM ubuntu:14.04

RUN locale-gen en_US.UTF-8

ENV HOME /root
ENV SHELL /bin/bash
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV PATH $HOME/.rbenv/bin:$HOME/.rbenv/shims:$HOME/.rbenv/plugins/ruby-build/bin:$PATH

ENV RUBY_VERSION 2.4.1

ADD https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

RUN apt-get update \
   && apt-get install -y curl \
   && curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - \
   && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 \
   && sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list' \
   && apt-get update \
   && apt-get install -y nodejs build-essential graphicsmagick apt-transport-https ca-certificates passenger \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update \
   && apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev libmysqlclient-dev libxrender1 \
   && git clone https://github.com/rbenv/rbenv.git /root/.rbenv \
   && git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build \
   && echo 'eval "$(rbenv init -)"' >> /root/.bashrc \
   && echo 'eval "$(rbenv init -)"' >> /root/.profile \
   && echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN rbenv install $RUBY_VERSION \
   && rbenv global $RUBY_VERSION \
   && gem install --no-ri --no-rdoc bundler \
   && rbenv rehash \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
