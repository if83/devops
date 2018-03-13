#!/bin/bash

PMASTER_IP='192.168.56.10'
PMASTER_DNAME='pmaster.local'
HOSTNAME='pclient.local'
# -- add basic tools to VM --
APPS=(mc net-tools wget git)

if [ $UID != 0 ];
	then
# not root, use sudo # $0=./script.sh # $*=treat everything as one word # exit $?=return in bash
	if [ $UID = 0 ] && [ ! -z "$SUDO_USER" ];
		then
		echo "This script needs root privileges, would you log as sudo user?!"
    	sudo -s
	else
		USER="$(whoami)"
		sudo "${SHELL}" "$0" $*
		exit $?
	fi
fi

#  yum -y install ntpdate
#  ntpdate 0.centos.pool.ntp.org
  ping -c 5 8.8.8.8 
 rm -fr /etc/localtime 
 ln -s /usr/share/zoneinfo/Europe/Kiev /etc/localtime 
 yum install -y ntpdate 
 ntpdate -u pool.ntp.org 
  echo "Time zone is set to Kiev" 

 yum update -y

# -- install apps --
for i in ${APPS[@]}; do
  if yum list installed $i
  then
    echo "$i already installed"
  else
    yum install $i -y
  fi
done

echo "
$PMASTER_IP    $PMASTER_DNAME
" >> /etc/hosts

rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm

yum install -y puppet-agent


echo "[main]
certname = $(cat /etc/hostname)
server = pmaster.local
environment = production
runinterval = 1h
" >>/etc/puppetlabs/puppet/puppet.conf

systemctl start firewalld   #Just in case
firewall-cmd --permanent --zone=public --add-port=8140/tcp
firewall-cmd --reload

/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

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
/opt/puppetlabs/bin/puppet agent --test
##Output:

# Info: Using configured environment 'production'
# Info: Retrieving pluginfacts
# Info: Retrieving plugin
# Info: Caching catalog for pclient.local
# Info: Applying configuration version '1472165304'

