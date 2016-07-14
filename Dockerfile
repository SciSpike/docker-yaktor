FROM yaktor/base:0.31.0

MAINTAINER yaktor@scispike.com

ARG VERSION
RUN npm install -g yaktor@${VERSION:-'latest'}

USER node
