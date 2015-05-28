#!/bin/bash 

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function chromium_is_installed {
	apt_is_installed chromium-browser
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function chromium_uninstall {
	apt_purge chromium-browser
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function chromium_install {
	apt_force_install chromium-browser
}

