FROM ruby:2.5-stretch as build

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -qq -y nodejs yarn --fix-missing --no-install-recommends && \
    apt-get install -qq -y locales build-essential mysql-client default-libmysqlclient-dev curl iputils-ping \
        --fix-missing --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash app
RUN mkdir -p /build /app && chown -R app:app /build /app
USER 1000
WORKDIR /build

ENV HOME=/app
ENV BUNDLE_PATH=/build
ENV BUNDLE_GEMFILE=Gemfile
ENV MYSQL_HOST=mysql
ENV RAILS_LOG_TO_STDOUT=true
ENV DISABLE_SPRING=1
ARG IN_DOCKER_BUILD

COPY --chown=app Gemfile Gemfile.lock ./

RUN mkdir -p /app/.ssh/ && ssh-keyscan github.com >> /app/.ssh/known_hosts && \
    mkdir -p $BUNDLE_PATH && \
    echo "****Bundle installing packages" && \
    echo "BUNDLE_PATH=$BUNDLE_PATH" && \
    echo "bundle install --quiet --path $BUNDLE_PATH" && \
    bundle install --quiet --path $BUNDLE_PATH

WORKDIR /app

COPY config/database.yml.sample config/database.yml
COPY --chown=app:app . /app/

RUN echo "****Installing yarn packages" && \
    yarn install
RUN ls -l node_modules || true

# RUN echo "creating assets" && bundle exec rake assets:precompile

EXPOSE 3000
CMD ['bundle', 'exec', 'puma', '-c', 'config/puma.rb']
