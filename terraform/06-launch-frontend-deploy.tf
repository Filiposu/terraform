//resource "aws_key_pair" "frontend-instance-ec2-key" {
//  key_name   = "frontend-instance-ec2-key"
//  public_key = "/~/.aws/credentials/id_rsa.pub"
//}

//Launch Frontend instance
data "template_file" "frontend" {
  template = file("files/frontend-deploy-data.sh")

  vars = {
    backend_url = aws_lb.auto-load-balancer-backend.dns_name
  }
  depends_on = [aws_lb.auto-load-balancer-backend]
}

resource "aws_launch_template" "launch-frontend" {
  name          = "lt-frontend"
  instance_type = "t2.micro"

  image_id = data.aws_ami.launch_configuration_ami.id

  instance_initiated_shutdown_behavior = "terminate"

  update_default_version = true

  key_name = "Phonebook"

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.public-subnet-1.id
    security_groups = [
      aws_security_group.ec2_public_security_group.id,
      aws_security_group.allow-ssh.id
    ]
  }

  placement {
    availability_zone = "eu-west-1a"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "my-frontend-app"
    }
  }

  user_data = base64encode(data.template_file.frontend.rendered)
  depends_on = ["aws_lb.auto-load-balancer-backend"]

}