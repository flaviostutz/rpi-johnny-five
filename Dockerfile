FROM hypriot/rpi-iojs:1.4.1
MAINTAINER Flavio Stutz <flaviostutz@gmail.com>

RUN apt-get update && \
    apt-get install -y python python-dev python-pip python-virtualenv ssh openssh-server git ca-certificates \
    --no-install-recommends

RUN npm update && \
    npm install johnny-five


RUN mkdir /var/run/sshd \
    && echo 'root:root' | chpasswd \
    && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && echo "export VISIBLE=now" >> /etc/profile

ENV NOTVISIBLE "in users profile"


RUN rm -rf /var/lib/apt/lists/

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
