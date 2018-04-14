# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.keys_only = false
  config.ssh.insert_key = false
  config.vm.box = "centos/7"
  config.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"

  # --- VM for Puppet Master ---
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

  # --- VM with DNS Server ---
  config.vm.define "dns" do |dns|
    dns.vm.hostname = 'dns.if083'
    dns.vm.network "private_network", ip: "192.168.56.2"
    dns.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "DNS_VM"
    end
    dns.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM with Rsyslog Server ---
  config.vm.define "rsyslog" do |rsyslog|
    rsyslog.vm.hostname = 'rsyslog.if083'
    rsyslog.vm.network "private_network", ip: "192.168.56.15"
    rsyslog.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "2"
      vb.name = "RSYSLOG_VM"
    end
    rsyslog.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM with Main Database ---
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


  # --- VM with Database Repication ---
  config.vm.define "dbslave" do |dbslave|
    dbslave.vm.hostname = 'dbslave.if083'
    dbslave.vm.network "private_network", ip: "192.168.56.151"
    dbslave.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "DBSLAVE_VM"
    end
    dbslave.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM with Load Balancer ---
  config.vm.define "balancer" do |lb|
    lb.vm.hostname = 'balancer.if083'
    lb.vm.network "private_network", ip: "192.168.56.160"
    lb.vm.network "forwarded_port", guest: 80, host: 80
    lb.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "BALANCER_VM"
    end
    lb.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM #1 with Web Application ---
  config.vm.define "web1" do |web1|
    web1.vm.hostname = 'web1.if083'
    web1.vm.network "private_network", ip: "192.168.56.161"
    web1.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "WEB_VM_1"
    end
    web1.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM #2 with Web Application ---
  config.vm.define "web2" do |web2|
    web2.vm.hostname = 'web2.if083'
    web2.vm.network "private_network", ip: "192.168.56.162"
    web2.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "WEB_VM_2"
    end
    web2.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM #3 with Web Application ---
  config.vm.define "web3" do |web3|
    web3.vm.hostname = 'web3.if083'
    web3.vm.network "private_network", ip: "192.168.56.163"
    web3.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "WEB_VM_3"
    end
    web3.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM with Jenkins ---
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.hostname = 'jenkins.if083'
    jenkins.vm.network "private_network", ip: "192.168.56.170"
    jenkins.vm.network "forwarded_port", guest: 56170, host: 8080
    jenkins.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "2"
      vb.name = "Jenkins_VM"
    end
    jenkins.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM with SonarQube ---
  config.vm.define "sonar" do |sonar|
    sonar.vm.hostname = 'sonar.if083'
    sonar.vm.network "private_network", ip: "192.168.56.180"
    sonar.vm.network "forwarded_port", guest: 56180, host: 9000
    sonar.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "2"
      vb.name = "SONAR_VM"
    end
    sonar.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM with Local Repository ---
  config.vm.define "repo" do |repo|
    repo.vm.hostname = "repo.if083"
    repo.vm.network "private_network", ip: "192.168.56.191"

    repo.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "REPO_VM"
    end
    repo.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM with Zabbix ---
  config.vm.define "zabbix" do |zabbix|
    zabbix.vm.hostname = 'zabbix.if083'
    zabbix.vm.network "private_network", ip: "192.168.56.200"
    zabbix.vm.network "forwarded_port", guest: 56200, host: 80
    zabbix.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "2"
      vb.name = "ZABBIX_VM"
    end
    zabbix.vm.provision "shell",  path: "pclient.sh"
  end
end
