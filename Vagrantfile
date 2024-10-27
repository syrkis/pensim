NUM_VMS = 3
SSH_BASE_PORT = 3333

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
        docker.ports = ["127.0.0.1:#{SSH_BASE_PORT + i - 1}:22"]
        docker.volumes = ["student_#{i}_home:/home/student"]
        docker.create_args = ["--hostname=student#{i}"]
      end
    end
  end
end
