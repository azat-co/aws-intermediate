# Lab 1: Power to AWS CLI

# Task

Task: Install AWS CLI, configure, create an instance with apache httpd via AWS CLI and no SSH, and then make the HTML page (hello world) visible in the browser *publicly*.


# Walk-through

If you would like to attempt the task, then skip the walk-through and go for the task directly. However, if you need a little bit more hand holding or you would like to look up some of the commands or code or settings, then follow the walk-through.

1. Form user data
3. Create security group
3. Create key pair
4. Find AMI ID (instance ID)
5. Launch instances
6. Get public IP and test

All commands have been designed for us-west-1. If you are using a different region, you need to modify accordingly. For example, your AMI ID will be different.

And yes, please do NOT use the AWS web console. You may logout from there now.

You can run commands manually or create a shell script which automates the whole process (recommended). To run a shell script, you just need to execute:

```
sh ./provision-hello-world.sh
```

## 1. Form user data

To be able to run HTTP server on an instance to which you don't have an SSH access, you will need to automate the installation of two things: 

* Apache httpd web server
* HTML page with Hello World

Both of the items can be put in User Data which will be run once on the instance launch. 

You can see below an example of how your user data might look like. If you copy from here, make sure you do NOT have syntax issues and include the shebang sign (`#`):

```
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
```

Feel free to be creative and edit the HTML code. For example,

```
echo "<html>
<h1>This is my cool HTML page. I'm a web developer now.</h1>
</html>" > /var/www/html/index.html
```

Save your user data into `httpd-hello-user-data.sh`. (If you are struggling with syntax, there's a ready-to-use and tested file for you in code/httpd-hello-user-data.sh.)

## 2. Create security group

The next step will ensure you (and other people who want to see your page) can access the EC2 instance. Create a security group which has these open:

* HTTP 80 inbound
* All outbound

Make sure there's no SSH access to the instance (the principle of lease needed privileges, see security pillar in AWS Well-Architectured Framework). Do not use AWS web console. Use only AWS CLI tool.

Here are some of the commands. Create a security group:

```
aws ec2 create-security-group --group-name \
  http-sg --description "HTTP security group"
```

You can write down the group number but you don't have to. The group name will be enough to refer to it.

Open inbound port 80 HTTP from anywhere:

```
aws ec2 authorize-security-group-ingress \
  --group-name http-sg --protocol tcp --port 80 --cidr 0.0.0.0/0
```

You won't see any status so let's verify your group. Look for protocol and port. The values of range to and from should be both 80:

```
aws ec2 describe-security-groups --group-names http-sg
```

## 3. Create an SSH key pair

This is a tricky step. You are not supposed to access your instances via SSH so there's nothing to do here. :)

## 4. Find AMI ID (instance ID)

Run a command to get Amazon Linux AMI ID with name "amzn-ami-hvm-2017.03.0.20170417-x86_64-gp2" from your region:

```
aws ec2 describe-images --owners amazon \
  --filters "Name=virtualization-type,Values=hvm" "Name=root-device-type,Values=ebs" \
  "Name=name,Values=amzn-ami-hvm-2017.03.0.20170417-x86_64-gp2"
```

You can pick a different Amazon Linux image (AMI) or a compatible OS like CentOS. You can use feed different parameters to `describe-images` such as name. All the images available on AWS are listed in the AWS Marketplace: <https://aws.amazon.com/marketplace>.

For example, here's [a Marketplace search result for Amazon Linux AMIs](https://aws.amazon.com/marketplace/search/results?x=0&y=0&searchTerms=amazon+linux&page=1&ref_=nav_search_box).

## 5. Launch instances

Navigate to the folder in which you have user data saved in file (e.g., httpd-hello-user-data.sh). Now you can launch an instance (or two) using user data and the security group you created. The user data will be fed from a file using `file://` syntax. You can fetch user data from the internet using http as well.

```
aws ec2 run-instances --image-id ami-7a85a01a \
  --count 1 --instance-type t2.micro \
  --security-groups http-sg \
  --user-data file://httpd-hello-user-data.sh
```

Write down (or copy) the instance ID which will have the following format (your ID will differ in the value): `i-0ca91f9842b88d206`. You won't see the public IP right away. It'll take a few minutes... for this reason, wait a little bit and run command to pull the list of instances.

```
aws ec2 describe-instances --instance-ids i-0ca91f9842b88d206
```

If you only have a single (or only a few) instance(s), then you can run `aws ec2 describe-instances` without IDs. 
If you have many instances, provide the ID which you saved (you did save it, right?) from `run-instances`:

```
aws ec2 describe-instances --instance-ids i-0ca91f9842b88d206
```

Copy the PublicDnsName. If you don't see it, make sure the status is 16: running. Also, double check the security group.

## 6. Get public IP and test

Paste the public URL (DNS name) into your favorite browser. Observe the HTML page. If you didn't modify the HTML, you will see "This is my cool HTML page"

Terminate your instance. You can use `terminate-instances`. For example, 

```
aws ec2 terminate-instances --instance-ids i-0ca91f9842b88d206
```

# Troubleshooting

* Not seeing any response: Make sure your User Data is working. Debug by creating an instance with a key pair and check the logs. It could be a syntax issue or a wrong OS.
* Can't navigate, curl or ping: Make sure your security group allows for HTTP 80 and for ping it's ICMP, not just HTTP.
