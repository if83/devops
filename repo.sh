#!/bin/bash

###### LIST OF TOOLS ######
URLS=(
#JAVA rpm and tar.gz
--no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.rpm"
--no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"  "http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.tar.gz"
#mysql
https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
#postgresql
https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
#apache maven
http://apache.ip-connect.vn.ua/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
#tomcat
http://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.85/bin/apache-tomcat-7.0.85.tar.gz
#teamcity
https://download.jetbrains.com/teamcity/TeamCity-2017.2.2.tar.gz
)
# -- create log file --
LOG=/var/log/vagrant/repo.log

$REPO_DIR="/var/www/html/localrepo"

# -- install apps for repo creation --
APPS=(httpd createrepo yum-utils)
for i in ${APPS[@]}; do
  if yum list installed $i
  then
    echo "$i already installed" 1>$LOG
  else
    sudo yum install $i -y 2>>$LOG
  fi
done

# --start Apache --
HTTPD_CHECK=$(httpd -v)
if [[ "$HTTPD_CHECK" == *"Apache"* ]]; then
    echo "Apache Server is successfully installed!" 1>>$LOG
    UP=$(pgrep httpd | wc -l);
    if [ "$UP" -gt 0 ]; then
      echo "All is well." 1>>$LOG
    else
      echo "Apache not runing." 2>>$LOG
      sudo systemctl restart httpd
    fi
else
  sudo systemctl start httpd
  sudo systemctl enable httpd
  sudo mkdir -p /var/www/html/localrepo

  sudo sed -i 's/Options Indexes FollowSymLinks/Options All Indexes FollowSymLinks/' /etc/httpd/conf/httpd.conf
  sudo rm -rf /etc/httpd/conf.d/welcome.conf
  sudo systemctl restart httpd
fi

# -- create Repository --
sudo cd $REPO_DIR
for i in ${URLS[@]}; do
SEARCH=$(find $REPO_DIR/ -name "${i##*/}" | wc -l)
  if [[ "$SEARCH" -gt 0 ]]; then
    echo "${i##*/} exist" 1>>$LOG
  else
    sudo wget $i -P $REPO_DIR 2>>$LOG
  fi
done

sudo createrepo $REPO_DIR
