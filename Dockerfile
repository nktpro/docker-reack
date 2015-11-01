FROM node:4.2.1-slim

# Commands
RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y git python make g++ libfreetype6 libfontconfig bzip2 && \
  apt-get autoremove -y && \
  apt-get clean all

WORKDIR /opt/reack

COPY ./package.json package.json
#COPY ./node_modules node_modules

RUN \
  npm install --loglevel=warn -g npm@3.3.1 \
  && npm install --loglevel=warn \
  && npm install --loglevel=warn phantomjs \
  && npm install --loglevel=warn -g gulp grunt

COPY ./polyfill.js polyfill.js

CMD ["/bin/sh", "-c", "gulp dev"]
