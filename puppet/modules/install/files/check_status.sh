#!/bin/bash
while [ 1 ]
do
    tasks=`curl -s -u admin:admin -H 'X-Requested-By: ambari' 'http://ambari.hortonworks.com:8080/api/v1/clusters/Sandbox/requests/1?fields=tasks/Tasks/*'|python check_status.py`
    status=$?
    if [[ $status -eq 0 ]]
    then
        exit
    elif [[ $status -eq 2 ]]
    then
        exit 1;
    else
        echo $tasks;
        sleep 15
    fi
done


