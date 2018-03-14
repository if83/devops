# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.keys_only = false
  config.ssh.insert_key = false
  #config.ssh.dsa_authentication = false
  # config.vm.box = "~/virtualbox-centos7.box"
  config.vm.box = "centos/7"
  config.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"
  #config.ssh.password = "vagrant"
  #config.network :forwarded_port, guest: 22, host: 10122, id: "ssh"
  #config.ssh.forward_agent = true

  config.vm.define "pmaster" do |pmaster|
    pmaster.vm.hostname = 'pmaster.local'
    pmaster.vm.network "private_network", ip: "192.168.56.10"

    pmaster.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "2"
      vb.name = "MasterOfPuppet_VM"
    end
    pmaster.vm.provision "shell",  path: "pmaster.sh"
  end
  
  # --- MV with Local Repository ---
  config.vm.define "repo" do |repo|
    repo.vm.hostname = "repo.local"
    repo.vm.network "private_network", ip: "192.168.56.191"

    repo.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "Repo_VM"
    end
    repo.vm.provision "shell",  path: "pclient.sh"
  end

  config.vm.define "db" do |db|
    db.vm.hostname = 'db.local'
    db.vm.network "private_network", ip: "192.168.56.150"

    db.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "DB_VM"
    end
    db.vm.provision "shell",  path: "db.sh"
  end

  #config.vm.define "sonar" do |sonar|
    #sonar.vm.hostname = 'sonar.local'
    #sonar.vm.network "private_network", ip: "192.168.56.180"

    #sonar.vm.provider "virtualbox" do |vb|
      #vb.memory = "2048"
      #vb.cpus = "2"
      #vb.name = "SONAR_VM"
    #end
    #sonar.vm.provision "shell",  path: "pclient.sh"
  #end

  #config.vm.define "jenkins" do |jenkins|
    #jenkins.vm.hostname = 'jenkins.local'
    #jenkins.vm.network "private_network", ip: "192.168.56.170"

    #jenkins.vm.provider "virtualbox" do |vb|
      #vb.memory = "1024"
      #vb.cpus = "2"
      #vb.name = "Jenkins_VM"
    #end
    #jenkins.vm.provision "shell",  path: "pclient.sh"
  #end

  config.vm.define "web" do |web|
    web.vm.hostname = 'web.local'
    web.vm.network "private_network", ip: "192.168.56.160"
    
    web.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "WEB_VM"
    end
    web.vm.provision "shell",  path: "pclient.sh"
  end

  config.vm.define "zabbix" do |zabbix|
    zabbix.vm.hostname = 'zabbix.local'
    zabbix.vm.network "private_network", ip: "192.168.56.200"

    zabbix.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "2"
      vb.name = "Zabbix_VM"
    end
    zabbix.vm.provision "shell",  path: "pclient.sh"
  end

end
