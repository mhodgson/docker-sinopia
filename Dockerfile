FROM golang:latest
MAINTAINER Nicholas Digati <nicholas@factual.com>

RUN apt-get -y update
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get -y install fuse \
  build-essential \
  nodejs

RUN go get github.com/kahing/goofys
RUN go install github.com/kahing/goofys

RUN mkdir -p bucket/ ~/.aws/

RUN npm install js-yaml sinopia

COPY start.sh .

EXPOSE 4873

CMD [ "./start.sh" ]
