#!/bin/bash

yum update
yum install docker -y
usermod -aG docker ec2-user
systemctl enable docker
systemctl start docker

yum install git -y

cat << HEREDOC > /root/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAACmFlczI1Ni1jdHIAAAAGYmNyeXB0AAAAGAAAABCcP1wdUf
P9wzGfB2mmO6sCAAAAEAAAAAEAAAEXAAAAB3NzaC1yc2EAAAADAQABAAABAQCiJ5J0+Og9
r8Nh/0ovjPUkvjWdMqEVZsOUpC1AS+f39ooroLJCkpmzSUE/Hv+ZwrQ59UXenAyoHIOIlX
qcLQOnzYyvTMcxwh2tsyJc9lfNqrKLEMOJX6MusIwPsdTH8Ak8qBoIeKO0x1YKmiNOzVfV
2qteyJxxKR+zES+C5jONT98Y7yulBzF3aWVI5pT8fjVKR4ntq3ux5M6Kls5ZUEDGNiWCPN
ef2NfdnOHFqYAeHKsEGsJ7K34CR7TZQjV0UI/qAaV8ly7eGHLykTDv/MtOPsZ3fLBUtX82
7pReCzZ9jYkIdz9cqfInAYwm4xXQTGRkD071b2jdqPDCHJrvwc8hAAAD0MaZFD7HFTAF9w
cfwLp74smQaMCwpMk6Hdh+xXGLXms2QLzwIDtQdfDBs6l21yXu/Jrq0WirYYigeGAk4ap1
yxjLxKq83kKXjesiqhNT4Dh0ZJj1JQhJRedovyrPnx8Zr2oEwamstqMMiDXD/pppygyxLS
EH1qjxw/uincV7AcSILv2ZNxY+wf5fmmVwmCcYsFUO07egVv/rECzZhmbHBlHhaEhr61d5
YwDeW1nvGVGG7qC0o+8QtDgyhZwyJfJuQ7DATDBXeiIBNHOAYrOzYBlJLKEh8TdeTgi7+m
9RTGqs3F5fbM1fHhur6+MfzJt/FSKtS3OEoqtbgctzPvaSQAwo94ExLyvz6xG/Z9iDIV6s
Tf3kAiDCkdryxNylcv1SLo3WFvLisq3KmWje8PJlA1Q5EyvqJLSGbwZ4Q0u/EhIt27JsRv
kFUhdTcjaPMZVTLEyMh7g82/5y1JVWlMpthrcY4l0VT6t+W6JCWXpUz03gR82zxKDtWIj4
STNGNJf5Ig8wAWQvblgYYUISrz4ASDPJybXIeCgAv5irri7m5ejrpO4WGgDctObGLjci85
LbqL9cyV6ssS4w+VZ767FOHMoWkCpVIvxhxLi8wqeYG4VjdVqBd/15vnBrD0TazGftcicA
DYaO8WteP4SwCXWyzCR956fa5VWN+ap7v6YyZ98pDRjc3vKbpSMa8JCOwrG7KeoIJIBoUW
o0/5zIhB4aNOm6zhrH/KgPvJlOJhTp8kmqVLN2F02ZsU57qaSMIqsFFoxonx8gns62LD2g
lO+891T3qqf3HmdEXQ/S7iAupdc3Iwq7mquVCVPUBOp+/Vw8dUQ6zh7/6kgRC51SKkynAL
xHGiENlr0BdTIvGhaRT2EpegPgqsQPLkhlwJPvyZ1QEWuJlLQiYRRIf4r0ZafGXDNG6l1X
yVa2ru4VSXOF7vJ/VVKFFh37mIE5Fm59Xk/zK1p8xl3/8US033OeE9AzG/utyAEAsBjVp3
Eql24q0IAxyp8PBVPJMHoThsbIHMYD6xhD29VKBbprBY6sns3FrypUgDA0MKTkABKS1qfD
ETEHarHe/fsxxnyia+ew9uSQMUYoFx3C4ul+rvdIz3aKbysP4KVUC1/saVi0IN/sgl6JLd
ovrp9g0hOghkP8jVNLVahgiUi1rIlKWNp5YsRy3x4wF4iL9qpvoxGRXD1ZanvvIr8hI3gH
5MXBb9T+YUouh7FXlkHdLECJ0JHfttGVVwl77ZVgeQ/TQpyXgmONix5Y8UyFr22Rlj4E+D
VIbGvesRQyqL+79MUZm3f6Dgfy+F0=
-----END OPENSSH PRIVATE KEY-----
HEREDOC

chmod 0400 /root/.ssh/id_rsa

mkdir -p /src/my-backend-app

cd /src/my-backend-app

ssh-keyscan github.com >> /root/.ssh/known_hosts
git clone git@github.com:Filiposu/terraform.git

cd backend

docker build -t my-backend-app:v1.0.0 --build .
docker run -di -e MYSQL_URL=${msql_url} -e MYSQL_USERNAME=${msql_username} -e MYSQL_PASSWORD=${msql_password} --name my-backend-app -p 80:80 my-backend-app:v1.0.0
