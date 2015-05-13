#!/bin/bash


# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function java8_is_installed {
	return $(ls -l /etc/alternatives/java 2>/dev/null | grep -c java-8-oracle | grep -c 0)
}

# -----------------------------------------------------------------------------
# Uninstall
# -----------------------------------------------------------------------------
function java8_uninstall {
	apt_repository_remove webupd8team/java
	apt_purge oracle-java8-installer
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function java8_install {
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

	apt_repository_add webupd8team/java
	apt_install oracle-java8-installer
}