#!/bin/bash
#base setup
sudo mkdir /var/log/vagrantlogs
LOG=/var/log/vagrantlogs/basesetup.log
sudo yum install -y chrony 2>>$LOG
sudo timedatectl set-timezone Europe/Kiev
sudo systemctl start chronyd
sudo systemctl enable chronyd
###Java download and setup
LOG=/var/log/vagrantlogs/javasetup.log
sudo mkdir /usr/java
cd /usr/java
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.rpm"
sudo rpm -ihv jdk-8u162-linux-x64.rpm 2>>$LOG
JAVA_HOME="/usr/java/jdk1.8.0_162"
JRE_HOME="/usr/java/jdk1.8.0_162/jre"
#Maven download and setup
LOG=/var/log/vagrantlogs/maven.log
cd /usr/java
wget http://www-eu.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz 2>>$LOG
sudo tar xzf apache-maven-3.5.2-bin.tar.gz 2>>$LOG
sudo ln -s apache-maven-3.5.2  maven 2>>$LOG
rm -f /usr/java/apache-maven-3.5.2-bin.tar.gz 2>>$LOG
MAVEN_HOME="/usr/java/maven"
#Setup environment variables
cd /etc/profile.d
sudo touch app.sh
APP="/etc/profile.d/app.sh"
sudo echo "export JAVA_HOME=$JAVA_HOME" >>$APP
sudo echo "export JRE_HOME=$JRE_HOME" >>$APP
sudo echo "export MAVEN_HOME=$MAVEN_HOME" >>$APP
sudo echo "export PATH=$PATH:$JAVA_HOME"/bin":$MAVEN_HOME"/bin":$JRE_HOME"/bin"" >>$APP
source /etc/profile.d/app.sh
#Setup Jenkins
cd /opt
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install -y jenkins
sudo service jenkins start
sudo service jenkins enable
#sleep 5
#sudo -s
#echo 'InitialAdminPassword:  '
#cat /var/lib/jenkins/secrets/initialAdminPassword
#Opening port in the iptables
iptables -I INPUT -p tcp -m tcp --dport 8080 -j ACCEPT
