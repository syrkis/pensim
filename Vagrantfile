# -*- mode: ruby -*-
# vi: set ft=ruby :

NUM_STUDENTS = 2
BASE_SSH_PORT = 2222

Vagrant.configure("2") do |config|
  (1..NUM_STUDENTS).each do |i|
    config.vm.define "student#{i}" do |node|
      node.vm.provider "docker" do |d|
        d.build_dir = "."
        d.name = "vagrant_pensim_student#{i}"
        d.has_ssh = true
        d.remains_running = true
        d.ports = ["127.0.0.1:#{BASE_SSH_PORT + i}:22"]
      end

      # Configure SSH to use password authentication
      node.ssh.username = "vagrant"
      node.ssh.password = "vagrant"
      node.ssh.insert_key = false

      # Provision the container
      node.vm.provision "shell", inline: <<-SHELL
        echo "This is student#{i}'s machine" > /home/vagrant/student_info.txt
        echo "Student #{i} can login with:"
        echo "ssh -p #{BASE_SSH_PORT + i} vagrant@localhost"
        echo "Password: vagrant"
      SHELL
    end
  end
end
