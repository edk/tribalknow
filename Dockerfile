#FROM phusion/passenger-ruby25:0.9.35 as build
FROM phusion/passenger-ruby23 as build

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -qq -y locales build-essential nodejs yarn mysql-client libmysqlclient-dev curl default-jre cmake \
    --fix-missing --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
    #curl -sL http://sphinxsearch.com/files/sphinxsearch_2.2.11-release-1~jessie_amd64.deb > /tmp/sphinx.2.2.11.deb && \
    #dpkg -i /tmp/sphinx.2.2.11.deb && rm /tmp/sphinx.2.2.11.deb \
    #sphinxsearch \

# Set correct environment variables.
ENV HOME=/root

ARG BUNDLE_PATH=/usr/local/rvm/gems/ruby-2.5.1@global
ENV BUNDLE_PATH=$BUNDLE_PATH
ENV BUNDLE_GEMFILE=Gemfile

# Use en_US.UTF-8 as our locale
RUN locale-gen en_US.UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

RUN mkdir -p /build
WORKDIR /build

ADD Gemfile Gemfile.lock ./
#ADD Gemfile Gemfile.lock yarn.lock package.json ./

# the name of the host to connect to in docker is "mysql" as defined in the docker-compose-all.yml
ENV MYSQL_HOST mysql
COPY config/database.yml.sample config/database.yml

ENV BUNDLE_CACHE_PATH ../usr/local/bundle/cache
ENV BUNDLE_GEMFILE Gemfile

ARG RAILS_ENV
#RUN bundle config --global frozen 1
RUN ls -CF && \
    mkdir -p /root/.ssh && chmod 700 /root/.ssh && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts && \
    mkdir -p /usr/local/bundle && \
    echo "Bundle installing packages" && \
    bundle install --path /usr/local/bundle 
    #bundle update && bundle install --path /usr/local/bundle 
    #&& \ yarn install

RUN mkdir -p /home/app/tribalknow
WORKDIR /home/app/tribalknow
ENV MYSQL_HOST=mysql

RUN cp -R /build/.bundle .

COPY config/database.yml.sample config/database.yml
COPY --chown=app:app . /home/app/tribalknow

ENV SECRET_KEY_BASE 1
ENV RAILS_LOG_TO_STDOUT=true
ENV DISABLE_SPRING=1
ARG IN_DOCKER_BUILD
RUN echo "creating assets" && bundle exec rake assets:precompile
# 
# EXPOSE 8080
# WORKDIR /home/app/tribalknow
# 
# # enable nginx/passenger
# RUN rm -f /etc/service/nginx/down
# RUN rm /etc/nginx/sites-enabled/default
# COPY ./docker/nginx.conf /etc/nginx/sites-enabled/webapp.conf
# COPY ./docker/rails-env.conf /etc/nginx/main.d/rails-env.conf
# RUN rm -f /var/log/nginx/*.log
# 
# RUN mkdir -p /etc/service/rails-log-forwarder/
# ADD ./docker/rails-log-forwarder.sh /etc/service/rails-log-forwarder/run
# 
# COPY ./docker/entrypoint.sh /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]


