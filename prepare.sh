apt-get -y update;
apt-get install -y vim wget curl docker.io bridge-utils arping;
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
docker.io run -d --name ambari -P -h ambari.hortonworks.com prudenko/ambari
sleep 5;      
pipework br1 ambari 192.168.1.1/24;
ip addr add 192.168.1.254/24 dev br1
command="cd /tmp/bigdata-toolbox && git pull; \
export FACTER_nodecount=3 && \
export FACTER_stack=gluster && \
puppet apply --verbose --modulepath=\"/tmp/puppet/modules\" --detailed-exitcodes /tmp/puppet/manifests/init.pp"


for i in `seq 2 3`
do
    name="host$i"
    docker.io run -d --name $name -h $name.hortonworks.com prudenko/ambari
    pipework br1 $name 192.168.1.$i/24
    ssh -oStrictHostKeyChecking=no root@192.168.1.$i echo 'export FACTER_role=slaves &&' $command > /var/log/host$i.log &
done


ssh -oStrictHostKeyChecking=no root@192.168.1.1 echo 'export FACTER_role=ambari &&' $command
