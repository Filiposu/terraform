README details for terraform will be added later.

First of all we need to run jenkins inside minikube. This will help us to run k8s commands from jenkins.

docker image build -t myjenkins .

Name {myjenkins} is important because we will use it for k8s pod .