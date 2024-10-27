# Vagrantfile
NUM_VMS = 3
SSH_BASE_PORT = 3333
WEB_BASE_PORT = 8000  # Each student gets ports 8000-8009, 8010-8019, 8020-8029

Vagrant.configure("2") do |config|
  config.ssh.username = "student"
  config.ssh.password = "student"
  config.ssh.insert_key = false

  # Disable all vagrant syncing/mounting
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.allow_fstab_modification = false
  config.vm.allow_hosts_modification = false

  (1..NUM_VMS).each do |i|
    config.vm.define "student_#{i}" do |node|
      node.vm.provider "docker" do |docker|
        docker.name = "student_#{i}"
        docker.build_dir = "."

        # Map SSH port and a range of web ports for each student
        docker.ports = [
          "127.0.0.1:#{SSH_BASE_PORT + i - 1}:22",
          # Give each student 10 ports for web services
          "127.0.0.1:#{WEB_BASE_PORT + (i-1)*10}-#{WEB_BASE_PORT + (i-1)*10 + 9}:#{WEB_BASE_PORT + (i-1)*10}-#{WEB_BASE_PORT + (i-1)*10 + 9}"
        ]

        docker.volumes = ["student_#{i}_home:/home/student"]
        docker.create_args = ["--hostname=student#{i}"]
      end
    end
  end
end
