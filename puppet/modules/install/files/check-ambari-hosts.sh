#!/bin/bash
source /etc/profile.d/nodes.sh
while [ 1 ]
do
    hosts=`curl -H 'X-Requested-By: ambari' -u admin:admin 'ambari.hortonworks.com:8080/api/v1/hosts' |python /tmp/install/check_hosts.py`
    if [[ $? -eq 0 ]]
    then
        exit
    else
        sleep 5
    fi
done
