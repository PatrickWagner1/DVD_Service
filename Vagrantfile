WEB_NUMBER_OF_INSTANCE = 2

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
    v.cpus = 1
  end

  config.vm.box = "ubuntu/bionic64"

  # Datenbank VM
  config.vm.define "db" do |db|
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.100.11"
  end

  # Web-Instance VM
  (0..(WEB_NUMBER_OF_INSTANCE - 1)).each do |index|
    config.vm.define "web#{index}" do |web|
      web.vm.hostname = "web#{index}"
      web.vm.network "private_network", ip: "192.168.100.#{20 + index}"
    end
  end

  # Load-Balancer VM
  config.vm.define "lb" do |lb|
    lb.vm.hostname = "lb"
    lb.vm.network "private_network", ip: "192.168.100.10"
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt update
    apt install ansible -y
  SHELL

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
  end

end
