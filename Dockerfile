FROM phusion/passenger-ruby23 as build

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -qq -y locales build-essential nodejs yarn mysql-client libmysqlclient-dev curl default-jre cmake \
    --fix-missing --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Set correct environment variables.
ENV HOME=/root

#ARG BUNDLE_PATH=/usr/local/rvm/gems/ruby-2.5.1@global
# ARG BUNDLE_PATH=/usr/local/rvm/gems/default
ARG BUNDLE_PATH=/usr/local/rvm/gems/ruby-2.3.7@global
ENV BUNDLE_PATH=$BUNDLE_PATH
ENV BUNDLE_GEMFILE=Gemfile
#ENV BUNDLE_CACHE_PATH=$BUNDLE_PATH/cache

# Use en_US.UTF-8 as our locale
RUN locale-gen en_US.UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# there are two users in passenger-docker systems.  root and app.
# rails apps can go under the app subdir and should be owned by app
RUN mkdir -p /build
WORKDIR /build

ADD Gemfile Gemfile.lock ./

ARG RAILS_ENV
ARG BUNDLE_DEPLOYMENT_FLAG
# set production vs dev bundle installs?
RUN bundle config --global --delete  frozen 1
RUN mkdir -p /root/.ssh
# RUN rvm info
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts && \
    mkdir -p $BUNDLE_PATH && \
    echo "****Bundle installing packages" && \
    echo "BUNDLE_PATH=$BUNDLE_PATH" && \
    echo "bundle install --quiet --path $BUNDLE_PATH $BUNDLE_DEPLOYMENT_FLAG" && \
    bundle install --quiet --path $BUNDLE_PATH $BUNDLE_DEPLOYMENT_FLAG
    # && \
    #echo "****Installing yarn packages" && \
    #yarn install

WORKDIR /root
RUN rm -rf /root/.ssh

RUN mkdir -p /home/app/tribalknow
WORKDIR /home/app/tribalknow
ENV MYSQL_HOST=mysql

# This is a bug in bundler - it does not use BUNDLE_PATH properly and only
# picks it up from the .bundle/config (local, home or global file settings).
# the danger here is that it will write this out to your local filesystem when
# volume mounted, and causes problems when running locally vs in container.
# The compose override tries to work around it by setting a docker volume, to avoid
# interfering when launching locally outside of docker.  If not using docker-compose
# be careful when switching between local and container execution contexts.
RUN rm -rf /home/app/tribalknow/.bundle && cp -R /build/.bundle /home/app/tribalknow

COPY config/database.yml.sample config/database.yml
COPY --chown=app:app . /home/app/tribalknow

ENV RAILS_LOG_TO_STDOUT=true
ENV DISABLE_SPRING=1
ARG IN_DOCKER_BUILD
# RUN echo "creating assets" && bundle exec rake assets:precompile

