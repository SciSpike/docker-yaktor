FROM alpine:3.4
RUN set -x \
  && apk add --no-cache \
    git  openjdk7-jre-base ruby-dev=2.3.1-r0 ruby=2.3.1-r0 nodejs-lts python make g++ ghostscript-fonts graphviz bash sudo python make g++
ARG VERSION
RUN npm install -g yaktor@${VERSION:-'latest'} || echo "wait"

RUN /usr/bin/gem install -N asciidoctor-diagram json
# app & user specifics
RUN adduser -D -u 1000  yaktor
RUN echo "yaktor ALL=(ALL) NOPASSWD: ALL"  >> /etc/sudoers
USER yaktor
RUN echo 'export PATH="./node_modules/.bin:$PATH"' >> ~/.profile


VOLUME /app
WORKDIR /app

COPY yaktor.sh /yaktor.sh
ENTRYPOINT ["/yaktor.sh"]
