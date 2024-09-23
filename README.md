Sim: Penetration Testing Simulation Environments

This repository contains a Vagrant configuration for creating multiple isolated penetration testing environments, ideal for educational purposes or multi-user testing scenarios.

## Overview

This setup uses Vagrant with Docker to create multiple identical containers, each representing a separate environment for individual students or testers. Each environment is isolated, allowing users to install tools and conduct tests without interfering with others.

## Prerequisites

- [Vagrant](https://www.vagrantup.com/downloads)
- [Docker](https://docs.docker.com/get-docker/)
- [Colima](https://github.com/abiosoft/colima) (Needs for this to run on my mac)
- Git

Ensure all prerequisites are installed and properly configured on your system before proceeding.

## Quick Start

1. Clone this repository:

   ```
   git clone https://github.com/syrkis/pensim.git
   cd pensim
   ```

2. Start the environments:

   ```
   vagrant up --provider=docker
   ```

3. Connect to a specific environment (replace X with a number from 1 to 10):
   ```
   ssh -p 222X vagrant@localhost
   ```
   (where X is 3 for student1, 4 for student2, and so on)

## Configuration

- The number of environments is set to 10 by default. Modify the `NUM_STUDENTS` variable in the Vagrantfile to change this.
- Each environment is based on Ubuntu 22.04 and comes with basic tools pre-installed.
- SSH ports are mapped starting from 2223 (student1) to 2232 (student10).

## Usage

- Students can install additional tools and modify their environments as needed.
- Each environment is isolated, allowing for independent work and experimentation.
- Use `vagrant halt` to stop all environments, and `vagrant destroy -f` to remove them completely.
- Also remove the docker containers with `docker rm -f $(docker ps -a -q)` and the docker images with `docker rmi $(docker images -q)`.

## Customization

- Modify the Dockerfile to add or remove pre-installed tools.
- Adjust the Vagrantfile to change network settings, resource allocation, or add shared folders.

## Security Note

This setup uses password authentication for simplicity. In a production environment, consider implementing key-based authentication and additional security measures.

## License

[MIT License](LICENSE)
