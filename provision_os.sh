#!/bin/bash 
#==============================================================================
source /vagrant/modules/provisioning.sh

prepare
check_connected_with_internet

provision install system
provision install lynx
provision install krusader

