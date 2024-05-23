# syntax = docker/dockerfile:1

ARG RUBY_VERSION
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /app

ENV BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test" \
    RACK_ENV="production"

RUN gem update --system --no-document && \
    gem install -N bundler

FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential pkg-config freetds-dev

COPY --link Gemfile Gemfile.lock .ruby-version ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

COPY --link . ./

FROM base

RUN apt-get update -qq && apt-get install --no-install-recommends -y freetds-dev

COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /app /app

RUN groupadd --system --gid 1000 app && \
    useradd app --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R app:app log
USER 1000:1000

EXPOSE 9292
CMD ["bundle", "exec", "script/server"]
