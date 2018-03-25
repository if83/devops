#!/bin/bash

# -- add basic tools to VM --
APPS=(mc net-tools wget git tree)

if [ $UID != 0 ];
	then
# not root, use sudo # $0=./script.sh # $*=treat everything as one word # exit $?=return in bash
	echo "This script needs root privileges, would you log as sudo user?!"
   	sudo -s
fi

ping -c 5 8.8.8.8
rm -fr /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Kiev /etc/localtime
yum install -y ntpdate
ntpdate -u pool.ntp.org
echo "Time zone is set to Kiev"

#Add network hosts
 cat /vagrant/hosts.local >>/etc/hosts
 rm -f /vagrant/hosts.local

# -- add basic tools to VM --
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

rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum install -y puppetserver
sed -i '/JAVA_ARGS="-Xms2g -Xmx2g/s/2g/512m/g' /etc/sysconfig/puppetserver

echo '
autosign      = true
dns_alt_names = pmaster.if083,server
[main]
certname = pmaster.if083
server = pmaster.if083
environment = production
runinterval = 1h
' >>/etc/puppetlabs/puppet/puppet.conf

systemctl start puppetserver
systemctl enable puppetserver

systemctl start firewalld   #Just in case
firewall-cmd --permanent --zone=public --add-port=8140/tcp
firewall-cmd --reload

/opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true

/opt/puppetlabs/bin/puppet module install puppetlabs-stdlib
# after request from client: do at puppetserver:
# sudo /opt/puppetlabs/bin/puppet cert list		# to see any outstanding requests.

# # Output:
# # "client.pclient.local" (SHA256) 63:5C:F8:19:76:AE:16:A6:1C:43:12:FE:34:CE:57:EB:45:37:40:98:FF:3E:CC:FE

# sudo /opt/puppetlabs/bin/puppet cert sign <NAME>		# to sign a request


# ### at puppet master
# /opt/puppetlabs/bin/puppet cert list

# # Output:
# # "client.pclient.local" (SHA256) 63:5C:F8:19:76:AE:16:A6:1C:43:12:FE:34:CE:57:EB:45:37:40:98:FF:3E:CC:FE

# /opt/puppetlabs/bin/puppet cert sign client.pclient.local

# ## testing
# # /opt/puppetlabs/bin/puppet agent --test
# ##Output:

# # Info: Using configured environment 'production'
# # Info: Retrieving pluginfacts
# # Info: Retrieving plugin
# # Info: Caching catalog for client.pclient.local
# # Info: Applying configuration version '1472165304'
