FROM node:4.2.1-slim

# Env
ENV PHANTOMJS_VERSION 1.9.8

COPY ./phantomjs /usr/bin/phantomjs

# Commands
RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y libfreetype6 libfontconfig && \
  apt-get autoremove -y && \
  apt-get clean all

WORKDIR /opt/reack

COPY ./package.json package.json

RUN npm install \
    && npm install -g gulp \
    && npm shrinkwrap

COPY ./polyfill.js polyfill.js

CMD ["/bin/sh", "-c", "gulp dev"]
