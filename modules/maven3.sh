#!/bin/bash

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function maven3_is_installed {
	apt_is_installed maven3
}

# -----------------------------------------------------------------------------
# Uninstall
# -----------------------------------------------------------------------------
function maven3_uninstall {
	apt_repository_remove timothy-downey/maven3
	apt_purge maven3
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function maven3_install {
	apt_repository_add timothy-downey/maven3
	apt_install maven3
}