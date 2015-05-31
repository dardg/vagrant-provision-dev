#!/bin/bash set -x
#==============================================================================
source /vagrant/modules/provisioning.sh

prepare
check_connected_with_internet

provision install system_always

