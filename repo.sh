#!/bin/bash

###### START INSTALLATION ######

# -- add tools --
APPS=(httpd createrepo)

# -- create log file --
LOG=/var/log/vagrant/repo.log

# -- install apps --
for i in ${APPS[@]}; do
  if yum list installed $i
  then
    echo "$i already installed" 1>$LOG
  else
    sudo yum install $i -y 2>>$LOG
  fi
done

# --start Apache --

sudo systemctl start httpd
sudo systemctl enable httpd
sudo mkdir -p /var/www/html/local_yum_repo

sudo sed -i 's/Options Indexes FollowSymLinks/Options All Indexes FollowSymLinks/' /etc/httpd/conf/httpd.conf
sudo rm -rf /etc/httpd/conf.d/welcome.conf
sudo systemctl restart httpd

# -- create Repository --
$YUM_REPO_DIR=""
sudo cd /var/www/html/local_yum_repo
sudo wget https://www.nano-editor.org/dist/v2.2/RPMS/nano-2.2.6-1.x86_64.rpm -P /var/www/html/local_yum_repo
sudo createrepo /var/www/html/local_yum_repo
