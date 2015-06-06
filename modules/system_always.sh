#!/bin/bash +x

LOCALTIME="/usr/share/zoneinfo/Europe/Brussels"
KEYBOARD="fr+mac"

# -----------------------------------------------------------------------------
# Clean up packages
# -----------------------------------------------------------------------------
system_cleanup() {
  log_info "Cleaning up"
 
  sudo apt-get -f install >${LOG_DIR}/apt_get_install 2>&1
  sudo apt-get -y autoremove >${LOG_DIR}/apt_get_autoremove 2>&1
  sudo apt-get -y autoclean >${LOG_DIR}/apt_get_autoclean 2>&1
  sudo apt-get -y clean >${LOG_DIR}/apt_get_clean 2>&1  

}

# -----------------------------------------------------------------------------
# Set the local time
# $1 the local time
# -----------------------------------------------------------------------------
system_localtime() {
  log_info "Setting localtime: $1"
  sudo mv /etc/localtime /etc/localtime.bak
  sudo ln -s $1 /etc/localtime
}

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
system_always_is_installed() {
	return 1
        #return $(ls /etc/localtime.bak 2>/dev/null | wc -l | grep -c 0)
}

# -----------------------------------------------------------------------------
# Uninstall
# -----------------------------------------------------------------------------
system_always_uninstall() {
	echo ""
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
system_always_install() {
	# System clean up
	system_cleanup

	# Update system
	apt_update

	# Upgrade system
	apt_upgrade_always
		
	# System clean up
	system_cleanup

}
