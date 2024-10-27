Vagrant.configure("2") do |config|
  (1..NUM_VMS).each do |i|
    config.vm.define "student_#{i}" do |node|
      node.vm.provider "docker" do |docker|
        docker.name = "student_#{i}"
        
        # Additional volumes for specific purposes
        docker.volumes = [
          "student_#{i}_home:/home/student",
          "student_#{i}_opt:/opt",        # For additional software
          "student_#{i}_var:/var"         # For logs and variable data
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
      end
    end
  end
end
