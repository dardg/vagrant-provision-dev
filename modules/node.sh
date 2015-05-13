#!/bin/bash

NVM_DIR=$HOME/.nvm
NODE_VERSION=0.12.2

if [  -f $NVM_DIR/nvm.sh ]; then source $NVM_DIR/nvm.sh; fi
	
# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function node_is_installed {
	return $(which node | wc -l | grep -c 0)
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function node_uninstall {
	if ( nvm_is_installed ); then
		nvm unalias default
		nvm uninstall $NODE_VERSION
	else
		log_error "nvm is required"
	fi
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function node_install {
	if ( nvm_is_installed ); then
		nvm install $NODE_VERSION
		nvm alias default $NODE_VERSION
		node -v	
	else
		log_error "nvm is required"
	fi
}