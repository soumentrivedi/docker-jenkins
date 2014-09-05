#!/bin/bash
set -e
source /scripts/buildconfig
set -x

# Setting persistent configuration for Ericsson Proxy & Source List   
cp /scripts/99ericsson_proxy /etc/apt/apt.conf.d/99ericsson_proxy
cp /scripts/ericsson_uk_apt_mirror /etc/apt/sources.list

#Setting up LTS Jenkins
wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list

apt-get update
$minimal_apt_get_install jenkins
apt-get clean

#Creating Jenkins Home directory
mkdir -p /jenkins
chown jenkins:jenkins /jenkins

#Changing the Jenkins Home directory
sed -i "s/\/var\/lib\/jenkins/\/jenkins/g" /etc/default/jenkins