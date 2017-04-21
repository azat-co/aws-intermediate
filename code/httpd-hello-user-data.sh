#!/bin/bash -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1  # get just user data logs
yum update -y				# update packager, just in case the image is outdate
yum install -y httpd 		# install apache httpd
service httpd start 		# start apache httpd
chkconfig httpd on  	# start apache httpd on every start and reboot
chkconfig --list httpd	# log the status of httpd config
# the next line will add the source code, you can also pull from GitHub, or S3
echo "<html>
<h1>This is my cool HTML page</h1>
</html>" > /var/www/html/index.html
