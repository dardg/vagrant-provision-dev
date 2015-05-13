#!/bin/bash

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function docker_is_installed {
	return $(which docker | wc -l | grep -c 0)
}

# -----------------------------------------------------------------------------
# Uninstall
# -----------------------------------------------------------------------------
function docker_uninstall {
	apt_purge lxc-docker
	sudo rm -Rf /var/lib/docker
	sudo deluser vagrant docker
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function docker_install {
	wget -qO- https://get.docker.com/ | sh
	sudo usermod -aG docker vagrant
}

