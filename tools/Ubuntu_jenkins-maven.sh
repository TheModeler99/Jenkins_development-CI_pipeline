#!/bin/bash
#Requirement: Ubuntu 20.04, t2.medium(AWS), Ensure user has sudo privileges

sudo apt upgrade -y

# Install Jenkins
sudo apt install openjdk-11-jdk -y

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt update
sudo apt install jenkins -y

sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo ufw allow 8080

#Access Jenkins Web Interface: http://your_server_ip_or_domain:8080
#Retrieve Jenkins Admin Password: $ sudo cat /var/lib/jenkins/secrets/initialAdminPassword

sudo apt install jenkins -y
echo "jenkins ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers


# Apache Maven Installation/Config
sudo apt install maven -y
mvn -version

## Configure MAVEN_HOME and PATH Environment Variables. Dont run as root
cp ~/.bashrc ~/bashrc-bk
echo "export MAVEN_HOME=/usr/share/maven" >> ~/.bashrc
echo "export PATH=$MAVEN_HOME/bin:$PATH" >> ~/.bashrc
source ~/.bashrc
echo $MAVEN_HOME
mvn -v

# Create ".m2" and download your "settings.xml" file into it to Authorize Maven
## Make sure to Update the RAW GITHUB Link to your "settings.xml" config
sudo mkdir /var/lib/jenkins/.m2
sudo wget https://raw.githubusercontent.com/TheModeler99/jenkins_development-CI_pipeline_project/master/settings.xml -P /var/lib/jenkins/.m2/
sudo chown -R jenkins:jenkins /var/lib/jenkins/.m2/
sudo chown -R jenkins:jenkins /var/lib/jenkins/.m2/settings.xml


# Installing Git
sudo apt install git -y