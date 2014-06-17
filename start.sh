ambari=$(docker.io run -d -p 8080:8080 -p 8000:8000 -p 8088:8088 -p 2223:22 -h ambari.hortonworks.com prudenko/ambari)
sleep 5;      
pipework br1 $ambari 192.168.1.1/24;
ip addr add 192.168.1.254/24 dev br1
command="cd /tmp/bigdata-toolbox && git pull &&\
export FACTER_nodecount=3 && \
export FACTER_stack=$1 && \
puppet apply --verbose --debug --modulepath=\"/tmp/puppet/modules\" --detailed-exitcodes /tmp/puppet/manifests/init.pp"


for i in `seq 2 3`
do
    name=$(docker.io run -d -h host$i.hortonworks.com prudenko/ambari)
    pipework br1 $name 192.168.1.$i/24
    com1='export FACTER_role=slaves && '$command
    ssh -oStrictHostKeyChecking=no root@192.168.1.$i $com1 > /var/log/host$i.log &
done

com2='export FACTER_role=ambari && '$command
ssh -oStrictHostKeyChecking=no root@192.168.1.1  $com2
