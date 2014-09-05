#!/bin/bash
set -e
source /scripts/buildconfig
set -x

# Setting persistent configuration for Ericsson Proxy & Source List   
cp /scripts/99ericsson_proxy /etc/apt/apt.conf.d/99ericsson_proxy
cp /scripts/ericsson_uk_apt_mirror /etc/apt/sources.list

#Configuring the system with the basic packages
apt-get update
apt-get upgrade -y
$minimal_apt_get_install python-yaml python-jinja2 git openssh-server wget python-software-properties bzip2 make openjdk-7-jre-headless ruby1.9.3 ruby1.9.1-dev build-essential

#Update the Message of the day
cat /scripts/motd > /etc/motd

chmod 755 /scripts/startup
ln -s /scripts/startup /usr/bin/startup


# This is a hack to ensure that we have SVN 1.7 on an Ubuntu 14.04 build.
# Taken from here: http://www.sysads.co.uk/2014/05/install-configure-svn-1-7-ubuntu-14-04/
cp /etc/apt/sources.list /etc/apt/sources.list.orig

add-apt-repository "deb http://extras.ubuntu.com/ubuntu saucy main"
add-apt-repository "deb http://de.archive.ubuntu.com/ubuntu/ saucy main universe restricted multiverse"
apt-get remove subversion libsvn1
apt-get update
$minimal_apt_get_install subversion=1.7.9-1+nmu6ubuntu3 libsvn1=1.7.9-1+nmu6ubuntu3
echo subversion hold | sudo dpkg --set-selections
echo libsvn1 hold | sudo dpkg --set-selections
echo libserf1 hold | sudo dpkg --set-selections
mv /etc/apt/sources.list.orig /etc/apt/sources.list
apt-get update

# Now install ansible
add-apt-repository ppa:rquillo/ansible
apt-get update
$minimal_apt_get_install ansible