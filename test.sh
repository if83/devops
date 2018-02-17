#!/bin/bash

sudo mv /etc/yum.repos.d/*.repo /tmp/
sudo touch "/etc/yum.repos.d/remove.repo"

cat >> /etc/yum.repos.d/remove.repo <<EOF
[remote]
name=RHEL Apache
baseurl=http://192.168.56.111/local_yum_repo/
enabled=1
gpgcheck=0
EOF
