ARG RUBY_VERSION=OVERRIDE_ME

FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim AS base

ENV RACK_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_ONLY="default production" \
    BUNDLE_PATH="/usr/local/bundle"

WORKDIR /app

FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential pkg-config libyaml-dev freetds-dev

COPY .ruby-version Gemfile Gemfile.lock ./

RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

FROM base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y freetds-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY --from=build /usr/local/bundle /usr/local/bundle

COPY . .

RUN useradd fleetfocus-api --create-home --shell /bin/bash && \
    mkdir -p log tmp && \
    chown -R fleetfocus-api log tmp

USER fleetfocus-api:fleetfocus-api

EXPOSE 3000

CMD ["script/server", "--port 3000"]
