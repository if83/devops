#!/bin/bash
#base setup
sudo -s
mkdir /var/log/vagrantlogs
LOG=/var/log/vagrantlogs/basesetup.log
yum install -y chrony 2>>$LOG
timedatectl set-timezone Europe/Kiev
systemctl start chronyd
systemctl enable chronyd

###Java download and setup
LOG=/var/log/vagrantlogs/javasetup.log
mkdir /usr/java
cd /usr/java
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.rpm"
rpm -ihv jdk-8u162-linux-x64.rpm 2>>$LOG
JAVA_HOME="/usr/java/jdk1.8.0_162"
JRE_HOME="/usr/java/jdk1.8.0_162/jre"

#Maven download and setup
LOG=/var/log/vagrantlogs/maven.log
cd /usr/java
wget http://www-eu.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz 2>>$LOG
tar xzf apache-maven-3.5.2-bin.tar.gz 2>>$LOG
ln -s apache-maven-3.5.2  maven 2>>$LOG
rm -f /usr/java/apache-maven-3.5.2-bin.tar.gz 2>>$LOG
MAVEN_HOME="/usr/java/maven"

#Setup environment variables
cd /etc/profile.d
sudo touch app.sh
APP="/etc/profile.d/app.sh"
echo "export JAVA_HOME=$JAVA_HOME" >>$APP
echo "export JRE_HOME=$JRE_HOME" >>$APP
echo "export MAVEN_HOME=$MAVEN_HOME" >>$APP
echo "export PATH=$PATH:$JAVA_HOME"/bin":$MAVEN_HOME"/bin":$JRE_HOME"/bin"" >>$APP
source /etc/profile.d/app.sh

#Setup Jenkins
cd /opt
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install -y jenkins
service jenkins start
service jenkins enable
#sleep 5
#echo 'InitialAdminPassword:  '
#cat /var/lib/jenkins/secrets/initialAdminPassword
#Opening port in the iptables
iptables -I INPUT -p tcp -m tcp --dport 8080 -j ACCEPT
