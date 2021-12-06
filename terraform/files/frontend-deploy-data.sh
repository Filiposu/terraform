#!/bin/bash

yum update
yum install docker -y
usermod -aG docker ec2-user
systemctl enable docker
systemctl start docker

yum install git -y

cat << HEREDOC > /root/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACBLZDkNAMvjtGReFFGKTPrPRzofCKanez2IIGV87UVaSwAAAJi3s1DYt7NQ
2AAAAAtzc2gtZWQyNTUxOQAAACBLZDkNAMvjtGReFFGKTPrPRzofCKanez2IIGV87UVaSw
AAAEDTaUcBnKcdE7R7s8dHPDd0z2wiSpQIGDR6tQe1qonmkUtkOQ0Ay+O0ZF4UUYpM+s9H
Oh8Ipqd7PYggZXztRVpLAAAAE3RvZ3J1bDEyNUBnbWFpbC5jb20BAg==
-----END OPENSSH PRIVATE KEY-----
HEREDOC

chmod 0400 /root/.ssh/id_rsa

mkdir -p /src/my-frontend-app

cd /src/my-frontend-app

ssh-keyscan github.com >> /root/.ssh/known_hosts
git clone git@github.com:Filiposu/terraform.git

cd frontend

docker build -t my-frontend-app:v1.0.0 .
docker run -di -e PHONEBOOK_API=${backend_url}  --name  my-frontend-app -p 80:80  my-frontend-app:v1.0.0
