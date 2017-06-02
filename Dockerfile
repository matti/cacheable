FROM ruby:2.4.1-alpine
ENV RACK_ENV production

RUN apk --no-cache --update add \
  build-base
RUN adduser -S app

WORKDIR /app
ADD . .

ENTRYPOINT ./start
