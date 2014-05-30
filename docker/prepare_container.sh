yum update -y
yum install -y openssh-server openssh-clients wget tar sudo perl ntp git redhat-lsb
sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
echo 'root:hadoop' | chpasswd 
echo "UseDNS no" >> /etc/ssh/sshd_config
echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config
cd /root
wget http://dev2.hortonworks.com.s3.amazonaws.com/stuff/ssh.tar.gz
tar xvf ssh.tar.gz
chown root:root -R .ssh
chmod 600 .ssh/id_rsa
chmod 700 .ssh
ln -s /root/.ssh/id_rsa /etc/ssh/ssh_host_rsa_key
rm -f ssh.tar.gz
#service iptables stop
#service ip6tables stop
#setenforce 0
perl -pi -e 's:/etc/hosts:/tmp/hosts:g' /lib64/libnss_files.so.2
rpm -ivh https://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm
yum install -y puppet
cd /tmp
git clone https://github.com/petro-rudenko/bigdata-toolbox.git
ln -s bigdata-toolbox/puppet .
#chconfig ip6tables off
#cd ../; rm -rf /tmp/*;
