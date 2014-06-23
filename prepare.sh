echo "prepend domain-name-servers 8.8.8.8, 8.8.8.4;" >> /etc/dhcp/dhclient.conf
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
echo "deb https://get.docker.io/ubuntu docker main" > /etc/apt/sources.list.d/docker.list
apt-get -y update;
apt-get install -y vim wget curl bridge-utils arping python-software-properties lxc-docker
echo "limit nofile 65536 65536" >> /etc/init/docker.io.conf
echo "limit nproc unlimited unlimited" >> /etc/init/docker.io.conf
service docker.io restart
wget -O /bin/pipework https://raw.githubusercontent.com/jpetazzo/pipework/master/pipework;
chmod +x /bin/pipework;
ln -s /usr/bin/docker /usr/bin/docker.io
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
