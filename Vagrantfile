# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.keys_only = false
  config.ssh.insert_key = false
  config.vm.box = "centos/7"
  config.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"

  config.vm.define "pmaster" do |pmaster|
    pmaster.vm.hostname = 'pmaster.if083'
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
    repo.vm.hostname = "repo.if083"
    repo.vm.network "private_network", ip: "192.168.56.191"

    repo.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "Repo_VM"
    end
    repo.vm.provision "shell",  path: "pclient.sh"
  end

  config.vm.define "db" do |db|
    db.vm.hostname = 'db.if083'
    db.vm.network "private_network", ip: "192.168.56.150"

    db.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "DB_VM"
    end
    db.vm.provision "shell",  path: "pclient.sh"
  end

  config.vm.define "dbslave" do |dbslave|
    dbslave.vm.hostname = 'dbslave.if083'
    dbslave.vm.network "private_network", ip: "192.168.56.151"

    dbslave.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "DBSlave_VM"
    end
    dbslave.vm.provision "shell",  path: "pclient.sh"
  end

  config.vm.define "sonar" do |sonar|
    sonar.vm.hostname = 'sonar.if083'
    sonar.vm.network "private_network", ip: "192.168.56.180"

    sonar.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "2"
      vb.name = "SONAR_VM"
    end
    sonar.vm.provision "shell",  path: "pclient.sh"
  end

  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.hostname = 'jenkins.if083'
    jenkins.vm.network "private_network", ip: "192.168.56.170"

    jenkins.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "2"
      vb.name = "Jenkins_VM"
    end
    jenkins.vm.provision "shell",  path: "pclient.sh"
  end

  config.vm.define "web1" do |web1|
    web1.vm.hostname = 'web1.if083'
    web1.vm.network "private_network", ip: "192.168.56.161"
    
    web1.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "WEB1_VM"
    end
    web1.vm.provision "shell",  path: "pclient.sh"
  end

  config.vm.define "web2" do |web2|
    web2.vm.hostname = 'web2.if083'
    web2.vm.network "private_network", ip: "192.168.56.162"
    
    web2.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "WEB2_VM"
    end
    web2.vm.provision "shell",  path: "pclient.sh"
  end

  config.vm.define "balancer" do |balancer|
    balancer.vm.hostname = 'balancer.if083'
    balancer.vm.network "private_network", ip: "192.168.56.160"
    
    balancer.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "Balancer_VM"
    end
    balancer.vm.provision "shell",  path: "pclient.sh"
  end

  config.vm.define "zabbix" do |zabbix|
    zabbix.vm.hostname = 'zabbix.if083'
    zabbix.vm.network "private_network", ip: "192.168.56.200"

    zabbix.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "2"
      vb.name = "Zabbix_VM"
    end
    zabbix.vm.provision "shell",  path: "pclient.sh"
  end

end
