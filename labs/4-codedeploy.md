# Lab 4: Never deploy (manually) again!

In a competitive marketplace, the time to market is one of the best advantages a company can have. By delivering products and services faster to customers, validating assumptions and fixing bugs, companies can outcompete slower incumbents (or defend off startups).

As a software engineer, gone are the days of 6 or even 12-month release cycles. The best tech companies deliver code to production multiple times per day. How do they do it? By automating as much as possible with Continuous Integration and Delivery.

Creating CI/CD has long been a tough task requiring high expertise and knowledge of special technologies and libraries, e.g., Jenkins. However, with AWS CodeDeploy and CodePipeline, anyone can create a fully functional CI environment in just a few minutes.  


For example, you have some infrastructure provisioned and pull code from GitHub. You update the code in GitHub and in a few moments your changes are live on the public facing HTTP web server. Auto-magic! 🏭🔮

Let's learn how to create this CI now.

# Task

Task: Build CI with CodeDeploy and code from GitHub, update code, and see the changes in a browser


# Walk-through

If you would like to attempt the task, then skip the walk-through and go for the task directly. However, if you need a little bit more hand holding or you would like to look up some of the commands or code or settings, then follow the walk-through.

1. Switch to Oregon `us-west-2` region
1. Create Stack: create an instance with CloudFormation
1. Create CodeDeploy
1. Create App Repo: create and push app and deployment scripts to GitHub
1. Create CodePipeline
1. Test Continuous Integration (CI) by making changes to GitHub and seeing them deployed automatically


## 1. Switch to us-west-2

```
aws configure
AWS Access Key ID [****************4X4Q]:
AWS Secret Access Key [****************RXSI]:
Default region name [us-west-1]: us-west-2
Default output format [json]:
```

## 2. Create Stack

The stack has instances with CodeDeploy agent, security groups, SSH key pairs, CloudWatch alerts and other things (details in codedeploy-cf-tpm-t2-hvm-3-ec2.json which has HVM and t2 type and is modeled after [CF t1 template ](http://s3-us-west-2.amazonaws.com/aws-codedeploy-us-west-2/templates/latest/CodeDeploy_SampleCF_Template.json), details  [here](http://docs.aws.amazon.com/codedeploy/latest/userguide/instances-ec2-create-cloudformation-template.html))

Make sure you are using the key from the `us-west-2` region since `us-west-1` region doesn't support Pipeline yet.
In my example, my key name is `azat-aws-course-aws-us-west-2.

```
aws cloudformation create-stack \
  --stack-name NodeAppCodeDeployStack \
  --template-body file://codedeploy-cf-tpm-t2-hvm-3-ec2.json \
  --parameters ParameterKey=InstanceCount,ParameterValue=1 ParameterKey=InstanceType,ParameterValue=t2.micro \
    ParameterKey=KeyPairName,ParameterValue=azat-aws-course-aws-us-west-2 \
    ParameterKey=OperatingSystem,ParameterValue=Linux \
    ParameterKey=SSHLocation,ParameterValue=0.0.0.0/0 ParameterKey=TagKey,ParameterValue=Name \
    ParameterKey=TagValue,ParameterValue=NodeAppCodeDeploy \
  --capabilities CAPABILITY_IAM
```

The result will have stack ID because the stack won't be created instantaneously. For example:

```
{
    "StackId": "arn:aws:cloudformation:us-west-2:161599702702:stack/NodeAppCodeDeployStack/2c9819a0-291f-11e7-a213-503f2a2ceeba"
}
```

You can get current the info about the stack, its status and its creation progress with:

```
aws cloudformation describe-stacks
```

You can monitor progress and debug any issues at the web console as well: <https://us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks>.

```
aws cloudformation wait stack-create-complete --stack-name NodeAppCodeDeployStack
```

## 3. Create CodeDeploy

### 3.1. Create CodeDeploy Service IAM role

There are two things needed: trust policy and managed policy.

Before you create CodeDeploy, it needs IAM role with a special policy. This special policy can be provided in a JSON format (e.g., `codedeploy-role-trust-policy.json`):

```js
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "codedeploy.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

Here's the command to create a role and add a trust relationship policy from a file:

```
aws iam create-role --role-name CodeDeployServiceRole --assume-role-policy-document file://codedeploy-role-trust-policy.json
```

Your output will look similar to this *except* for the Arn:

```js
{
    "Role": {
        "AssumeRolePolicyDocument": {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Action": "sts:AssumeRole",
                    "Principal": {
                        "Service": [
                            "codedeploy.amazonaws.com"
                        ]
                    },
                    "Effect": "Allow",
                    "Sid": ""
                }
            ]
        },
        "RoleId": "AROAIGUSSHLBINITCLP4K",
        "CreateDate": "2017-04-21T22:16:41.062Z",
        "RoleName": "CodeDeployServiceRole",
        "Path": "/",
        "Arn": "arn:aws:iam::161599702702:role/CodeDeployServiceRole"
    }
}
```

For the managed policy, use the  [attach-role-policy](http://docs.aws.amazon.com/cli/latest/reference/iam/attach-role-policy.html) command with your newly created role name (e.g., `CodeDeployServiceRole`) and the policy Arn (i.e., `arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole` - **do NOT change Arn**):

```
aws iam attach-role-policy --role-name CodeDeployServiceRole --policy-arn arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole
```

The right away to verify:

```
aws iam get-role --role-name CodeDeployServiceRole
```

Or just get the Role.Arn to use later:

```
aws iam get-role --role-name CodeDeployServiceRole --query "Role.Arn" --output text
```

Remember your newly created IAM role Arn. You will need it to create deployment group.

My output is:

```
arn:aws:iam::161599702702:role/CodeDeployServiceRole
```

Save yours!

## 3.2. Create an application with CodeDeploy

Next, you need to create an application. Run the following:

```
aws deploy create-application --application-name Node_App
```

Response example:

```
{
    "applicationId": "1344dfd5-eb91-4940-bd07-5bb55aff5db7"
}
```

More info: <http://docs.aws.amazon.com/cli/latest/reference/deploy/create-application.html>

### 3.3. Create CodeDeploy deployment group

Finally for CodeDeploy, create a deployment group which uses application name and instance tags. In other words, deployment group will link application and instance(s) (which we created with CloudFormation). **Instead of my service role Arn, insert yours from the CodeDeploy service role in step 3.1.** (Hint, those digits in the IAM Arn is your AWS account ID. More details [here](http://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-iam))

```
aws deploy create-deployment-group --application-name Node_App \
  --deployment-config-name CodeDeployDefault.OneAtATime \
  --deployment-group-name NodeCD_DG \
  --ec2-tag-filters Key=Name,Value=NodeAppCodeDeploy,Type=KEY_AND_VALUE \
  --service-role-arn arn:aws:iam::161599702702:role/CodeDeployServiceRole
```

The `--deployment-config-name CodeDeployDefault.OneAtATime` means one at a time. There's all at once and half at once options as well.

Your result will have a deploymentGroupId as well:

```
{
    "deploymentGroupId": "e4d34ce4-e25c-44c5-b3c4-064065ce474a"
}
```


More info: <http://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-groups-create.html>

## 4. Create App Repo

You can use the provided GitHub repository <https://github.com/azat-co/codedeploy-codepipeline-node> which has a Node HTTP server and shell scripts, but if you want to modify the code you will need to do:

1. Fork repository to have your own copy which you can modify (commit and push)
1. Create a new repository from scratch following steps below

Create application code with the following structure

```
/scripts
appspec.yml
server.js
```

The `appspec.yml` will have instructions for AWS on how to deploy the code (and even verify it!). For example, my `appspec.yml` is using four scripts and copying the source file into `/var/www`:

```yml
version: 0.0
os: linux
files:
  - source: server.js
    destination: /var/www/
hooks:
  BeforeInstall:
    - location: scripts/install_dependencies.sh
      timeout: 300
      runas: root
  ApplicationStart:
    - location: scripts/start_server.sh
      timeout: 300
  ApplicationStop:
    - location: scripts/stop_server.sh
      timeout: 300
      runas: root
  ValidateService:
    - location: scripts/validate_server.sh
      timeout: 300
      runas: root
```

There are more possible configs like the ones shown below:

![](../images/appspec.png)

The `server.js` file is our HTTP server written in Node.js. It uses Node version 6 and ECMAScript2015 (ES6). It will display Hello World HMTL when you navigate to the public URL (public DNS name without port). No port necessary because 80 is the default HTTP port. You can also provide a custom port number in environment variable `PORT`.

```js
const port = process.env.PORT || 80
require('http')
  .createServer((req, res) => {
    console.log(`incoming url: ${req.url} and incoming method: ${req.method}`)
    res.writeHeader(200,{'Content-Type': 'text/html'})
    res.end('<h1>Hello World from CodeDeploy and CodePipeline</h1>')
  })
  .listen(port, (error)=>{
    console.log(`server is running on ${port}`)
  })
```

`scripts/install_dependencies.sh`:

```
#!/bin/bash
# update yum just in case
yum update -y
# get node into yum
curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
# install node and npm in one line
yum install -y nodejs
# install pm2 to restart node app
npm i -g pm2@2.4.3
```

`scripts/start_server.sh`:

```
#!/bin/bash
# sudo chmod 755 /var/www/server.js # optional
# this will restart app/server on instance reboot
crontab -l | { cat; echo "@reboot pm2 start /var/www/server.js -i 0 --name \"node-app\""; } | crontab -
sudo pm2 stop node-app
# actually start the server
sudo pm2 start /var/www/server.js -i 0 --name "node-app"
```

`scripts/stop_server.sh`:

```
#!/bin/bash
sudo pm2 stop node-app
```

`scripts/validate_server.sh`:

```
#!/bin/bash
curl -m 5 http://localhost
```


Save files, create a GitHub repository, commit code and push it to the GitHub repository.

## 5. Create CodePipeline

Now we can connect source code repository like GitHub (or S3) to CodeDeploy to enable CI.
CLI is a bit cumbersome because you'll need to manually create IAM role and S3 bucket. We will cover it first then cover the web console wizard which is very straightforward because it creates the role and bucket for you.

If you use web console, wizard will create S3 bucket and IAM role for you. Thus, use web console for this step or the following AWS CLI commands.

Thus, you have two options:

* CodePipeline via CLI (option A): create IAM role and pipeline from CLI - recommended
* CodePipeline via Web Console (option B): by using wizard, no need to create role or pipeline structure manually - easier

### 5.1. CodePipeline via CLI (option A)

Create a bucket to store artifacts for the pipeline. Be careful with the name. It must be globally unique.

```
aws s3 mb s3://node-app-pipeline-bucket-346128301596 --region us-west-2
```

You will need a role for the pipeline. It will need to have two things: trust policy and inline policy.

First, create a role with the trust policy document from a file. This is the trust policy document:

```js
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "codepipeline.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

This is the command to create the role with the trust policy:

```
aws iam create-role --role-name CodePipelineServiceRole \
  --assume-role-policy-document file://codepipeline-role-trust-policy.json
```

The output will be like this one:

```js
{
    "Role": {
        "AssumeRolePolicyDocument": {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Action": "sts:AssumeRole",
                    "Principal": {
                        "Service": [
                            "codepipeline.amazonaws.com"
                        ]
                    },
                    "Effect": "Allow",
                    "Sid": ""
                }
            ]
        },
        "RoleId": "AROAJ6VXDGROHN24YWHRW",
        "CreateDate": "2017-04-25T15:34:58.529Z",
        "RoleName": "CodePipelineServiceRole",
        "Path": "/",
        "Arn": "arn:aws:iam::161599702702:role/CodePipelineServiceRole"
    }
}
```

Now add inline policy (different from trust policy above) from a file:

```
aws iam put-role-policy --role-name CodePipelineServiceRole --policy-name CodePipelineServiceRoleNodeAppPolicy --policy-document file://codepipeline-role-inline-policy.json
```


Get GitHub token (for CLI): <https://github.com/settings/tokens>.

![](../images/github-oauth-token.png)


I have access to public repo in GitHub access token setting. Obviously, if your repository is private, you'll need to give access to CodePipeline via the personal access token setting.

![](../images/github-oauth-token-2.png)

Here's my example of the CodePipeline structure which is also in the `node-app-pipeline.json` (remember, you'll need to replace a few values listed below the JSON):

```
{
    "pipeline": {
        "roleArn": "arn:aws:iam::161599702702:role/CodePipelineServiceRole",
        "stages": [
            {
                "name": "Source",
                "actions": [
                    {
                        "inputArtifacts": [],
                        "name": "Source",
                        "actionTypeId": {
                            "category": "Source",
                            "owner": "ThirdParty",
                            "version": "1",
                            "provider": "GitHub"
                        },
                        "outputArtifacts": [
                            {
                                "name": "MyApp"
                            }
                        ],
                        "configuration": {
                            "Owner": "azat-co",
                            "Repo": "codedeploy-codepipeline-node",
                            "Branch": "master",
                            "OAuthToken": "****"
                        },
                        "runOrder": 1
                    }
                ]
            },
            {
                "name": "Staging",
                "actions": [
                    {
                        "inputArtifacts": [
                            {
                                "name": "MyApp"
                            }
                        ],
                        "name": "NodeCD_DG",
                        "actionTypeId": {
                            "category": "Deploy",
                            "owner": "AWS",
                            "version": "1",
                            "provider": "CodeDeploy"
                        },
                        "outputArtifacts": [],
                        "configuration": {
                            "ApplicationName": "Node_App",
                            "DeploymentGroupName": "NodeCD_DG"
                        },
                        "runOrder": 1
                    }
                ]
            }
        ],
        "artifactStore": {
            "type": "S3",
            "location": "node-app-pipeline-bucket-346128301596"
        },
        "name": "node-app-pipeline",
        "version": 3
    }
}
```

The structure has two stages: source and deploy. You can keep adding more stages later like testing or build. See [this](http://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html) for more info on pipeline structure.

**IMPORTANT:** You should at the very least replace the following because create-pipeline CLI won't create them for you. So you need to have CodePipeline service IAM role and the S3 bucket created first.

* `artifactStore`, S3 bucket name for the bucket in the same region, e.g., my value is `codepipeline-us-west-2-346128301595`
* `roleArn`, the IAM role which has the inline policies for the CodePipeline, e.g., `arn:aws:iam::161599702702:role/CodePipelineServiceRole`
* `OAuthToken`: your GitHub Access OAuth token (personal or from an app)

Other values you might need to modify, depending on what values you used in the previous steps of this lab, are:

* `ApplicationName`: your application name from CodeDeploy, e.g., `Node_App`
* `DeploymentGroupName`: your deployment group name from CodeDeploy step, e.g., `NodeCD_DG`
* `name`: arbitrary name
* `Owner`: your GitHub username
* `Repo`: your GitHub repository
* `Branch`: your GitHub repository branch (e.g., master)

Once you've got your JSON pipeline structure with your own values and have saved it in some file (e.g., `pipeline.json`), run this to create a new pipeline:

```
aws codepipeline create-pipeline --cli-input-json file://pipeline.json
```

More info: <http://docs.aws.amazon.com/codepipeline/latest/userguide/pipelines.html>

Some useful commands:

```
aws codepipeline update-pipeline --cli-input-json file://pipeline.json
aws codepipeline start-pipeline-execution --name node-app-pipeline
```

Funny thing is that even [AWS docs recommend creating pipeline structure from existing pipelines](http://docs.aws.amazon.com/codepipeline/latest/userguide/pipelines-create.html#pipelines-create-cli-json). You can export a pipeline JSON from an existing pipeline with this command:

```
aws codepipeline get-pipeline --name node-app-pipeline
```

Of course, it's of little use if you are creating the first pipeline. However, there's a web wizard. Let's use it just as an alternative to CLI.

### 5.1. CodePipeline via Web Console (option B)

This step is optional. We use mostly use CLI during this course, but because pipeline creation involved a few steps, you might want to consider using web console and its pipeline wizard.

To use web wizard, simple go to Oregon `us-west-2` region, Developer Tools | CodePipeline. Click on Create pipeline.

Enter pipeline name:

![](../images/codepipeline-wizard-1.png)

Connect with GitHub by entering your GitHub credentials.

![](../images/codepipeline-wizard-2.png)

Select the app repository, the one which has `appspec.yml`.

![](../images/codepipeline-wizard-3.png)

Skip build. Builds are important and you will be able to add more stages later.

On the screen after that which is number 4: Source, select AWS CodeDeploy, your app name (create before) and group (also created before in this lab).

![](../images/codepipeline-wizard-4.png)

On screen 5, you can select an existing pipeline service role if you have it or click the button to let the wizard create a new role with appropriate policy for you.

```
aws codepipeline get-pipeline --name node-app-pipeline
```

The end result of creating the pipeline should look like the one shown below:

![](../images/codepipeline-wizard-5.png)

It shows you the GitHub hash of the commit, and status of the deployment. The first deployment should start automatically. The next will be started on each new `git push` to GitHub or by pressing "Release change".


## 6. Test CI

Once deploy is done without error as shown in the deploy web console, you can grab the public URL and verify that you can see Hello World HTML in the browser.

![](../images/pipeline-success.png)

Go to your GitHub repository and modify `server.js` by changing Hello World text. You can use code editor and git CLI to commit and push or use GitHub web interface. If you are using GitHub website, you can commit right to master from there, see below:

![](../images/github-edit.png)



Verify that Pipeline started the deploy. Wait and verify that your new text appears on the public website. You can monitor the stages and progress in the CodePipeline web dashboard.

Congratulations. 👏 You've created a CI with ability extend to CD (add builds!) in just under a half-hour or so.

Now that you know what steps are involved, you can create a CloudFormation file which will create the steps 2, 3 and 5 in this labs in one command (stack/instances, CodeDeploy and Pipeline). In other words, you will be able to just run `aws cloudformation creat-stack...`. Take a look at [this example](https://github.com/andreaswittig/codepipeline-codedeploy-example/blob/master/deploy/stack.yml) in which all you need is just run `setup.sh` (for more details, see [GitHub readme.md](https://github.com/andreaswittig/codepipeline-codedeploy-example)).

# Troubleshooting

* Cannot see Hello World on the deployed public URL. Go to your pipeline view from [pipeline dashboard](https://us-west-2.console.aws.amazon.com/codepipeline/home?region=us-west-2#/dashboard), e.g., [node-app-pipeline view](https://us-west-2.console.aws.amazon.com/codepipeline/home?region=us-west-2#/view/node-app-pipeline). See if you have failed deploy. By clicking on failed deploy you can see logs of each script like BeforeInstall.
* CloudFormation fails when you try to create stack (EC2 instance with CodeDeploy agent): you can trouble shoot/debug from the CloudFormation dashboard by inspecting events and logs. Alternitevely, you can [create CodeDeploy EC2 instance manually](http://docs.aws.amazon.com/codedeploy/latest/userguide/instances-ec2-create.html). Make sure you tag is accordingly and the instance has CodeDeploy agent or use an image with CodeDeploy (Amazon Linux CodeDeploy AMI).
* Source stage fails in CodePipeline. Make sure your GitHub access token has enough permission to access your repository.
