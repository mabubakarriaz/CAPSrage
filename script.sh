https://learn.acloud.guru/cloud-playground/cloud-sandboxes
Ubuntu 20.04 LTS Gen2 Focal

inbound rule 8080
inbound rule 9000

ssh -i vm_key_18.pem azureuser@20.15.204.53

sudo su - 

apt-get remove docker docker-engine docker.io containerd runc

apt-get -y update && apt-get -y upgrade

apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get -y update

chmod a+r /etc/apt/keyrings/docker.gpg
apt-get -y update

VERSION_STRING=5:20.10.21~3-0~ubuntu-focal
apt-get -y install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-compose-plugin

usermod -aG docker $USER
exit

docker run hello-world:latest

docker pull jenkins/jenkins:2.361.3-lts
docker run --privileged -d -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker --name jenkins jenkins/jenkins:2.361.3-lts

chmod 666 /var/run/docker.sock

docker exec -ti -u0 jenkins bash

cat /var/jenkins_home/secrets/initialAdminPassword
7127c1f90f074579b9b52e7e7829ddb8

http://20.15.204.53:8080/
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

docker pull sonarqube:9.7.1-community
docker run --privileged -d --name sonarqube -p 9000:9000 -p 9001:9001 sonarqube:9.7.1-community

http://20.15.204.53:9000/
admin
admin
project-key: CAPSrage
token name: CAPSrage-1
sqp_aa175b0b08e2d771e72b3add648abd898c9781e6


dotnet tool install --global dotnet-sonarscanner
dotnet sonarscanner begin /k:"CAPSrage" /d:sonar.host.url="http://20.15.204.53:9000"  /d:sonar.login="sqp_aa175b0b08e2d771e72b3add648abd898c9781e6"
dotnet build
dotnet sonarscanner end /d:sonar.login="sqp_aa175b0b08e2d771e72b3add648abd898c9781e6"

# Create pipeline > copy jenkins file
