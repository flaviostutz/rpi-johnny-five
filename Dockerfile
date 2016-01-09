FROM hypriot/rpi-iojs:1.4.1
MAINTAINER Flavio Stutz <flaviostutz@gmail.com>

RUN apt-get update && \
    apt-get install -y \
    python \
    python-dev \
    python-pip \
    python-virtualenv \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/
	
RUN npm update && \
	npm install johnny-five

