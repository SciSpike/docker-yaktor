FROM yaktor/base:0.34.0

MAINTAINER yaktor@scispike.com

RUN npm install -g yaktor@0.4.0

USER node
