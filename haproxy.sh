	#!/bin/bash
#--------------------------------
# according to https://www.upcloud.com/support/haproxy-load-balancer-centos/

HAPROXY_LiNK=https://www.haproxy.org/download/1.8/src/haproxy-1.8.4.tar.gz
# HAPROXY_LiNK=https://www.haproxy.org/download/1.7/src/haproxy-1.7.10.tar.gz 
# Lets update system
echo "Updating system...Please wait 5-10 minutes. There is some problems with repo"
sudo yum update -y --nogpgcheck >/dev/null
sudo yum install -y wget mc git net-tools.x86_64 >/dev/null

# SetTimeZone
timedatectl set-timezone Europe/Kiev
sudo yum install -y ntpdate
sudo ntpdate -u pool.ntp.org

sudo yum install gcc pcre-static pcre-devel -y
# cd /opt
wget $HAPROXY_LiNK -O /tmp/haproxy.tar.gz
tar xzvf /tmp/haproxy.tar.gz -C /tmp

HA_TAR=$(echo "$HAPROXY_LiNK"|cut -d "/" -f 7)
HA_DIR=$(echo "$HA_TAR"|cut -d'.' --complement -s -f4,5)
# cd ~/haproxy-1.8.4
cd /tmp/$HA_DIR

# This GNU Makefile supports different OS and CPU combinations.
#
# You should use it this way :
# [g]make TARGET=os ARCH=arch CPU=cpu USE_xxx=1 ...
# make TARGET=generic ARCH=native CPU=x86_64 -j8
make TARGET=linux2628
sudo make install
sudo cp /tmp/haproxy /usr/local/sbin/haproxy
sudo cp /tmp/haproxy-systemd-wrapper /usr/local/sbin/haproxy-systemd-wrapper

sudo mkdir -p /etc/haproxy
sudo mkdir -p /var/lib/haproxy
# sudo mkdir -p /run/haproxy
sudo touch /var/lib/haproxy/stats
sudo ln -s /usr/local/sbin/haproxy /usr/sbin/haproxy

# to run as a service
# cp ~/haproxy-1.8.4/examples/haproxy.init /etc/init.d/haproxy
# sudo cp /tmp/${HA_DIR}/examples/haproxy.init /etc/init.d/haproxy
# sudo chmod 755 /etc/init.d/haproxy
sudo systemctl daemon-reload
sudo chkconfig haproxy on
sudo useradd -r haproxy

# you can double check the version number
# haproxy -v
sudo systemctl start firewalld
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-port=8181/tcp
sudo firewall-cmd --reload

# configuring Layer4 balancing
# sudo echo '
# global
#    log /dev/log local0
#    log /dev/log local1 notice
#    chroot /var/lib/haproxy
#    stats timeout 30s
#    user haproxy
#    group haproxy
#    daemon

# defaults
#    log global
#    mode http
#    option httplog
#    option dontlognull
#    timeout connect 5000
#    timeout client 50000
#    timeout server 50000

# frontend http_front
#    bind *:80
#    stats uri /haproxy?stats
#    default_backend http_back

# backend http_back
#    balance roundrobin
#    server <server name> <private IP>:80 check
#    server <server name> <private IP>:80 check
#    ' > /etc/haproxy/haproxy.cfg

# # configuring Layer7 balancing
# sudo echo '
#    frontend http_front
#    bind *:80
#    stats uri /haproxy?stats
#    acl url_blog path_beg /blog
#    use_backend blog_back if url_blog
#    default_backend http_back

# backend http_back
#    balance roundrobin
#    server <server name> <private IP>:80 check
#    server <server name> <private IP>:80 check

# backend blog_back
#    server <server name> <private IP>:80 check
#    ' > /etc/haproxy/haproxy.cfg


# vi /etc/rsyslog.conf

# Uncomment this line to enable the UDP connection:

# $ModLoad imudp
# $UDPServerRun 514
