FROM yaktor/base:0.33.0

MAINTAINER yaktor@scispike.com

ARG VERSION
RUN npm install -g yaktor@${VERSION:-'latest'}

USER node
