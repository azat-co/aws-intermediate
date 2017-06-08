# Lab 2: Node SDK Runs EC2



# Task

Write a Node script to create an instance with Node hello world (use User Data), and run it. Make sure you see the Hello World via public DNS.

Time to finish: 10 min

# Walk-through

If you would like to attempt the task, then skip the walk-through and go for the task directly. However, if you need a little bit more hand holding or you would like to look up some of the commands or code or settings, then follow the walk-through.

1. Set up your credentials
1. Create user data
1. Create Node script
1. Run EC2, tag it
1. Test and terminate

## 1. Set up your credentials

Pick your way to set up credentials (access ID and secret key) as described in the lecture:

* home directory file
* config.json
* Node code

We will be using config.json in this tutorial.

## 2. Create user data

Create a user data shell script which will install Node v6 on the EC2 instance, copy the Hello World code to the EC2 instance and start the HTTP web server *right after the launch*.

You might use this code as an inspiration (code/sdk/user-data.sh):

```
#!/bin/bash -ex
# user data to install node, download hello world server code and stat the app
# output user data logs into a separate place for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
# get node into yum
curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
# install node (and npm) with yum
yum -y install nodejs
# install pm2 to restart node app
npm i -g pm2@2.4.3
# get source code for hello world node server from GitHub's gist (could be private GitHub repo or private S3)
curl "https://gist.githubusercontent.com/azat-co/41b7abc276eb0a773696c3c8d757e87e/raw/5cea0aee743a8a5a0270b09ab5f8d168848be6ec/hello-world-server-port.js" > /home/ec2-user/hello-world-server.js
sudo chmod 755 /home/ec2-user/hello-world-server.js # optional
# restart pm2 and thus node app on reboot
echo "PORT=80">>/etc/environment
crontab -l | { cat; echo "@reboot sudo pm2 start /home/ec2-user/hello-world-server.js -i 0 --name \"node-app\""; } | crontab -
# start the server
sudo pm2 start /home/ec2-user/hello-world-server.js -i 0 --name "node-app"
```


The code above is pulling source code for the HTTP web server from GitHub's gist (azat-co profile). If you are curious, here's the Node server code (code/sdk/hello-world-server-port.js):

```js
const port = process.env.PORT || 3000
require('http')
  .createServer((req, res) => {
    console.log('url:', req.url)
    res.end('hello world')
  })
  .listen(port, (error)=>{
    console.log(`server is running on ${port}`)
  })
```

It's a great idea to test your HTTP server locally on your developer machine. You can easily do it by running:

```
node hello-world-server-port.js
```

Or if you want to specify a different port instead of 3000, then you can do so with the PORT environment variable. For example, to use 80 use this:

```
sudo PORT=80 node hello-world-server-port.js
```

## 3. Create Node script

You can use Node as a scripting language to automate any AWS task. You can add parameters to your scripts to make them flexible (region, instance type, source code, etc.).

Create a project manifest file by running in a brand new folder:

```
mkdir provision-infra
cd provision-infra
npm init -y
```

Install AWS Node/JavaScript SKD:

```
npm i -SE aws-sdk
```

For this lab, your goal is to launch an instance with automatic environment and app setup in user data. Feel free to add more to this example (security group, key pair, etc.). List of the Node SDK API is [here](http://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/EC2.html). It closely follows and mimics the AWS CLI commands. My example is this (code/sdk/provision-infra.js)

```js
// Load the SDK for JavaScript
const AWS = require('aws-sdk')
// Load credentials and set region from JSON file
// AWS.config.loadFromPath('./config.json')

// Create EC2 service object
var ec2 = new AWS.EC2({apiVersion: '2016-11-15', region: 'us-west-1'})
const fs = require('fs')
var params = {
  ImageId: 'ami-9e247efe', // us-west-1 Amazon Linux AMI 2017.03.0 (HVM), SSD Volume Type
  InstanceType: 't2.micro',
  MinCount: 1,
  MaxCount: 1,
  UserData: fs.readFileSync('./user-data.sh', 'base64'),
  GroupIds: ['SECURITY_GROUP_ID']
}

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


Imagine a scenario in which you can pass a link to the source code separately from the user data. In other words, our Node and user data scripts can be used without modifications for future deployments of the new versions of the app Node Hello World... or a fully-functional REST API? It's up to you. The EC2 environment is good for production. :-)


## 4. Launch EC2

The way you launch a Node script is with the `node {filename.js}` command. For example,

```
cd code/sdk
node provision-infra.js
```

Note: You must have `user-data.sh` in the same folder as your Node script or change the path to the `user-data.sh` in `provision-infra.js`.

Notice the instance ID. My output was:

```
Created instance i-04dd20a0983596f9c
Tagging instance success
```

## 5. Test and terminate

Wait a few moments (anywhere from 30seconds to 1-2 minutes) and get the public URL (DNS name) using the instance ID from step 4. (See lab 1 for how to do it; hint: `describe-instances`.)

Open the public URL in the browser and observe hello world.

Reboot your instance using `reboot-instances` and instance ID. For example,

```
aws ec2 reboot-instances --instance-ids i-04dd20a0983596f9c
```

Terminate your instance using its ID.

# Troubleshooting

* The instance is running but I don't see Hello World: Make sure you are looking at the same port (80 or 3000 or some other value) as you have in your environment variable and/or Node server source code
* I still don't see anything: Make sure your security group and network (some corporate networks block non-standard ports like 3000) are open. You might have to create a new security group and/or go on a guest network without corporate proxy.
