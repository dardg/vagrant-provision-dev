#!/bin/bash

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function yeoman_is_installed {
	return $(npm --silent list -g --depth=0 yo@ | grep -c empty)
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function yeoman_uninstall {
	if ( node_is_installed ); then
		npm uninstall -g yo bower grunt-cli gulp 
	else
		log_error "npm is required"
	fi
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function yeoman_install {
	if ( node_is_installed ); then
		npm install -g yo bower grunt-cli gulp 
	else
		log_error "npm is required"
	fi
}