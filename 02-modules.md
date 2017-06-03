footer: © NodeProgram.com, Node.University and Azat Mardan 2017
slidenumbers: true
theme: Merriweather, 8
build-lists: true

# AWS Intermediate
## All you need to know to start DevOps with AWS

![inline 100%](images/azat.jpeg)
Azat Mardan @azat_co

![inline right](images/nu.png)

[.slidenumbers: false]

---

## Why cloud?

Refresher from the AWS Intro course. Yell out loud the cloud computing benefits! 🔊

---

[.autoscale: true]

* Elastic, scalable, flexible and operational agile
* Disaster recovery
* Automatic software updates
* Capital-expenditure Free
* Increased collaboration
* Work from anywhere
* Standard and expertise
* Reduced time to market and competitiveness
* Environmentally friendly
* Easy to use
* Benefits of mass economy of scale
* Global delivery faster

---

# Major Cloud Providers

* Azure
* Google
* AWS

---


# Types of Cloud Computing

* IaaS
* PaaS
* BaaS
* FaaS
* SaaS

---

# AWS Benefits

* One of the first
* Massive scale
* Innovator with news features and services
* Lots of tools - good dev experience
* Almost a standard with lots of expertise, best practices, experts, books, etc.

---

# Best Practices

[.autoscale: true]

* Horizontal and vertical scaling
* Redundancy
* Not just EC2- services instead of servers
* Loose coupling
* Stateless
* Automation
* Cost optimization
* Caching

^: User Data, CloudFormation; Spot, event driven, alerts and auto scaling groups; CloudFront, app caching

---

# AWS Well-Architectured Framework

* Build and deploy faster
* Lower or mitigate risks
* Make informed decisions
* Learn AWS best practices

Whitepaper: pdfs/AWS_Well-Architected_Framework.pdf  

---

# Five Pillars

1. Security
1. Reliability
1. Performance Efficiency
1. Cost Optimization
1. Operational Excellence

