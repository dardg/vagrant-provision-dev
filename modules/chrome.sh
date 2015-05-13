#!/bin/bash

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function chrome_is_installed {
	apt_is_installed google-chrome-stable 
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function chrome_uninstall {
	apt_purge google-chrome-stable
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function chrome_install {
	local DEB="deb http://dl.google.com/linux/chrome/deb/ stable main"

	if [[ ! -f /etc/apt/sources.list.d/google-chrome.list ]]; then
		wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
		echo $DEB | sudo tee --append /etc/apt/sources.list.d/google-chrome.list 
		apt_update
	fi

	apt_install google-chrome-stable
}