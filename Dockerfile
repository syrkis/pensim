FROM ubuntu:22.04

RUN apt-get update && apt-get install -y openssh-server sudo python3 python3-pip sqlite3 git
RUN mkdir /var/run/sshd
RUN echo 'root:vagrant' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN useradd -m -s /bin/bash vagrant
RUN echo "vagrant:vagrant" | chpasswd
RUN echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant

RUN mkdir -p /home/vagrant/.ssh
RUN chmod 700 /home/vagrant/.ssh
RUN chown -R vagrant:vagrant /home/vagrant/.ssh

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
