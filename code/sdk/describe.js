// Load the SDK for JavaScript
const AWS = require('aws-sdk')
// Load credentials and set region from JSON file
// AWS.config.loadFromPath('./config.json')

// Create EC2 service object
const ec2 = new AWS.EC2({apiVersion: '2016-11-15', region:'us-west-1'})
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
