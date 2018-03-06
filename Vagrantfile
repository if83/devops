# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.keys_only = false
  config.ssh.insert_key = false
  # config.vm.box = "~/virtualbox-centos7.box"
  config.vm.box = "centos/7"
  config.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"
  #config.ssh.password = "5rav_Pe5"
  #config.network :forwarded_port, guest: 22, host: 10122, id: "ssh"
  #config.ssh.forward_agent = true

  config.vm.define "ps" do |ps|
    ps.vm.hostname = "puppet"
    ps.vm.network "private_network", ip: "192.168.56.192"
    ps.vm.provider "virtualbox" do |vb|
      ps.memory = "1024"
      ps.name = "MASTER_VM"
    end
  end

  config.vm.define "db" do |db|
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.56.150"
    db.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "DB_VM"
    end
  end

  config.vm.define "web" do |web|
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "192.168.56.160"
    web.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "WEB_VM"
    end
  end

  config.vm.provision "shell",  path: "start.sh"

  # --- VM with Sonar
  #config.vm.define "sonar" do |sonar|
  #  sonar.vm.hostname = 'sonar.local'
  #  sonar.vm.network "private_network", ip: "192.168.56.180"
  #
  #  sonar.vm.provider "virtualbox" do |vb|
  #    vb.memory = "2048"
  #    vb.name = "SONAR_VM"
  #  end
  #  sonar.vm.provision "shell",  path: "sonar.sh"
  #end


  # --- VM with Local Repository ---
  #config.vm.define "repo" do |repo|
  #  repo.vm.hostname = "repo.local"
  #  repo.vm.network "private_network", ip: "192.168.56.191"

  #  repo.vm.provider "virtualbox" do |vb|
  #    vb.memory = "512"
  #    vb.name = "Repo_VM"
  #  end
  #  repo.vm.provision "shell",  path: "repo.sh"
  #end

  # --- VM with Jenkins ---
  #config.vm.define "jenkins" do |jenkins|
  #  jenkins.vm.hostname = 'jenkins.local'
  #  jenkins.vm.network "private_network", ip: "192.168.56.170"

  #  jenkins.vm.provider "virtualbox" do |vb|
  #    vb.memory = "1024"
  #    vb.name = "BLD_VM"
  #  end
  #  jenkins.vm.provision "shell",  path: "jenkins.sh"
  #end
end
