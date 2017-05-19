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
  SecurityGroups: ['http-sg']
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
