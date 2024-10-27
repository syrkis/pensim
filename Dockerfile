FROM ubuntu:20.04

WORKDIR /home

# Install basic utilities and SSH server
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    vim \
    curl \
    wget \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Setup SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Create student user with sudo privileges
RUN useradd -m -s /bin/bash student && \
    echo "student:student" | chpasswd && \
    adduser student sudo

# Ensure the student directory persists
VOLUME ["/home/student"]

# Expose SSH port
EXPOSE 22

# Start SSH server
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
