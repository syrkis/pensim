# mode: ruby -*-
# vi: set ft=ruby :

NUM_STUDENTS = 2

Vagrant.configure("2") do |config|
  (1..NUM_STUDENTS).each do |i|
    config.vm.define "student#{i}" do |node|
      node.vm.provider "docker" do |d|
        d.build_dir = "."
        d.name = "vagrant_pensim_student#{i}"
        d.has_ssh = true
        d.remains_running = true
        d.ports = ["#{2222 + i}:22"]
      end

      node.vm.network "forwarded_port", guest: 22, host: 2222 + i

      # Specify SSH settings
      node.ssh.username = "vagrant"
      node.ssh.password = "vagrant"
      node.ssh.insert_key = false

      node.vm.provision "shell", inline: <<-SHELL
        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
        service ssh restart
        echo "This is student#{i}'s machine" > /home/vagrant/student_info.txt
      SHELL
    end
  end
end
