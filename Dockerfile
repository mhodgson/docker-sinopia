FROM factual/docker-base
MAINTAINER Nicholas Digati <nicholas@factual.com>

WORKDIR /home/

RUN	curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
  apt-get update && \
  apt-get -y install nodejs \
    python3-pip \
    supervisor && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install js-yaml sinopia && \
  pip3 install awscli

COPY start.sh /home/start.sh
COPY service_start.sh /home/service_start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /home/start.sh /home/service_start.sh && \
  mkdir /home/bucket

EXPOSE 4873

CMD [ "supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]