[More info](https://aws.amazon.com/architecture/well-architected)

---

# Demo: An example of an environment in AWS

---

# DevOps and Infrastructure as code

---

# What is DevOps

* Speed of delivery - business value
* Reduce errors (automate)
* Save cost
* Bridge gap between IT Ops and devs - work as one team

---


# Main Principles

* Automate everything
* Version: define infrastructure as code and store in version control system (like app code)
* Ability to deploy and roll back quickly and *often*
* Test app and infrastructure code

---

# Continuous Integration (CI)

For apps:

Dev -> Code version control repository -> Build and Test on CI server -> Deploy to QA -> deploy to prod

For infra:

IT Ops -> Repo -> CI Server: Build images and validate templates (CloudFormation), test APIs -> Deploy

---

# Continuous Delivery (CD)

CI/CD pipeline is an automation of CIs. Could include stress testing and performance testing.

Not the same as Continuous Deployment (delivery has manual prod deploy).

---

# Infrastructure as Code

* Repeatability: Humans make mistakes, machines less so (almost 0 when hardware is robust)
* Agility: Deploy quickly and often and roll back quickly and predictably if needed
* Auditing: Permissions and ACL with a history

---

# Cloud Automation

* AWS CLI
* SDKs
* CloudFormation
* Others: Ansible, Terraform

---

# What about AWS and its tools?

---

# AWS DevOps and Automation

* Provision environment/infrastructure: AWS CLI, CloudFormation, OpsWorks, Beanstalk
* Configuring servers with AWS: User Data, Docker, Beanstalk, CodeDeploy
* Configuring servers with other tools: Chef, Puppet SaltStack, Ansible

---

# What we need to do for CI

1. Provision environment
1. Deploy code
1. Build
1. Test
1. Verify

---


# Billing and calculator

* [SIMPLE MONTHLY CALCULATOR](https://calculator.s3.amazonaws.com/index.html)
* [Amazon EC2 Pricing](https://aws.amazon.com/ec2/pricing/on-demand)
* [Amazon S3 Pricing](https://aws.amazon.com/s3/pricing)


---

# Billing Management console

![inline](images/billing-console.png)

---

# What you need or lab 0

---

## Slides&code

Repo: <https://github.com/azat-co/aws-intermediate>

Git clone (you can fork first too):

```
git clone https://github.com/azat-co/aws-intermediate.git
```

Download with CURL and unzip (create a new folder):

```
curl  https://codeload.github.com/azat-co/aws-intermediate/zip/master | tar -xv
```

---

# Who has an AWS account access? 🙋

---

## AWS account: Free tier

* Sign up for free tier with an email you have access to
* Random verification (phone call or wait - ask me for access to my account)
* Debit/credit Card for verification and paid services


---

## AWS account: Free tier (cont)

Free tier: <https://aws.amazon.com/free>, examples:

* EC2: 750 hours of t2.micro (~1 month of 1 EC2) - more than enough for this class and then some more
* S3: 5Gb
* RDS: 750 hours
* Lambda: 1,000,000 requests/mo
* More products!

---


## We have a few pre-requisites—tools you need to install before we can proceed. But where to install?

---

# Install Pre-Reqs Here:

* Host - your dev machine (recommended for Mac and Linux)
* Virtual machine - if you develop in VM (recommended for Windows)
* Remote machine - if you develop in the cloud or if you are setting up CD/CI environment

I develop natively on my dev machine, but you can use another EC2 instance

---

# Pre-Reqs

* AWS Account (requires email + credit/debit card)
* Python 2.7 or 3.x (latest is better)
* [AWS CLI](https://aws.amazon.com/cli): Install with [pip](https://pypi.python.org/pypi/pip) or brew or just use a [bundle](http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-bundle.html) (see all [options](http://docs.aws.amazon.com/cli/latest/userguide/installing.html))
* Node and npm for HTTP server, tools and SKD code ([installers](https://nodejs.org/en/download))


---

# Good to have tools

* [Git](https://git-scm.com) mostly for code deploys and Elastic Beanstalk
* Code editor [Atom](https://atom.io) or [VS code](https://code.visualstudio.com)
* [CURL](https://curl.haxx.se/download.html) and [PuTTY](http://www.putty.org) (for Windows)
* [Docker](https://www.docker.com) daemon/engine - advanced if we have time ([instructions](https://docs.docker.com/engine/installation))

---

# AWS CLI Check

```
aws --version
```

v1.x - ok

---

# Node and npm Check

```
node --version
npm --version
```

6.x - ok and 3.x - ok

---

# Docker Check

Optional

```
docker --version
```

1.x - ok and 3.x - ok

---

# ❓ Questions? ❓

---

# Lab 0: Installs or Flight Checklist

* Slides, labs and code  <https://github.com/azat-co/aws-intermediate>
* AWS account
* AWS CLI (pip, brew or bundle)
* Node and npm
* Docker engine

Detailed instructions and links are in labs/0-installs.md

Time: 15 minutes to download and install, go! 🚀

---

# ❓ Questions? ❓

---

# AWS CLI

---

## AWS CLI is a very basic way to automate infrastructure and save it in code.

---

## AWS CLI Benefits

* Infrastructure as code: can save in a file and version
* Repeatability: bash script can be run multiple times
* Error free: no need to remember all the steps and configuration for web console
* Fast: no need to click around in the web console
* Can be run from any machine: Will work for CI/CD


---

# Note

`\` in a CLI command, means a new line - optional and purely for formatting and larger font. `\` works the same in bash/zsh.


Bad font:

```
aws ec2 describe-images --owners amazon --filters "Name=virtualization-type,Values=hvm" "Name=root-device-type,Values=ebs" "Name=name,Values=amzn-ami-hvm-2016.09.1.20170119-x86_64-gp2"
```

Good font:

```
aws ec2 describe-images --owners amazon \
  --filters "Name=virtualization-type,Values=hvm" "Name=root-device-type,Values=ebs" \
  "Name=name,Values=amzn-ami-hvm-2016.09.1.20170119-x86_64-gp2"
```

^Both commands will work the same


---

## AWS CLI Usage Pattern

```
aws <command> <subcommand> [options and parameters]
```

---

## Auth with AWS

* Access Key ID
* Secret Access Key

Copy your key and secret (root) or create a new user, give appropriate permissions and copy key and secret for that user (best practice).

Note: You can use AWS CLI to create a user too.

---

![fit](images/aws-security-credentials.png)

---

![fit](images/aws-security-credentials-2.png)

---

![fit](images/aws-security-credentials-3.png)

---

![fit](images/aws-security-credentials-4.png)


---

## Configure Your CLI

```
aws configure
```

1. Provide access key ID
1. Provide secret access key
1. Set region to `us-west-1` and output to None or json


---

## Example

```
aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-1
Default output format [None]: json
```

---

# Getting Help

```
aws help
aws ec2 help
aws ec2 describe-regions help
```

---

# Identity Access Management in AWS

---

# Create User with CLI—Easy!

Create user:

```
aws iam create-user --user-name MyUser
```

Attach policy from a file:

```
aws iam put-user-policy --user-name MyUser --policy-name MyPowerUserRole --policy-document file://C:\Temp\MyPolicyFile.json
```

Or a link:

```
aws iam put-user-policy --user-name MyUser --policy-name MyPowerUserRole --policy-document https://s3.amazonaws.com/checkr3/CC_IAM_FullPolicy.json
```

---

## IAM Policy Example for EC2 Allow All:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1491182980154",
      "Action": "ec2:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
```

Another [IAM JSON file example](https://s3.amazonaws.com/checkr3/CC_IAM_FullPolicy.json)

---


List policies for the user to verify:

```
aws iam list-user-policies --user-name MyUser
```


Create password to login to web console:

```
aws iam create-login-profile --user-name MyUser --password Welc0m3!
```

Create access key:

```bash
aws iam create-access-key --user-name MyUser
```

---

## Create access key response example:

```json
{
    "AccessKey": {
        "UserName": "Bob",
        "Status": "Active",
        "CreateDate": "2015-03-09T18:39:23.411Z",
        "SecretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYzEXAMPLEKEY",
        "AccessKeyId": "AKIAIOSFODNN7EXAMPLE"
    }
}
```

---

# Documentation on IAM

* [AWS Identity and Access Management](http://docs.aws.amazon.com/IAM/latest/UserGuide/access.html)
* [AWS Policy Generator](https://awspolicygen.s3.amazonaws.com/policygen.html)

---

# Connecting Resources and IAM

---

# Best IAM Practices

* Lock away your AWS account (root) access keys
* Create individual IAM users
* Use AWS-defined policies to assign permissions whenever possible
* Use groups to assign permissions to IAM users
* Grant least privilege

---

# Best IAM Practices (Cont)

* Configure a strong password policy for your users
* Enable MFA for privileged users
* Use roles for applications that run on Amazon EC2 instances
* Delegate by using roles instead of by sharing credentials


---

# Best IAM Practices (Cont)

* Rotate credentials regularly
* Remove unnecessary credentials
* Use policy conditions for extra security
* Monitor activity in your AWS account

---

# Working with AWS CLI

---

# Getting Started with AWS CLI

```
aws ec2 describe-instances help
aws ec2 run-instances help
awc ec2 create-images help
aws ec2 describe-images help
```

---

# Launch Instance

1. Get image ID
1. Run command

---

Amazon Linux AMI IDs differ from region to region

---

## Getting Amazon Linux Image ID

* Web console
* `describe-images`
* [AWS List](https://aws.amazon.com/amazon-linux-ami)

---

## Example of Amazon Linux AMI 2016.09.1 (HVM), SSD Volume Type


```
aws ec2 describe-images --owners amazon \
  --filters "Name=virtualization-type,Values=hvm" "Name=root-device-type,Values=ebs" \
  "Name=name,Values=amzn-ami-hvm-2016.09.1.20170119-x86_64-gp2"
```

Result is "ami-165a0876"

Docs: <http://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html>

---

Example of Amazon Linux AMI 2016.09.1 (HVM), SSD Volume Type Output:

```json
{
    "Images": [
        {
            "VirtualizationType": "hvm",
            "Name": "amzn-ami-hvm-2016.09.1.20170119-x86_64-gp2",
            "Hypervisor": "xen",
            "ImageOwnerAlias": "amazon",
            "EnaSupport": true,
            "SriovNetSupport": "simple",
            "ImageId": "ami-165a0876",
            "State": "available",
            "BlockDeviceMappings": [
                {
                    "DeviceName": "/dev/xvda",
                    "Ebs": {
                      ...
                    }
                }
            ],
            "Architecture": "x86_64",
            "ImageLocation": "amazon/amzn-ami-hvm-2016.09.1.20170119-x86_64-gp2",
            "RootDeviceType": "ebs",
            "OwnerId": "137112412989",
            "RootDeviceName": "/dev/xvda",
            "CreationDate": "2017-01-20T23:39:56.000Z",
            "Public": true,
            "ImageType": "machine",
            "Description": "Amazon Linux AMI 2016.09.1.20170119 x86_64 HVM GP2"
        }
    ]
}
```

---

# Run instances is really launch instances (or create)

```
aws ec2 run-instances --image-id ami-xxxxxxxx \
  --count 1 --instance-type t2.micro \
  --key-name MyKeyPair --security-groups my-sg
```

Note: You need to have security group first (if you don't have it).

---


# Run (Launch) instances with subnet:

```
aws ec2 run-instances --image-id ami-{xxxxxxxx} \
  --count 1 --instance-type t2.micro \
  --key-name {MyKeyPair} \
  --security-group-ids sg-{xxxxxxxx} --subnet-id subnet-{xxxxxxxx}
```

Note: You need to have security group and subnet first (if you don't have them).


---

# Working with Security Groups

---

Create security group:

```
aws ec2 create-security-group \
  --group-name MySecurityGroup \
  --description "My security group"
```

---


Add RDP port 3389:

```
aws ec2 authorize-security-group-ingress \
  --group-name my-sg --protocol tcp \
  --port 3389 --cidr 203.0.113.0/24
```

---

Add SSH port 22:

```
aws ec2 authorize-security-group-ingress \
  --group-name my-sg --protocol tcp \
  --port 22 --cidr 203.0.113.0/24
```

Verify security group:

```
aws ec2 describe-security-groups --group-names my-sg
```

---

## Security Group Open Everything Example

```
aws ec2 create-security-group --group-name \
  open-sg --description "Open security group"
aws ec2 authorize-security-group-ingress \
  --group-name open-sg --protocol all --port 0-65535 --cidr 0.0.0.0/0
aws ec2 describe-security-groups --group-names open-sg
```

---

## Adding Tags

```
aws ec2 create-tags --resources i-{xxxxxxxx} \
  --tags Key={Name},Value={MyInstance}
```

Replace {xxx}, {Name} and {MyInstance}

---

# See instances

```
aws ec2 describe-instances
```

---

## Stopping, starting and terminating

```
aws ec2 stop-instances --instance-ids i-{xxxxxxxx}
aws ec2 start-instances --instance-ids i-{xxxxxxxx}
aws ec2 terminate-instances --instance-ids i-{xxxxxxxx}
```

Note: after stop you can start, after terminate no.

---

# Working with Key Pairs

```
aws ec2 create-key-pair --key-name {MyKeyPair} \
  --query 'KeyMaterial' --output text > {MyKeyPair}.pem
aws ec2 describe-key-pairs --key-name {MyKeyPair}
aws ec2 delete-key-pair --key-name {MyKeyPair}
```

`{MyKeyPair}` is a string name, e.g., `azat-aws-dev`.

---


# Auto Startup

* `init.d` or [CloudInit](https://help.ubuntu.com/community/CloudInit) for Ubuntu+Debian and other like CentOS with additional [installation](http://stackoverflow.com/questions/23411408/how-do-i-set-up-cloud-init-on-custom-amis-in-aws-centos/23411409#23411409)
* User Data
* Command

Note: More on User Data is in [the AWS Intro course](https://github.com/azat-co/aws-intro)

---

```sh
#!/bin/bash
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 6
node -e "console.log('Running Node.js ' + process.version)"
echo "require('http').createServer((req, res) => {
  res.end('hello world')
}).listen(3000, (error)=>{
  console.log('server is running on 3000')
})
" >> index.js
node index.js
```

---

# Shell Script and User Data Example

LAMP Stack (Apache httpd, MySQL and PHP) for Amazon Linux:

```sh
#!/bin/bash
yum update -y
yum install -y httpd24 php56 mysql55-server php56-mysqlnd
service httpd start
chkconfig httpd on
groupadd www
usermod -a -G www ec2-user
chown -R root:www /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} +
find /var/www -type f -exec chmod 0664 {} +
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
echo "<?php echo 'Hello World!' ?>" > /var/www/html/index.php
```

---

# User Data in run-instances

You can supply base64 encoded string, normal string or a file. ami-9e247efe is Amazon Linux AMI for us-west-1:

```bash
aws ec2 run-instances --image-id ami-9e247efe \
  --count 1 --instance-type t2.micro \
  --key-name MyKeyPair \
  --security-groups MySecurityGroup  \
  --user-data file://my_script.txt
```

Note: You can only run user-data once on launch (run-instances). Updating user data on existing instance will NOT run the User Data script.

---

More info on User Data:

<http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html>

---

# ❓ Questions? ❓

---

# Lab 1: Power to AWS CLI

Task: Install AWS CLI, configure, create an instance with apache httpd via AWS CLI and no SSH, and then make the HTML page (hello world) visible in the browser *publicly*

Detailed instructions and links are in labs/1-hello-world-aws-cli.md


Time to finish: 15 min 👾

---

# ❓ Questions? ❓

---

# Module 2: AWS SDKs

---

# How to access and work with AWS platform from within your application?

---

# SDKs!


---

# Advantages of SDKs

* Automate anything
* Build your own clients or interfaces for AWS
* No need to create HTTP requests and worry about payloads, formats, and headers
* Work in your favorite environment: Java, Python, Node and many more

---

# Supported services

* Amazon S3
* Amazon EC2
* DynamoDB
* Many more!

---

[.autoscale:true]

# What languages

* Android
* Browser
* iOS
* Java
* .NET
* Node.js
* PHP
* Python
* Ruby
* Go


---

# Node SDK

```
mkdir aws-node-sdk-test
cd aws-node-sdk-test
npm init -y
npm i -SE aws-sdk
```

---

# Credentials

* Home directory
* Environment variables
* JavaScript/Node or JSON file

Pick just one

---

# Credentials in Home Directory

 `~/.aws/credentials` or `C:\Users\USER_NAME\.aws\credentials` for Windows users

```
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
```

(`region` goes into Node file in `new AWS.EC2` call)

---

# Env variables

```
AWS_ACCESS_KEY_ID=key
AWS_SECRET_ACCESS_KEY=secret
AWS_REGION=us-west-1
```

---

# JSON Config for Creds

```js
{
  "accessKeyId": "your-access-key-here",
  "secretAccessKey": "your-secret-key-here",
  "region": "us-west-1"
}
```

---

## EC2 Example

![inline](images/code-samples-ec2.png)

---

`describe.js`

```js
// Load the SDK for JavaScript
const AWS = require('aws-sdk')
// Load credentials and set region from JSON file
// AWS.config.loadFromPath('./config.json')
// Create EC2 service object
const ec2 = new AWS.EC2({apiVersion: '2016-11-15', region:'us-west-1'})
```

---

```js
const params = {
  // DryRun: true || false,
  Filters: [
    {
      Name: 'endpoint',
      Values: [
        'ec2.us-west-1.amazonaws.com',
        /* more items */
      ]
    },
    /* more items */
  ],
  RegionNames: [
    'us-west-1',
    /* more items */
  ]
}
```

---

```js
// Describe region
ec2.describeRegions(params, function(err, data) {
   if (err) return console.log('Could not describe regions', err)
   console.log(data)
   const imageParams = {
     Owners: ['amazon'],
     Filters: [{
       Name: 'virtualization-type',
       Values: ['hvm']
     }, {
       Name: 'root-device-type',
       Values: ['ebs']
     }, {
       Name: 'name',
       Values: ['amzn-ami-hvm-2017.03.0.*-x86_64-gp2']
     }]
   }
   ec2.describeImages(imageParams, (err, data)=>{
     if (err) return console.log('Could not describe regions', err)
     console.log(data)
   })
})
```

---


# How to run it?

```
cd code/sdk
node describe.js
```

---


Create and open `provision-infra.js`:

```js
// Load the SDK for JavaScript
const AWS = require('aws-sdk')
// Load credentials and set region from JSON file
AWS.config.loadFromPath('./config.json')
```

---

```js
// Create EC2 service object
var ec2 = new AWS.EC2({apiVersion: '2016-11-15'})
//const ec2 = new AWS.EC2({apiVersion: '2016-11-15', region:'us-west-1'})
const fs = require('fs')
var params = {
  ImageId: 'ami-7a85a01a', // us-west-1 Amazon Linux AMI 2017.03.0 (HVM), SSD Volume Type
  InstanceType: 't2.micro',
  MinCount: 1,
  MaxCount: 1,
  UserData: fs.readFileSync('./user-data.sh', 'base64'),
  SecurityGroups: ['http-sg']
}
```

---

```js
// Create the instance
ec2.runInstances(params, function(err, data) {
   if (err) {
      console.log('Could not create instance', err)
      return
   }
   var instanceId = data.Instances[0].InstanceId
   console.log('Created instance', instanceId)
   // Add tags to the instance
   params = {Resources: [instanceId], Tags: [
      {
         Key: 'Role',
         Value: 'aws-course'
      }
   ]}
   ec2.createTags(params, function(err) {
      console.log('Tagging instance', err ? 'failure' : 'success')
   })
})
```


---

# Running Node scripts

```
node provision-infra.js
```

Example: code/sdk

---

Run:

```
cd code/sdk
node provision-infra.js
Created instance i-0261a29f670faade4
Tagging instance success
```

Describe:

```
aws ec2 describe-instances --instance-ids i-0261a29f670faade4
AWS_DEFAULT_OUTPUT="table" aws ec2 describe-instances --instance-ids i-0261a29f670faade4
aws ec2 describe-instances --instance-ids i-0261a29f670faade4 \
  --query 'Reservations[0].Instances[0].PublicDnsName'
```

---

# Feeding Data to Node

```
node provision-infra.js ./user-data-qa.js
```

```js
const userDataFile = process.argv[2]
//...
var params = {
   ImageId: 'ami-7a85a01a', // us-west-1 Amazon Linux AMI 2017.03.0 (HVM), SSD Volume Type
   InstanceType: 't2.micro',
   MinCount: 1,
   MaxCount: 1,
   UserData: fs.readFileSync(userDataFile, 'base64')
}
```

---

# ❓ Questions? ❓

---


# Lab 2: Node SDK Runs EC2

Task: Write a Node script to create an instance with Node hello world (use User Data), and run it. Make sure you see the Hello World via public DNS.

Detailed instructions and link are in labs/02-sdk-runs-ec2.md

Time to finish: 10 min

---

# ❓ Questions? ❓


---


# Module 3: Cloud Infrastructure Automation with CloudFormation

---

# Declarative vs. Imperative

TL;DR: Declarative - what I want and imperative - what to do.

Declarative requires that users specify the end state of the infrastructure they want, while imperative configures systems in a series of actions.

(AWS CLI and SDK are imperative.)

---

# Problems with imperative style?

* Not simple and not simple to understand the end result
* Racing conditions
* Unpredictable results

^Imperative could be more flexible with dynamic if/else conditions while declarative would just break.

---

# Meet CloudFormation!

---

# What is CloudFormation

* Special format in a JSON or YAML file
* Declarative service
* Visual web editor

[Samples](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/sample-templates-services-us-west-2.html)

---

# CloudFormation advantages

* Declarative and Flexible
* Easy to Use
* Infrastructure as Code :zero::one::zero::one:
* Supports a Wide Range of AWS Resources
* Customized via Parameters
* Visualize and Edit with Drag-and-Drop Interface
* Integration Ready

---

# CloudFormation Example: S3 Bucket

```json
{
    "Resources" : {
        "HelloBucket" : {
            "Type" : "AWS::S3::Bucket"
        }
    }
}
```

---

# YAML

```
Resources:
  HelloBucket:
    Type: AWS::S3::Bucket
```

---

# Where to put JSON or YAML?

* CLI
* Web console
* SDK
* REST API calls

---

# AWS CLI create-stack

```
aws cloudformation create-stack --stack-name myteststack --template-body file:////home//local//test//sampletemplate.json
```

It will give you a stack ID which you can use later to check on the status of creation.


---

# CloudFormation structure

* Version
* Description
* Resources
* Parameters
* Mappings
* Outputs

---

# AWS CloudFormation Resources

* Resource must have a type of this format `AWS::ProductIdentifier::ResourceType`. See [all resource types](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html).
* Some resources like S3 have defaults but others like EC2 will require more properties (image ID)
* You can get real property value with Ref function (ID, IP, etc.)

---


## Remember from a lab to host a static webpage on S3 in the AWS Intro course?

---

CloudFormation Example: S3 Bucket with Static Website

```json
{
    "Resources" : {
        "HelloBucket" : {
            "Type" : "AWS::S3::Bucket",
            "Properties" : {
               "AccessControl" : "PublicRead",
               "WebsiteConfiguration" : {
                    "IndexDocument" : "index.html",
                    "ErrorDocument" : "error.html"            
               }               
            }
        }
    }
}
```

---

## Let's use ref function. See list of [ref functions](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-ref.html).

---

# EC2 with a security group

---

```json
{
  "Resources" : {
    "Ec2Instance" : {
      "Type" : "AWS::EC2::Instance",
      "Properties" : {
        "SecurityGroups" : [ { "Ref" : "InstanceSecurityGroup" } ],
        "KeyName" : "azat-aws-course",
        "ImageId" : "ami-9e247efe"
      }
    },
    "InstanceSecurityGroup" : {
      "Type" : "AWS::EC2::SecurityGroup",
      "Properties" : {
        "GroupDescription" : "Enable SSH access via port 22",
        "SecurityGroupIngress" : [ {
          "IpProtocol" : "tcp",
          "FromPort" : "22",
          "ToPort" : "22",
          "CidrIp" : "0.0.0.0/0"
        } ]
      }
    }
  }
}
```

---

## For other attributes not returned by ref, there's Fn::GetAtt

```
{ "Fn::GetAtt" : [ "logicalNameOfResource", "attributeName" ] }
```

See [reference](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-getatt.html).


---

## `azat-aws-course` must exist before running this template

```
"Resources" : {
  "Ec2Instance" : {
    "Type" : "AWS::EC2::Instance",
    "Properties" : {
      "SecurityGroups" : [ { "Ref" : "InstanceSecurityGroup" } ],
      "KeyName" : "azat-aws-course",
      "ImageId" : "ami-9e247efe"
    }
  },
```


---


## `azat-aws-course` must exist before running this template... can we provide it later? Yes, it's a template!

---

## We can use Parameters

---

## Key parameter (key is provided on stack creation)

```
{
  "Parameters" : {
    "KeyNameParam" : {
      "Description" : "The EC2 Key Pair to allow SSH access to the instance",
      "Type" : "AWS::EC2::KeyPair::KeyName"
    }
  },
```

---

## Resource EC2 (created with the key from `KeyNameParam` parameter)

```
  "Resources" : {
    "Ec2Instance" : {
      "Type" : "AWS::EC2::Instance",
      "Properties" : {
        "SecurityGroups" : [ { "Ref" : "InstanceSecurityGroup" }, "MyExistingSecurityGroup" ],
        "KeyName" : { "Ref" : "KeyNameParam"},
        "ImageId" : "ami-7a11e213"
      }
    },
```

---

## Resource SecurityGroup (create by CloudFormation)

```
    "InstanceSecurityGroup" : {
      "Type" : "AWS::EC2::SecurityGroup",
      "Properties" : {
        "GroupDescription" : "Enable SSH access via port 22",
        "SecurityGroupIngress" : [ {
          "IpProtocol" : "tcp",
          "FromPort" : "22",
          "ToPort" : "22",
          "CidrIp" : "0.0.0.0/0"
        } ]
      }
    }
  }
}
```

---

# Providing parameters in CLI

```
aws cloudformation create-stack --stack-name myteststack \
  --template-body file:////home//local//test//sampletemplate.json \
  --parameters ParameterKey=KeyNameParam,ParameterValue=azat-aws-course \
  ParameterKey=SubnetIDs,ParameterValue=SubnetID1\\,SubnetID2
```

---

WordPress CloudFormation Parameters Example

```
"Parameters": {
  "KeyNameParam": {
    "Description" : "Name of an existing EC2 KeyPair to enable SSH access into the WordPress web server",
    "Type": "AWS::EC2::KeyPair::KeyName"
  },
  "WordPressUser": {
    "Default": "admin",
    "NoEcho": "true",
    "Description" : "The WordPress database admin account user name",
    "Type": "String",
    "MinLength": "1",
    "MaxLength": "16",
    "AllowedPattern" : "[a-zA-Z][a-zA-Z0-9]*"
  },
  "WebServerPort": {
    "Default": "8888",
    "Description" : "TCP/IP port for the WordPress web server",
    "Type": "Number",
    "MinValue": "1",
    "MaxValue": "65535"
  }
}
```

---

# Pseudo Parameters

Resolved by CloudFormation, e.g., AWS::Region


---

# Other functions

* Fn::FindInMap
* Fn::Base64
* Conditional: Fn::And, Fn::Equals, Fn::If, Fn::Not, Fn::Or

See the full list in [Intrinsic Function Reference](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html).

---

# Mappings

---

# What and why Mappings

Mappings is for specifying conditional values

Simple Parameters -> Mappings -> Complex Values

Example: Getting AMI ID (differs from region to region for the same image)

---

Mappings example: define mappings for AMI IDs based on regions:

```
  "Mappings" : {
    "RegionMap" : {
      "us-east-1" : {
          "AMI" : "ami-76f0061f"
      },
      "us-west-1" : {
          "AMI" : "ami-655a0a20"
      },
      "eu-west-1" : {
          "AMI" : "ami-7fd4e10b"
      },
      "ap-southeast-1" : {
          "AMI" : "ami-72621c20"
      },
      "ap-northeast-1" : {
          "AMI" : "ami-8e08a38f"
      }
    }
  },
```

---

Find AMI ID based on region using mappings:

```
"Resources" : {
    "Ec2Instance" : {
      "Type" : "AWS::EC2::Instance",
      "Properties" : {
        "KeyName" : { "Ref" : "KeyNameParam" },
        "ImageId" : { "Fn::FindInMap" : [ "RegionMap", { "Ref" : "AWS::Region" }, "AMI" ]},
        "UserData" : { "Fn::Base64" : "80" }
      }
    }
  }
}
```

---

# Demo: CloudFormation example and AWS CLI

* Create EC2 using CloudFormation and User Data

```
aws cloudformation create-stack --stack-name myteststack \
  --template-body file:////home//local//test//sampletemplate.json \
  --parameters ParameterKey=KeyNameParam,ParameterValue=azat-aws-course
```

---

# Demo: CloudFormation visual web editor

---

# ❓ Questions? ❓

---


# Lab 3: Form the Cloud ☁️

Task: Create an ELB, security group and auto scaling environment from CloudFormation template/blueprint; load/stress test it to see auto increase

You can use blueprint from code/cloudformation/AutoScalingMultiAZWithNotifications.json or one from [AWS](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/sample-templates-services-us-west-2.html#w1ab2c21c45c15b9)

Detailed instructions and link are in labs/03-form-the-cloud.md

Time to finish: 20min

---

# ❓ Questions? ❓

---

# Module 4: Building CI/CD

---

# How to get the source code to the remote machines?

Any ideas? Just say out loud.

---

# Source Code

* SSH, scp, sftp
* Git - `git push origin master` and then `git pull origin master`
* Rsync `rsync -avzhe ssh backup.tar ec2-user@192.168.0.100:/backups/`
* S3, e.g., `aws s3 cp s3://{mybucket}/latest/install . --region us-east-1` and then curl or wget

---

# Simple Flow

1. Code committed to bucket, repository, folder, etc.
1. Event is issued (eg., a webhook)
1. Code is deployed

---

## Developers can implement their own solution or use one of the open sources... but AWS has a service... meet [CodeDeploy](https://aws.amazon.com/codedeploy)!

---

![](https://www.youtube.com/watch?time_continue=3&v=Wx-ain8UryM)


---

# CodeDeploy Benefits

* Automated Deployments
* Minimize Downtime
* Centralized Control
* Easy To Adopt

---

# CodePipeline

AWS CodePipeline is a CI/CD service. Its benefits:

* Rapid Delivery
* Improved Quality
* Configurable Workflow
* Get Started Fast
* Easy to Integrate

---

How CodePipeline, CodeDeploy and other CI/CD services can work together

![inline](images/codepipeline diagram.png)

---

# Demo: Building CI with GitHub

---

1. Create roles

1. Create role CDInstanceRole in IAM (AmazonEC2RoleforAWSCodeDeploy)
1. Create role CDServiceRole (AWSCodeDeployRole)

Use CLI or web console


---

AmazonEC2RoleforAWSCodeDeploy Policy in JSON (for CLI)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:ListObjects"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
```

---

Policy for AWSCodeDeployRole in JSON (for CLI)

![inline](images/codedeployrole.png)

---

# 2. Create an instance

* Amazon Linux t2.micro
* use CDInstanceRole in IAM role to EC2 instance
* Install codedeploy agent in User Data (code/install-codedeploy-agent.sh)
* Use 8Gb SSD
* Tag with env=dev
* Add SSH and HTTP for security group

---

## User Data for CodeDeploy agent

code/install-codedeploy-agent.sh:

```sh
#!/bin/bash
yum install -y aws-cli
cd /home/ec2-user/
aws s3 cp 's3://aws-codedeploy-us-east-1/latest/codedeploy-agent.noarch.rpm' . \
  --region us-east-1
yum -y install codedeploy-agent.noarch.rpm
```

---

# Create custom CodeDeploy deployment

* Use NodeApp and NodeAppInstances for app name and deployment group name
* Use tag env=dev
* Deployment config = All at once
* Use Service Role ARN = CDServiceRole

---

# Deploy options

* From S3 (using CLI)
* From GitHub (AWS CodePipeline)

---

# Test

See the code change after editing on GitHub

---

# Create CodePipeline

* Enter name
* Select GitHub as provider and select "Connect to GitHub"
* Pick repository
* Skip the build
* Beta: AWS CodeDeploy, use NodeApp and NodeAppInstances
* Create pipeline service role using wizard (or manually)

---

# Verifying

1. Observe the code deploy in the pipeline (Source and Beta stages)
1. Copy the public URL of one of your instances and navigate to it in the browser
1. Edit GitHub source (index.js)
1. See changes

---

# Other options for CI/CD (might be complimentary to CodeDeploy)

* Jenkins
* TravisCI
* Bamboo
* TeamCity
* CircleCI
* CruiseControl

---

# OpsWork vs CloudFormation vs Elastic Beanstalk

OpsWork: configuration management (stacks and layers) - narrower app-oriented resources than CloudFormation

CloudFormation: building block service for almost everything

Elastic Beanstalk: only app management service

---

# ❓ Questions? ❓

---

# Lab 4: Never deploy (manually) again!

Task: Build CI with CodeDeploy and code from GitHub, update code, and see change in a browser

Detailed instructions and link are in labs/4-codedeploy.md

Time to finish: 20 min

---

# ❓ Questions? ❓


---

# Module 5: AWS Databases

---

# RDS

* Aurora
* PostgeSQL
* MySQL
* MariaDB
* Oracle
* MS SQL Server

---

# DynamoDB

---

# ElastiCache

---

# Redshift

---

# ❓ Questions? ❓

---

# Module 6: PaaS

---

# Working with ElasticBeanstalk

---

# ElasticBeanstalk Benefits

* Easy and simple to get started
* Increased developer productivity
* Automatic scaling
* Allows for a complete resource control
* No additional charge for AWS Elastic Beanstalk

---

# App Environments

* Python
* Ruby
* PHP
* Node.js
* Docker
* Ruby
* Java
* .NET
* Docker
* Go

---

# Ways to work with ElasticBeanstalk

* GitHub
* zip
* Docker
* AWS CLI (EB CLI is deprecated)
* IDEs
* WAR files

---


# ElasticBeanstalk Resources

Use Elastic Beanstalk to deploy a web app which uses RDS:

* <http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_nodejs.html>
* [Getting Started with ElasticBeanstalk](https://aws.amazon.com/elasticbeanstalk/getting-started/)
* [Developer Resources](https://aws.amazon.com/elasticbeanstalk/developer-resources/)

---

# Demo 💻 : Launching a Node app

[link](https://console.aws.amazon.com/elasticbeanstalk/home?region=us-west-1#/newApplication?applicationName=EBNodeSampleApp&solutionStackName=Node.js&tierName=WebServer)

---

# Working with Docker

---


# Benefits of Docker (Containers)

* Ship More Software Faster
* Improve Developer Productivity
* Seamlessly Move Applications
* Standardize Application Operations

^Docker users on average ship software 7X more frequently than non-Docker users. Docker enables developers to ship isolated services as often as needed by eliminating the headaches of software dependencies. Docker reduces the time spent setting up new environments or troubleshooting differences between environments. Dockerized applications can be seamlessly moved from local development machines to production deployments on AWS. Small containerized applications make it easy to deploy, identify issues, and roll back for remediation.

---

# Some of the ways to work with Dockers on AWS

* EC2 (Docker image)
* ECS
* ECR
* Elastic Beanstalk Containers
* Docker EE for AWS

---

# Docker EE for AWS

![inline](images/docker-ee.png)

---

# Docker EE for AWS

https://www.docker.com/enterprise-edition

https://aws.amazon.com/marketplace/pp/B06XCFDF9K

---

![inline](images/amazon-linux-docker-ami.png)

---

# AWS ECS

---

![fit](images/overview.png)

---

# Work Flow

1. Create registry
1. Build and push image
1. Create task
1. Configure service
1. Set up ELB (optional)
1. Configure cluster
1. Launch

^Task is a blueprint for an application (what images, how many etc.); service runs and maintains (auto-recovery) tasks in a cluster; cluster is EC2 container instances (instances with container agent)

---

Create registry

![inline](images/deploy-docker-container-1.png)

---

# AWS CLI and Docker images build+push to ECR (my-repo)

```
aws ecr get-login --region us-west-1
docker build -t my-repo .
docker tag my-repo:latest 161599702702.dkr.ecr.us-west-1.amazonaws.com/my-repo:latest
docker push 161599702702.dkr.ecr.us-west-1.amazonaws.com/my-repo:latest
```

---

Create task

![inline](images/deploy-docker-container-2.png)

---

Configure service

![inline](images/deploy-docker-container-3.png)

---

Configure cluster

![inline](images/deploy-docker-container-5a.png)

---

# Guides

* [Deploy Docker Containers](https://aws.amazon.com/getting-started/tutorials/deploy-docker-containers)
* [Getting Started with Amazon ECR](http://docs.aws.amazon.com/AmazonECR/latest/userguide/ECR_GetStarted.html)


---



# ❓ Questions? ❓

---

# Module 7: Serverless

---

# Serverless with AWS Lambda

---

# Benefits of AWS Lambda

* No Servers to Manage
* Continuous Scaling
* Subsecond Metering

---

![inline](images/Lambda_HowItWorks.png)

---

# Use cases

* REST API and mobile backend
* IoT backend (Kinesis)
* Data ETL (Redshift, S3)
* Real-time file and stream processing
* Web applications (S3)

---

![inline](images/Lambda_WebApplications.png)

---


# Demo: Building Microservice with Lambda and API Gateway

---

[.footer:hide]

![fit](images/serverless-web-console-1.gif)

---

[.footer:hide]

![fit](images/serverless-web-console-2.gif)

---

# Resources

* <http://docs.aws.amazon.com/lambda/latest/dg/with-ddb.html>
* <https://github.com/dwyl/learn-aws-lambda#hello-world-example-inline>

---

# Lambda and DynamoDB

GET https://h8uwddrasb.execute-api.us-west-1.amazonaws.com/prod/my-first-fn?TableName=my-first-table

POST https://h8uwddrasb.execute-api.us-west-1.amazonaws.com/prod/my-first-fn?TableName=my-first-table

```
{"TableName": "my-first-table",

"Item": {
"main-part":"1",
	"username":"CJA402",
	"password": "cldjmPr!01"
}}
```

---

# ❓ Questions? ❓

---

# Lab 5: Create a microservice to save data in DB


---

# ❓ Questions? ❓

---

# End of Modules 👏
