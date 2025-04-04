ARG RUBY_VERSION=3.3.7

FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim AS base

ENV RACK_ENV="development" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle"

WORKDIR /fleetfocus-api

COPY . .

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential pkg-config libyaml-dev freetds-dev && \
    bundle install && \
    useradd fleetfocus-api --create-home --shell /bin/bash && \
    mkdir -p log tmp && \
    chown -R fleetfocus-api log tmp

USER fleetfocus-api:fleetfocus-api

EXPOSE 9292
CMD ["script/server", "--port 3000"]
