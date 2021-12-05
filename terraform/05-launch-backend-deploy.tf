//Creating backend-instance-ec2-key
//resource "aws_key_pair" "backend-instance-ec2-key" {
//  key_name   = "backend-instance-ec2-key"
//  public_key = "/~/.aws/credentials/id_rsa.pub"
//}

//Launch backend instance from sh file
data "aws_ami" "launch_configuration_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "backend" {
  template = file("files/backend-deploy-data.sh")

  vars = {
    msql_url = "jdbc:mysql://${aws_db_instance.mysql.address}:${aws_db_instance.mysql.port}/${aws_db_instance.mysql.name}"
    msql_username = aws_db_instance.mysql.username
    msql_password = aws_db_instance.mysql.password
  }
  depends_on = ["aws_db_instance.mysql"]
}

resource "aws_launch_template" "launch-backend" {
  name = "lt-backend"

  instance_type = "t2.micro"

  image_id = data.aws_ami.launch_configuration_ami.id

  instance_initiated_shutdown_behavior = "terminate"

  update_default_version = true

  key_name = "Phonebook"

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = aws_subnet.private-subnet-1.id
    security_groups             = [
      aws_security_group.ec2_private_security_group.id,
      aws_security_group.allow-ssh.id
    ]
  }

  placement {
    availability_zone = "eu-west-1a"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "my-backend-app"
    }
  }

  user_data = base64encode(data.template_file.backend.rendered)
//  user_var  = templatefile("files/backend-deploy-data.sh",
//  { url = db_instance_address, username = db_instance_username, password = db_instance_password })
}
