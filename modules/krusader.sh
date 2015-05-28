#!/bin/bash 

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function krusader_is_installed {
	apt_is_installed krusader
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function krusader_uninstall {
	apt_purge krusader
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function krusader_install {
	apt_install_from_packagefile krusader-package-list

}

