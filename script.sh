https://learn.acloud.guru/cloud-playground/cloud-sandboxes
Ubuntu 20.04

firewall rule 8080
firewall rule 9000

ssh -i vm_key_15.pem azureuser@20.29.34.154

sudo su - 

apt-get remove docker docker-engine docker.io containerd runc

apt-get -y update && apt-get -y upgrade

apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get -y update

chmod a+r /etc/apt/keyrings/docker.gpg
apt-get -y update

apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

groupadd docker
usermod -aG docker $USER
exit

docker run hello-world:latest

docker run --privileged -d -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker --name jenkins jenkins/jenkins

chmod 666 /var/run/docker.sock

docker exec -ti -u0 jenkins bash

cat /var/jenkins_home/secrets/initialAdminPassword
d8ce6134c08f46e290fa3d5daa0afe14

http://20.29.34.154:8080/
# paste initial Admin Password 
# Install suggested plugins
# Create user
# Manage Jenkins > Configure Global Security > CSRF Protection - Enable Proxy compatibility
# Manage Jenkins > Manage Plugins > install docker pipeline plugin -- download and restart

docker start jenkins

# Manage Jenkins > Global tool configuration > Docker settings
# Manage Jenkins > manage credentials > system > global credentials > add

create access token from hub.docker.com
Username: abubakarriaz
Password: dckr_pat_wTgvVMBAaz-Gm_AuZmDpE-U5zSw
ID: docker-hub-abubakarriaz
Description: access token for docker hub image pushing

# Create pipeline > copy jenkins file

docker run --privileged -d --name sonarqube -p 9034:9000 -p 9092:9092 sonarqube:latest

http://20.29.34.154:9000/
admin
admin
project-key: CAPSrage
sqp_a46efcb94297400f5e4c1c3f34c32431b107df69


dotnet tool install --global dotnet-sonarscanner
dotnet sonarscanner begin /k:"CAPSrage" /d:sonar.host.url="http://20.29.34.154:9000"  /d:sonar.login="sqp_a46efcb94297400f5e4c1c3f34c32431b107df69"
dotnet build
dotnet sonarscanner end /d:sonar.login="sqp_a46efcb94297400f5e4c1c3f34c32431b107df69"