# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.keys_only = false
  config.ssh.insert_key = false
  config.vm.box = "~/virtualbox-centos7.box"
  # config.vm.box = "centos/7"
  config.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"
  #config.ssh.password = "5rav_Pe5"
  #config.network :forwarded_port, guest: 22, host: 10122, id: "ssh"
  #config.ssh.forward_agent = true

    # --- MV with Local Repository ---
  config.vm.define "repo" do |repo|
    repo.vm.hostname = "repo.local"
    repo.vm.network "private_network", ip: "192.168.56.191"
    # repo.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"

    repo.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "Repo_VM"
    end
    repo.vm.provision "shell",  path: "repo.sh"
  end

  config.vm.define "db" do |db|
    db.vm.hostname = 'db.local'
    db.vm.network "private_network", ip: "192.168.56.150"
    # db.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"

    db.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "DB_VM"
    end
    db.vm.provision "shell",  path: "db.sh"
  end

  config.vm.define "sonar" do |sonar|
    sonar.vm.hostname = 'sonar.local'
    sonar.vm.network "private_network", ip: "192.168.56.180"
    # sonar.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"

    sonar.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.name = "SONAR_VM"
    end
    sonar.vm.provision "shell",  path: "sonar.sh"
  end

  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.hostname = 'jenkins.local'
    jenkins.vm.network "private_network", ip: "192.168.56.170"
    # jenkins.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"

    jenkins.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "BLD_VM"
    end
    jenkins.vm.provision "shell",  path: "jenkins.sh"
  end

  config.vm.define "web" do |web|
    web.vm.hostname = 'web.local'
    web.vm.network "private_network", ip: "192.168.56.160"
    # web.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"

    web.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "WEB_VM"
    end
    web.vm.provision "shell",  path: "web.sh"
  end
  config.vm.provision "shell",  path: "start.sh"
end
