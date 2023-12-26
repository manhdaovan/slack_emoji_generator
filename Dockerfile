FROM ruby:2.7

RUN cat /etc/*release && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y libpng-dev libjpeg-dev libtiff-dev && \
    apt-get install -y imagemagick && \
    apt-get install -y fonts-takao-mincho && \
    apt-get install -y fonts-takao && \
    apt-get install -y fonts-arphic-ukai fonts-arphic-uming fonts-ipafont-mincho fonts-ipafont-gothic fonts-unfonts-core
WORKDIR /app
COPY . .
