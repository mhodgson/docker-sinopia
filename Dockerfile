FROM node
MAINTAINER Nicholas Digati <nicholas@factual.com>

RUN apt-get -y update && apt-get -y install \
 automake \
 autotools-dev \
 build-essential \
 g++ \
 git \
 libcurl4-gnutls-dev \
 libfuse-dev \
 libssl-dev \
 libxml2-dev \
 make \
 pkg-config \
 && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git && \
  cd s3fs-fuse && \
  ./autogen.sh && \
  ./configure && \
  make && \
  make install

RUN mkdir -p /opt/sinopia/bucket

WORKDIR /opt/sinopia

RUN npm install js-yaml sinopia

COPY start.sh /opt/sinopia/start.sh

# Only need this if not pulling config from outside source(start.sh)
# COPY config.yaml /opt/sinopia/config.yaml

CMD [ "/opt/sinopia/start.sh" ]

EXPOSE 4873

VOLUME /opt/sinopia/bucket
