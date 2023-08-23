#!/bin/bash

# Update the system
sudo yum update -y

# Install Java (required for Jenkins and Maven)
sudo yum install java-1.8.0-openjdk-devel -y
java --version

# Install Jenkins
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins -y


# Check if Jenkins user exists
if id "jenkins" &>/dev/null; then
    # Add Jenkins to sudoers file
    echo "jenkins ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
    echo "Jenkins added to sudoers file."
else
    echo "Jenkins user not found."
fi

# Start and enable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Install Maven
sudo yum install maven -y

## Configure MAVEN_HOME and PATH Environment Variables
rm -f .bash_profile
wget https://raw.githubusercontent.com/TheModeler99/RealWorld-cicd-pipeline-project/jenkins-master-client-config/.bash_profile
source .bash_profile
mvn -v

# Create ".m2" and download your "settings.xml" file into it to Authorize Maven
## Make sure to Update the RAW GITHUB Link to your "settings.xml" config
mkdir /var/lib/jenkins/.m2
wget https://raw.githubusercontent.com/TheModeler99/jenkins_development-CI_pipeline_project/master/settings.xml -P /var/lib/jenkins/.m2/
chown -R jenkins:jenkins /var/lib/jenkins/.m2/
chown -R jenkins:jenkins /var/lib/jenkins/.m2/settings.xml

# Installing Git
yum install git -y

# IMPORTANT:::::Make sure to set Java and Javac to Version 8 using the following commands
##### Check Maven and Java Version and Confirm it's JAVA 8
#    mvn -v
#    java -version

##### Enter the following to set Java 8 as the default runtime on your EC2 instance.
#    sudo /usr/sbin/alternatives --config java

##### Enter the following to set Java 8 as the default compiler on your EC2 instance.
#    sudo /usr/sbin/alternatives --config javac

# Print instructions
echo "Jenkins, Maven, Git installation completed."
echo "Jenkins is running on http://<your_server_ip>:8080"

