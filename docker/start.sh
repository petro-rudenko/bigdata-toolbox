/etc/init.d/ntpd start
cat /etc/hosts >> /tmp/hosts
echo 'export NODE_COUNT=3' > /etc/profile.d/nodes.sh
export NODE_COUNT=3
/usr/sbin/sshd -D
