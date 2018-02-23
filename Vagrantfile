# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.keys_only = false
  config.ssh.insert_key = false
  config.vm.box = "centos/7"
  config.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"
  #config.ssh.password = "5rav_Pe5"

    # --- MV with Local Repository ---
  config.vm.define "repo" do |repo|
    repo.vm.hostname = "repo.local"
    repo.vm.network "private_network", ip: "192.168.56.191"
    # repo.vm.network :forwarded_port, guest: 22, host: 10122, id: "ssh"
    # web.ssh.forward_agent = true

    repo.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "Repo_VM"
    end

    repo.vm.provision "shell",  path: "repo.sh"
  end

  config.vm.define "db" do |db|
    db.vm.hostname = 'db.local'
    db.vm.network "private_network", ip: "192.168.56.150"
    # web.vm.network :forwarded_port, guest: 22, host: 10122, id: "ssh"
    # web.ssh.forward_agent = true

    db.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "DB_VM"
    end

    db.vm.provision "shell",  path: "db.sh"
  end

  config.vm.define "sonar" do |sonar|
    sonar.vm.hostname = 'sonar.local'
    sonar.vm.network "private_network", ip: "192.168.56.180"
    # db.vm.network :forwarded_port, guest: 22, host: 10222, id: "ssh"
    # db.ssh.forward_agent = true

    sonar.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.name = "SONAR_VM"
    end

    sonar.vm.provision "shell",  path: "sonar.sh"
  end

  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.hostname = 'jenkins.local'
    jenkins.vm.network "private_network", ip: "192.168.56.170"
    # db.vm.network :forwarded_port, guest: 22, host: 10222, id: "ssh"
    # db.ssh.forward_agent = true

    jenkins.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "BLD_VM"
    end

    jenkins.vm.provision "shell",  path: "jenkins.sh"
  end

  config.vm.define "web" do |web|
    web.vm.hostname = 'web.local'
    web.vm.network "private_network", ip: "192.168.56.160"
    # db.vm.network :forwarded_port, guest: 22, host: 10222, id: "ssh"
    # db.ssh.forward_agent = true

    web.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "WEB_VM"
    end
    web.vm.provision "shell",  path: "web.sh"
  end

  config.vm.provision "shell",  path: "start.sh"
end
