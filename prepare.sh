apt-get -y update;
apt-get install -y vim wget curl docker.io bridge-utils arping python-software-properties 
echo "limit nofile 65536 65536" >> /etc/init/docker.io.conf
echo "limit nproc unlimited unlimited" >> /etc/init/docker.io.conf
service docker.io restart
wget -O /bin/pipework https://raw.githubusercontent.com/jpetazzo/pipework/master/pipework;
chmod +x /bin/pipework;
ln -s /usr/bin/docker.io /usr/bin/docker
cd /root
wget http://dev2.hortonworks.com.s3.amazonaws.com/stuff/ssh.tar.gz
tar xvf ssh.tar.gz
chown root:root -R .ssh
chmod 600 .ssh/id_rsa
chmod 700 .ssh


echo 'nameserver 8.8.8.8' > /etc/resolv.conf
#docker.io build --rm=true -t ambari/common .
docker.io pull prudenko/ambari
bash /vagrant/start.sh $1
