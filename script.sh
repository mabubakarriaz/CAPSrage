https://learn.acloud.guru/cloud-playground/cloud-sandboxes
Ubuntu 20.04

firewall rule 8080
firewall rule 9000

ssh -i vm_key_14.pem azureuser@20.245.229.158

sudo su - 

sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get -y update && sudo apt-get -y upgrade

sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get -y update

sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get -y update

sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker $USER
exit

docker run hello-world:latest

docker run --privileged -d -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker --name jenkins jenkins/jenkins

sudo chmod 666 /var/run/docker.sock

docker exec -ti -u0 jenkins bash

cat /var/jenkins_home/secrets/initialAdminPassword
6490f147d73b452f9464d967c9796018

http://20.245.229.158:8080/
# Install plugins
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

sudo docker run --privileged -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube:latest

http://20.245.229.158:9000/
admin
admin
project-key: CAPSrage
sqp_81f4fba1089a0e97412bf7c499acece56decf130


dotnet tool install --global dotnet-sonarscanner
dotnet sonarscanner begin /k:"CapsRage" /d:sonar.host.url="http://20.245.229.158:9000"  /d:sonar.login="sqp_81f4fba1089a0e97412bf7c499acece56decf130"
dotnet build
dotnet sonarscanner end /d:sonar.login="sqp_81f4fba1089a0e97412bf7c499acece56decf130"

# ---------------------------------------
# extra commands

docker exec -it -u0 <container id> bash
curl https://get.docker.com > dockerinstall && chmod 777 dockerinstall && ./dockerinstall
chmod 666 /var/run/docker.sock


chmod +x /opt/sonar-scanner-msbuild/.store/dotnet-sonarscanner/5.4.1/dotnet-sonarscanner/5.4.1/tools/net5.0/any/sonar-scanner-4.6.2.2472/bin/sonar-scanner
chmod +x /var/jenkins_home/workspace/CAPSrage@2
chmod -R 777 /var/jenkins_home/workspace/


ls -lah
whoami
pwd

https://learn.microsoft.com/en-us/dotnet/core/tools/global-tools#install-a-global-tool-in-a-custom-location