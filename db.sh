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
DATABASE_PASS=la_3araZa

# set password to mysql
mysqladmin --user=root --password="$TP" password "$DATABASE_PASS"

# Secure_installation_script automation (Only for mysql < 5.7)
echo "Secure_installation_script automation (for MySQL 5.6 only)"
# sudo service mysqld stop
sqlVersion=5.7
sqlVersionCurrent=$(mysql --version|awk '{ print $5 }'|awk -F\.21, '{ print $1 }')
# set passwrd to mysql

if [ "$sqlVersionCurrent" = "$sqlVersion" ]
	then
	mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"
	echo "MySQL version > 5.6"	
else
# mysql -u root -p"$DATABASE_PASS" -e "UPDATE mysql.user SET Password=PASSWORD(mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"'$DATABASE_PASS') WHERE User='root'"
	mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
	mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User=''"
	mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
	mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"
	#echo $SqlVersionCurrent
	#echo "NOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
fi

# Make MySQL connectable from outside world without SSH tunnel
echo 'bind-address=0.0.0.0' >> /etc/my.cnf
systemctl stop mysqld
systemctl start mysqld

# Create DB
echo "Creating databese: bugtrckr"
mysql -u root -p"$DATABASE_PASS" -e "CREATE DATABASE bugtrckr DEFAULT CHARSET = utf8 COLLATE = utf8_unicode_ci;"
# PRIVILEGES
mysql -u root -p"$DATABASE_PASS" -e "GRANT ALL ON bugtrckr.* TO 'bugtrckr'@'%' IDENTIFIED BY '$DATABASE_PASS';"
mysql -u root -p"$DATABASE_PASS" -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$DATABASE_PASS';"
mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

# Add tcp 3306 port to firewall
echo "Allow 3306 port"
# Restart Firewalld service
systemctl start firewalld
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload