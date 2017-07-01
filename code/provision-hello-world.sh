aws ec2 create-security-group --group-name \
  http-sg-test --description "HTTP security group"
aws ec2 authorize-security-group-ingress \
  --group-name http-sg-test --protocol tcp --port 80 --cidr 0.0.0.0/0
IMAGE_ID=$(aws ec2 describe-images --owners amazon \
  --filters "Name=virtualization-type,Values=hvm" "Name=root-device-type,Values=ebs" \
  "Name=name,Values=amzn-ami-hvm-2017.03.0.20170417-x86_64-gp2" \
  --query 'Images[0].ImageId' --output text)
echo "Amazon Linux 2017.03.0 for this region has AMI ID: ${IMAGE_ID}"
INSTANCE_ID=$(aws ec2 run-instances --image-id ${IMAGE_ID} \
  --count 1 --instance-type t2.micro \
  --security-groups http-sg-test \
  --user-data file://httpd-hello-user-data.sh --output text --query 'Instances[0].InstanceId')
echo "Launching instance with ID: ${INSTANCE_ID}"
