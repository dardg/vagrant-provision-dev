#!/bin/bash

RVM_DIR=$HOME/.rvm
RVM_VERSION=stable

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function rvm_is_installed {
	return $(which rvm | wc -l | grep -c 0)
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function rvm_uninstall {
	echo yes | rvm implode
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function rvm_install {
	apt_install \
		libgdbm-dev \
		libncurses5-dev \
		automake \
		libtool \
		bison \
		libffi-dev
	
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	curl -sSL https://get.rvm.io | bash -s $RVM_VERSION 

	source $RVM_DIR/scripts/rvm
}