FROM ruby:2.4.1-alpine

ADD . /prog_image

WORKDIR /prog_image

RUN rm -rf config/application.yml || true

RUN apk --update add --virtual build-dependencies netcat-openbsd linux-headers ruby-dev build-base imagemagick && \
    gem install bundler --no-ri --no-rdoc && \
    bundle install --without development test && \
    apk update ca-certificates \
    apk del build-dependencies

EXPOSE 9292

CMD rake prog_image:server
