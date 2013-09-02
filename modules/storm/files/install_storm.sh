wget --no-check-certificate https://www.dropbox.com/s/ggcmy9hjyvq3abd/storm-installer-0.8.2_1.el6.x86_64.zip -O /tmp/storm-installer.zip 
cd /tmp
unzip storm-installer.zip 
cd /tmp/storm-installer-*
rpm -ivh *.rpm
rm -rf /tmp/storm-installer* -I -f
