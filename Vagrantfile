NUM_VMS = 3
SSH_BASE_PORT = 2200  # Starting from 2200

Vagrant.configure("2") do |config|
  (1..NUM_VMS).each do |i|
    config.vm.define "student_#{i}" do |node|
      node.vm.provider "docker" do |docker|
        docker.name = "student_#{i}"
        docker.build_dir = "."
        
        # Expose SSH port properly
        docker.ports = ["#{SSH_BASE_PORT + i - 1}:22"]
        
        docker.volumes = [
          "student_#{i}_home:/home/student",
          "student_#{i}_opt:/opt",
          "student_#{i}_var:/var"
        ]

        docker.create_args = [
          "--hostname=student#{i}",
          "--memory=2g",
          "--memory-swap=4g",
          "--cpus=1",
          "--restart=unless-stopped",
          "--security-opt=no-new-privileges:true",
          "--ulimit", "nofile=65535:65535"
        ]

        # Ensure SSH is running
        docker.remains_running = true
        docker.has_ssh = true
      end
    end
  end
end
