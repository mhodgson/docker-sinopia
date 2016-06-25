FROM factual/docker-base
MAINTAINER Matt Hodgson <matthodgson@mac.com>

RUN adduser --disabled-password --gecos "" sinopia

WORKDIR /opt/sinopia/

RUN	curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
  apt-get update && \
  apt-get --no-install-recommends -y install nodejs \
    python3-pip && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  mkdir -p /etc/service/sinopia/ /etc/my_init.d/ /opt/sinopia/storage

RUN npm install js-yaml sinopia && \
  pip3 install awscli

COPY variable_check.sh /opt/sinopia/variable_check.sh
COPY service_start.sh /etc/my_init.d/99_service_start.sh
COPY sinopia.sh /etc/service/sinopia/run
COPY start.sh /opt/sinopia/start.sh

RUN chmod +x /opt/sinopia/variable_check.sh /etc/my_init.d/99_service_start.sh /etc/service/sinopia/run /opt/sinopia/start.sh

RUN chown -R sinopia:sinopia /opt/sinopia

EXPOSE 4873

CMD [ "/sbin/my_init" ]

