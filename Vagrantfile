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

  # --- VM with Main Database ---
  config.vm.define "db" do |db|
    db.vm.hostname = 'db.if083'
    db.vm.network "private_network", ip: "192.168.56.150"

    db.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "DB_VM"
    end
    db.vm.provision "shell",  path: "db.sh"
  end

  # --- VM with Database Repication ---
  config.vm.define "dbslave" do |db|
    db.vm.hostname = 'dbslave.if083'
    db.vm.network "private_network", ip: "192.168.56.151"

    db.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "DB_VM"
    end
    db.vm.provision "shell",  path: "db.sh"
  end

  # --- VM with Load Balanser ---
  config.vm.define "balanser" do |lb|
    db.vm.hostname = 'balanser.if083'
    db.vm.network "private_network", ip: "192.168.56.160"

    db.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "DB_SLAVE_VM"
    end
    db.vm.provision "shell",  path: "db.sh"
  end

  # --- VM #1 with Web Application ---
  config.vm.define "web1" do |web|
    web.vm.hostname = 'web1.if083'
    web.vm.network "private_network", ip: "192.168.56.161"

    web.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "WEB_VM_1"
    end
    web.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM #2 with Web Application ---
  config.vm.define "web2" do |web|
    web.vm.hostname = 'web2.if083'
    web.vm.network "private_network", ip: "192.168.56.162"

    web.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "WEB_VM_2"
    end
    web.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM #3 with Web Application ---
  config.vm.define "web3" do |web|
    web.vm.hostname = 'web3.if083'
    web.vm.network "private_network", ip: "192.168.56.163"

    web.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "WEB_VM_3"
    end
    web.vm.provision "shell",  path: "pclient.sh"
  end

  # --- VM with Jenkins ---
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

  # --- VM with SonarQube ---
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

  # --- VM with GitLab ---
  config.vm.define "gitlab" do |repo|
    repo.vm.hostname = "gitlab.if083"
    repo.vm.network "private_network", ip: "192.168.56.190"

    repo.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "2"
      vb.name = "GITLAB_VM"
    end
    repo.vm.provision "shell",  path: "pclient.sh"
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

    zabbix.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "2"
      vb.name = "ZABBIX_VM"
    end
    zabbix.vm.provision "shell",  path: "pclient.sh"
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
end
