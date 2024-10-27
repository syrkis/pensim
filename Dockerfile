FROM ubuntu:20.04

# Set noninteractive installation

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home

# Copy the secret notes app
COPY MySecretNotes.zip /home/
RUN apt-get update && apt-get install -y unzip
RUN unzip MySecretNotes.zip

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
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# Create student user
RUN useradd -m -s /bin/bash student && \
    echo "student:student" | chpasswd && \
    adduser student sudo

# Ensure the student directory persists
VOLUME ["/home/student"]

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
