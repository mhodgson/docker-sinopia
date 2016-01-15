FROM factual/docker-base
MAINTAINER Nicholas Digati <nicholas@factual.com>

# Install golang, taken from official golang docker image
ENV GOLANG_VERSION 1.5.3
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 43afe0c5017e502630b1aea4d44b8a7f059bf60d7f29dfd58db454d4e4e0ae53

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
  && echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p /go/bucket/ /root/.aws/
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

WORKDIR $GOPATH

# Instal nodejs
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -
RUN apt-get update && apt-get -y install fuse \
  build-essential \
  nodejs \
  git \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install goofys
RUN go get github.com/kahing/goofys
RUN go install github.com/kahing/goofys

# Install Sinopia
RUN npm install js-yaml sinopia

RUN mkdir -p /etc/service/start_goofys /et/service/start_sinopia
COPY start_goofys.sh /etc/service/start_goofys/run
COPY start_sinopia.sh /etc/service/start_sinopia/run
RUN chmod +x /etc/service/start_goofys/run /etc/service/start_sinopia/run

COPY config.yaml $GOPATH/config.yaml

EXPOSE 4873

CMD [ "/sbin/my_init" ]

