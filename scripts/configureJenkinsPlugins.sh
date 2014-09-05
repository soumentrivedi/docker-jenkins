#!/bin/bash
set -e
source /scripts/buildconfig
set -x

# Setting persistent configuration for Ericsson Proxy & Source List   
cp /scripts/99ericsson_proxy /etc/apt/apt.conf.d/99ericsson_proxy
cp /scripts/ericsson_uk_apt_mirror /etc/apt/sources.list

#Clone the Jenkins API git repository for downloading the plugins
cd /root
git clone ssh://esoutri@gerritforge.lmera.ericsson.se:29418/jenkins_api_samples
cd jenkins_api_samples

# Importing Plugins for Jenkins from Production Jenkins
gem install bundler
bundle install
gem install jenkins_api_client

#Creating a temporary directory for jenkins plugins
mkdir -p /tmp/jenkins_plugins

# Downloading plugins for Jenkins
ruby jenkins_plugin_download.rb --server-url $PRODUCTION_JENKINS_INSTANCE --plugin-download-directory /tmp/jenkins_plugins