FROM hypriot/rpi-node:5.3-wheezy
MAINTAINER Flavio Stutz <flaviostutz@gmail.com>

RUN apt-get update && \
    apt-get install -y build-essential make g++ python python-dev python-pip python-virtualenv ssh openssh-server git nano \
    --no-install-recommends

RUN npm update && \
    npm install -g johnny-five


RUN mkdir /var/run/sshd \
    && echo 'root:root' | chpasswd \
    && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && echo "export VISIBLE=now" >> /etc/profile

ENV NOTVISIBLE "in users profile"


EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
