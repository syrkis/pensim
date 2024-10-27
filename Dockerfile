FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Setup SSH properly
RUN mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Create and configure student user
RUN useradd -m -s /bin/bash student && \
    echo "student:student" | chpasswd && \
    adduser student sudo && \
    echo "student ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create necessary files with proper permissions
RUN touch /etc/fstab && \
    chown root:root /etc/fstab && \
    chmod 644 /etc/fstab

# Create startup script
COPY startup.sh /
RUN chmod +x /startup.sh

EXPOSE 22
CMD ["/startup.sh"]
