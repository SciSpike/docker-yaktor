FROM yaktor/yaktor-base:0.30.0

MAINTAINER yaktor@scispike.com

ARG VERSION
RUN npm install -g yaktor@${VERSION:-'latest'}

USER node
