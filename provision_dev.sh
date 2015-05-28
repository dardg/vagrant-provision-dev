#!/bin/bash 
#==============================================================================

source /vagrant/modules/provisioning.sh

prepare 
check_connected_with_internet

provision install docker
#provision install docker-mysql
provision install java8
provision install maven3
provision install eclipse
#provision install nvm
#provision install node
#provision install yeoman
#provision install rvm
#provision install ruby
provision install chromium
provision install chrome
provision install sublimetext3
provision install sts

