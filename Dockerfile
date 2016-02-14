FROM resin/rpi-raspbian:wheezy
MAINTAINER Flavio Stutz <flaviostutz@gmail.com>

WORKDIR /opt

#Install basic tools
RUN apt-get update && \
    apt-get install -y build-essential minicom make g++ python python-dev python-pip python-virtualenv ssh openssh-server git nano vim wget ca-certificates --no-install-recommends


#Install NodeJS
RUN cd /tmp && \
    wget https://node-arm.herokuapp.com/node_archive_armhf.deb && \
    dpkg -i node_archive_armhf.deb && \
    rm node_archive_armhf.deb


#Install Johnny Five and its dependencies
RUN npm update && \
    export USER=root && \
    export HOME=/tmp && \
    npm install --unsafe-perm -g johnny-five@0.9.17


#Install SSH for developer access
RUN mkdir /var/run/sshd \
    && echo 'root:root' | chpasswd \
    && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && echo "export VISIBLE=now" >> /etc/profile

RUN ln -s /usr/local/lib/node_modules/ /opt/node_modules && \
    cp /opt/node_modules/johnny-five/node_modules/serialport /opt/node_modules/ -R && \
    cp /opt/node_modules/johnny-five/node_modules/firmata /opt/node_modules/ -R
ADD /src/sample /opt/sample

#Common prebuilt npm modules for electronics
RUN cd /opt && \
    npm install -g async@1.5.2 && \
    npm install -g mqtt@1.7.0 && \
    npm install -g raspi-io@5.2.0 && \
    npm install -g express@4.13.4 && \
    npm install -g events@1.1.0 && \
    npm install -g util@0.10.3 && \
    npm install -g config@1.19.0

ENV NOTVISIBLE "in users profile"

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
