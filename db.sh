###################################################
#	MySQL PgSQL  installation  script	  		  
###################################################
#variables										  
#=================================================#
IP="192.168.56.150/32"
SONAR_DB="sonar"
SONAR_USR="sonarqube"
SONAR_PASS="J0benB0ben"
SONAR_HOST="192.168.56.180/32"
PG_ADM_PASS="N3WP@55"
SQL_ALLOWED="192.168.56.160,192.168.56.170"

###################################################
#		PgSQL SECTION		  	  
###################################################
sudo -s
yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum install -y postgresql96
yum install -y postgresql96-server
/usr/pgsql-9.6/bin/postgresql96-setup initdb
systemctl enable postgresql-9.6
systemctl start postgresql-9.6
chkconfig postgresql on
echo "ALTER USER postgres WITH PASSWORD '${PG_ADM_PASS}';" | sudo -u postgres psql

###################################################
#				ALLOW user LOGIN remotely  	  	  #
###################################################
echo "!PgSQL section started!"
#Create sonar user and DB
sudo -u postgres createuser $SONAR_USR
sudo -u postgres createdb  -O $SONAR_USR $SONAR_DB
echo "ALTER USER $SONAR_USR with encrypted password '$SONAR_PASS';" | sudo -u postgres psql
iptables -I INPUT -p tcp -s $SONAR_HOST --dport 5432 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -I OUTPUT -p tcp --sport 5432 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#tuning configs
file='/var/lib/pgsql/9.6/data/pg_hba.conf'
MATCH='# IPv4 local connections:'
INSERT="host    $SONAR_DB             $SONAR_USR             $SONAR_HOST            md5"
sed -i "/$MATCH/a$INSERT" $file

file='/var/lib/pgsql/9.6/data/postgresql.conf'
MATCH='#port = 5432'
INSERT='port = 5432'
sed -i "s/$MATCH/$INSERT/g" $file

MATCH="#listen_addresses = 'localhost'"
INSERT="listen_addresses = '*'"
sed -i "s/$MATCH/$INSERT/g" $file

systemctl restart postgresql-9.6

###################################################
#				MySQL section 				  	  #
###################################################
echo "!MySQL section started!"
cd /opt
MYSQL_RELEASE_FILE="mysql57-community-release-el7-11.noarch.rpm" 
wget https://dev.mysql.com/get/$MYSQL_RELEASE_FILE
rpm -ivh $MYSQL_RELEASE_FILE
yum install -y mysql-server
rm -r $MYSQL_RELEASE_FILE
systemctl start mysqld
#get mysql root pass from mysqld.log
TP=$(grep 'temporary password' /var/log/mysqld.log|cut -d ":" -f 4|cut -d ' ' -f 2)

#securing MySQL
mysql -uroot  --connect-expired-password -p$(echo $TP) -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$TP';"
mysql -uroot  -p$(echo $TP) -e "delete from mysql.db where Db like 'test%';"
mysql -uroot  -p$(echo $TP) -e "flush privileges;"
#save MySQL root password 
echo $TP>/opt/tp.txt
echo "Mysql section FINISHED!!"
iptables -I INPUT -p tcp -s $SQL_ALLOWED --dport 3306 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -I OUTPUT -p tcp --sport 3306 -m conntrack --ctstate ESTABLISHED -j ACCEPT
history -c
