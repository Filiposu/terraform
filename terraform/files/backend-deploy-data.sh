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

mkdir -p /src/my-backend-app

cd /src/my-backend-app

cat << HEREDOC > ./Phonebook.pem
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAs++OR0evv9/GjD88zv77cSgz3dBycuhs8xSLxyp9xYVxKlEB
4bG3GNhfDQheVrIC67cXcua/RdLl5EWxGHI2pyHMsZwocK229fff3DhVibtpDfLp
gIOlS2ZW/saVa4psGqrStRraU2UxZyUE6EWGAvy+emkxfiZFbfb3aNbYztEMV4KE
e+1TL27A8HH25o4qaaL+pBL1+fQxeSB5nuSnhlIvpzU7jHY/8SUigE8u3CCZJxE5
Z7hAfnEvlCsSVLAP3VBgOxqRi7koyDd3e3oANFC8s7AXZE0w8ma3T6qmZYtDtx/5
LukWqQZuE0gvtsbXtH8HaD+JRFaJWaax4r560QIDAQABAoIBAQCGM0ILebTjx1N/
IF8LB3OjRtfANQpXF3DCr2084z0gx1DKvdZIbVJhDmd+AeLSiDvTcB/mC6FWw1/A
rBXUZMLMTlIrmYsz1uwhcXkd90ocypEk3So4Nndez/pMVPH2XiwYi5VRi7CQCGYb
RqntToUPz0+FXtWR/5tC07JdF/hl7pIKAsC7xTIoxzBqE0EP7HgJDLpK5GAaNHZQ
OrZljHY7owAGz/fmJpC0IyGOpj3DrW97pKxZHFO0gzBrU5XKlqrrr1YsiRZJ1gI6
Z4m2KsTQwLoHxj8gTsE9SnJ/49SfoOsloOJaEEEAu8BnnuUzUBP0jdiD+n4s6XL6
bp7bxa4RAoGBAPxaC4Pwru1rjuG7HDgDi92E5+QsbHgaqd3IfvKsB5SVp1RT+ArO
dEnhfDhA8PiJAuTAdkJEwCOWJszxMiVI8UpJ4C5IYSBQ97ix6yr8Jot70ynejmRk
aUMuxPrIVsGbBZ/zJnaq0YBnJUiEAIxhsfT1vTpS7vKqc0f+neA5qKu1AoGBALaJ
f7lJOfTguxqsMzLqasrbJHPN2X+9K7ooEfyvQSF/54tl16YUsJfk1DxAQmo/uIb9
70MBzWMRmULhIUz2kApzkTO8Ghg5o3QIsUPngEXNFMt4/6lm1nc5sK9lihPQxc33
P7UFToGXLWx/pljm+UnQdz77f971kMblEZ8fXpwtAoGBAL/s7B0pDKHd0Am2eTvQ
1qtfzc4oS0b9YHwhZQvD8u/68gyc4GW3p5IZQJS4L42XBvBbwJWeHFP0ewYb23uo
Anvxu+L3gYdGjWGXT7idleM4Bd4uOjX4eGZ0R7REcldFQ/3mvDY8rKHv0NdaLeCW
3PXlgEm/kaRWJt92szQ6JiKRAoGAOxYbEAESD6BHMIUZNZwH4Y46KHozs1OqueGK
oP6h2JQsgUUAHzSHTUO3J6GtXfMuahP8xPXqY+0obSuuudj+G0P5doOm9ryBmmfN
6asgLHgMCSkrqMwvE/zKopv9rBhiTx9/sbr8BJrJC1vunsx1WV1vnCWQ6L0YlilE
IPvohikCgYA67+bQNvidfZrFbr3biqv63eRQysA6ax1B5fl+BjtBxB/hH1/XIx7d
Hn2Pzl7QRlUe3rHexKniqecHP4U6khM3TeX/NDQ7SROMteaZBGcqiH7+p1OWg4dw
LwSff9zPVDmzRKztWUIElDgViZFy5xGRt0H4bJ/gQ2GbHaeHwbSe4w==
-----END RSA PRIVATE KEY-----
HEREDOC

ssh-keyscan github.com >> /root/.ssh/known_hosts
git clone git@github.com:Filiposu/terraform.git

cd terraform/backend

docker build -t my-backend-app:v1.0.0 .
docker run -di -e MYSQL_URL=${msql_url} -e MYSQL_USERNAME=${msql_username} -e MYSQL_PASSWORD=${msql_password} --name my-backend-app -p 80:80 my-backend-app:v1.0.0
