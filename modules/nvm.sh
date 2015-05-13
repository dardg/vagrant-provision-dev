#!/bin/bash

NVM_DIR=$HOME/.nvm
NVM_VERSION=0.24.1

if [  -f $NVM_DIR/nvm.sh ]; then source $NVM_DIR/nvm.sh; fi

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function nvm_is_installed {
	if [  -f $NVM_DIR/nvm.sh ]; then
		return $(nvm --version 2>/dev/null | grep -c $NVM_VERSION | grep -c 0)
	else
		return 1
	fi
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function nvm_uninstall {
	rm -Rf $NVM_DIR
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function nvm_install {
	curl https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash
	source $NVM_DIR/nvm.sh
	nvm --version
}