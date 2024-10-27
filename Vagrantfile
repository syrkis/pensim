NUM_VMS = 3
BASE_PORT = 8080
SSH_BASE_PORT = 2222  # Base port for SSH

Vagrant.configure("2") do |config|
  (1..NUM_VMS).each do |i|
    config.vm.define "student_#{i}" do |node|
      node.vm.provider "docker" do |docker|
        docker.name = "student_#{i}"
        docker.build_dir = "."
        docker.has_ssh = true
        
        # Additional volumes for specific purposes
        docker.volumes = [
          "student_#{i}_home:/home/student",
          "student_#{i}_opt:/opt",
          "student_#{i}_var:/var"
        ]

        # Resource limits
        docker.create_args = [
          "--hostname=student#{i}",
          "--memory=2g",
          "--memory-swap=4g",
          "--cpus=1",
          "--restart=unless-stopped",
          "--security-opt=no-new-privileges:true",
          "--ulimit", "nofile=65535:65535"
        ]

        # Expose SSH port
        docker.ports = ["#{SSH_BASE_PORT + i - 1}:22"]
      end
    end
  end
end
