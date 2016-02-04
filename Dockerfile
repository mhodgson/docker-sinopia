FROM gliderlabs/alpine:3.2
MAINTAINER Nicholas Digati <nicholas@factual.com>

RUN apk update && \
  apk upgrade && \
  apk --update add bash fuse nodejs openssl git curl go supervisor && \
  rm -rf /var/cache/apk/* /usr/share/ri

ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

WORKDIR /home/

RUN go get github.com/kahing/goofys && \
  go install github.com/kahing/goofys && \
  npm install js-yaml sinopia

# COPY config.yaml /home/config.yaml
COPY start.sh /home/start.sh
COPY start_sinopia.sh /home/start_sinopia.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /home/start.sh /home/start_sinopia.sh && \
  mkdir -p /home/bucket/

EXPOSE 4873

# CMD [ "supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]

