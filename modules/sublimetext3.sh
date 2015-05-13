#!/bin/bash

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function sublimetext3_is_installed {
	apt_is_installed sublime-text-installer
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function sublimetext3_uninstall {
	apt_repository_remove webupd8team/sublime-text-3
	apt_purge sublime-text-installer

	rm -Rf ~/.config/sublime-text-3
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function sublimetext3_install {
	apt_repository_add webupd8team/sublime-text-3
	apt_install sublime-text-installer

	log_info "Installing Package Control"
	mkdir -p ~/.config/sublime-text-3/Installed\ Packages
	PACKAGE_CONTROL_URL="https://packagecontrol.io/Package%20Control.sublime-package"
	wget $PACKAGE_CONTROL_URL -O  ~/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package -q 
}