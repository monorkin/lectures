FROM ruby:2.4-alpine

RUN apk add --no-cache \
    build-base \
    gcc \
    abuild \
    binutils \
    binutils-doc \
    gcc-doc \
    bash

WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

EXPOSE 9292
CMD "./start.sh"
