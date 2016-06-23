FROM node:4

# essential invariants
ENV PATH ./node_modules/.bin:$PATH
RUN apt-get update && \
     apt-get install -y openjdk-7-jre-headless
RUN apt-get install -y sudo

ARG VERSION
RUN npm install -g yaktor@${VERSION:-'latest'} || echo "wait"

# app & user specifics
RUN useradd -ms /bin/bash --uid 1000  yaktor 
RUN adduser yaktor sudo
RUN echo "yaktor ALL=(ALL) NOPASSWD: ALL"  >> /etc/sudoers
USER yaktor

VOLUME /app
WORKDIR /app

COPY yaktor.sh /yaktor.sh
ENTRYPOINT ["/yaktor.sh"]
