wget --no-check-certificate https://www.dropbox.com/s/epqvs0bfad41xa1/storm-installer-0.9.0-1.el6.x86_64.zip -O /tmp/storm-installer.zip 
cd /tmp
unzip storm-installer.zip 
cd /tmp/storm-installer-*
rpm -ivh *.rpm
rm -rf /tmp/storm-installer* -I -f
