#!/bin/bash

DNS_IP='192.168.56.2'
PMASTER_IP='192.168.56.10'
PMASTER_DNAME='pmaster.if083'
# -- add basic tools to VM --
APPS=(mc net-tools wget git)

if [ $UID != 0 ];
	then
# not root, use sudo # $0=./script.sh # $*=treat everything as one word # exit $?=return in bash
	echo "This script needs root privileges, would you log as sudo user?!"
   	sudo -s
fi
       ## commented 04.20.17
# #Add network hosts
#  cat /vagrant/hosts.local >>/etc/hosts
#  rm -f /vagrant/hosts.local
       ## commented 04.20.17

#  yum -y install ntpdate
#  ntpdate 0.centos.pool.ntp.org
  ping -c 5 8.8.8.8
 rm -fr /etc/localtime
 ln -s /usr/share/zoneinfo/Europe/Kiev /etc/localtime
 yum install -y ntpdate
 ntpdate -u pool.ntp.org
  echo "Time zone is set to Kiev"

 #yum update -y

# -- install apps --
#for i in ${APPS[@]}; do
#  if yum list installed $i
#  then
#    echo "$i already installed"
#  else
#    yum install $i -y
#  fi
#done

       # uncommented 04.20.17
echo "
$PMASTER_IP    $PMASTER_DNAME
" >> /etc/hosts

echo "$HOSTNAME" > /etc/hostname
       # uncommented 04.20.17

rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm

yum install -y puppet-agent


echo "[main]
certname = $HOSTNAME
server = pmaster.if083
environment = production
runinterval = 1h
" >>/etc/puppetlabs/puppet/puppet.conf

systemctl start firewalld   #Just in case
firewall-cmd --permanent --zone=public --add-port=8140/tcp
firewall-cmd --reload

/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

       # added 04.20.17
sed -i '/plugins=/ a dns=none' /etc/NetworkManager/NetworkManager.conf
systemctl restart NetworkManager
sed -i "/search/ a nameserver $DNS_IP" /etc/resolv.conf
systemctl restart network
       # added 04.20.17

# OUTPUT:
# Notice: /Service[puppet]/ensure: ensure changed 'stopped' to 'running'
# service { 'puppet':
#   ensure => 'running',
#   enable => 'true',
# }

### at puppet master
# /opt/puppetlabs/bin/puppet cert list

# # Output:
# # "client.pclient.local" (SHA256) 63:5C:F8:19:76:AE:16:A6:1C:43:12:FE:34:CE:57:EB:45:37:40:98:FF:3E:CC:FE

# /opt/puppetlabs/bin/puppet cert sign pclient.local

## testing
#/opt/puppetlabs/bin/puppet agent --test
##Output:

# Info: Using configured environment 'production'
# Info: Retrieving pluginfacts
# Info: Retrieving plugin
# Info: Caching catalog for pclient.local
# Info: Applying configuration version '1472165304'
