FROM ubuntu:20.04

MAINTAINER Raul R., <ricea.raul2002@gmail.com>

RUN         apt install curl \
		&& apt install unzip
		&& apt install tar
		&& apt update \
		&& apt upgrade \
		&& useradd -m -d /home/container container

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

EXPOSE 1000-30000

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
