FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

# Install basic utilities and development tools
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    unzip \
    build-essential \
    python3 \
    python3-pip \
    git \
    curl \
    wget \
    nano \
    vim \
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

# Create help message
RUN echo 'echo "Welcome! You can install packages using:"' >> /home/student/.bashrc && \
    echo 'echo "  sudo apt-get update"' >> /home/student/.bashrc && \
    echo 'echo "  sudo apt-get install PACKAGE_NAME"' >> /home/student/.bashrc && \
    echo 'echo "Example: sudo apt-get install nodejs"' >> /home/student/.bashrc && \
    echo 'echo "-----------------------------------"' >> /home/student/.bashrc

# Ensure apt sources are properly set up
RUN echo "deb http://archive.ubuntu.com/ubuntu focal main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://archive.ubuntu.com/ubuntu focal-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://archive.ubuntu.com/ubuntu focal-security main restricted universe multiverse" >> /etc/apt/sources.list

# Create help message for web servers
RUN echo '# Web Server Ports Guide' > /home/student/web_ports.txt && \
    echo 'You have been allocated 10 ports for web services.' >> /home/student/web_ports.txt && \
    echo 'Student 1: Ports 8000-8009' >> /home/student/web_ports.txt && \
    echo 'Student 2: Ports 8010-8019' >> /home/student/web_ports.txt && \
    echo 'and so on...' >> /home/student/web_ports.txt && \
    echo '' >> /home/student/web_ports.txt && \
    echo 'Examples:' >> /home/student/web_ports.txt && \
    echo '1. Python Flask:' >> /home/student/web_ports.txt && \
    echo '   flask run --host=0.0.0.0 --port=8000' >> /home/student/web_ports.txt && \
    echo '' >> /home/student/web_ports.txt && \
    echo '2. Node.js:' >> /home/student/web_ports.txt && \
    echo '   node app.js   # Make sure your app listens on 0.0.0.0 and your assigned port' >> /home/student/web_ports.txt && \
    echo '' >> /home/student/web_ports.txt && \
    echo '3. Python HTTP Server:' >> /home/student/web_ports.txt && \
    echo '   python3 -m http.server 8000 --bind 0.0.0.0' >> /home/student/web_ports.txt


# Create necessary files with proper permissions
RUN touch /etc/fstab && \
    chown root:root /etc/fstab && \
    chmod 644 /etc/fstab

# Copy and extract MySecretNotes.zip
COPY MySecretNotes.zip /home/student/
RUN unzip /home/student/MySecretNotes.zip -d /home/student/ && \
    chown -R student:student /home/student/MySecretNotes* && \
    rm /home/student/MySecretNotes.zip

# Create startup script
COPY startup.sh /
RUN chmod +x /startup.sh

EXPOSE 22
CMD ["/startup.sh"]
