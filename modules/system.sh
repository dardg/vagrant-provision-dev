#!/bin/bash

LOCALTIME="/usr/share/zoneinfo/Europe/Brussels"
KEYBOARD="fr+mac"

# -----------------------------------------------------------------------------
# Clean up packages
# -----------------------------------------------------------------------------
system_cleanup() {
  log_info "Cleaning up"
 
  sudo apt-get -f install >/dev/null 2>&1
  sudo apt-get autoremove >/dev/null 2>&1
  sudo apt-get -y autoclean >/dev/null 2>&1
  sudo apt-get -y clean >/dev/null 2>&1  

}

# -----------------------------------------------------------------------------
# Fix ubuntu 
# https://fixubuntu.com/
# $1 The keyboard
# -----------------------------------------------------------------------------
system_gnome_settings() {

  KEYBOARD=$1
  log_info "Keyboard: $KEYBOARD"

  cat <<EOF | sudo tee /home/vagrant/set-gnome-settings.sh
  #!/bin/bash

  # Fixubuntu
  wget -q -O - https://fixubuntu.com/fixubuntu.sh | bash
  
  # Disable "More Suggestions"
  gsettings set com.canonical.Unity.ApplicationsLens display-available-apps false

  # lock favorites to launcher
  gsettings set com.canonical.Unity.Launcher favorites "['application://eclipse.desktop', 'application://ubiquity.desktop', 'application://nautilus.desktop', 'application://google-chrome.desktop', 'application://gnome-terminal.desktop', 'application://ubuntu-software-center.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"

  # set keyboard to french
  gsettings set org.gnome.desktop.input-sources sources "[('xkb', '$KEYBOARD')]"

  # disable screen saver
  gsettings set org.gnome.desktop.screensaver idle-activation-enabled false

  # turn off lock screen
  gsettings set org.gnome.desktop.screensaver lock-enabled false

  # remove autostart after running this script once
  sudo rm -f /etc/xdg/autostart/set-gnome-settings.sh.desktop
  sudo rm -f /home/vagrant/set-gnome-settings.sh
EOF

  sudo chown vagrant:vagrant /home/vagrant/set-gnome-settings.sh
  sudo chmod +x /home/vagrant/set-gnome-settings.sh

  cat <<EOF | sudo tee /etc/xdg/autostart/set-gnome-settings.sh.desktop
  [Desktop Entry]
  Type=Application
  Exec=/home/vagrant/set-gnome-settings.sh
  Hidden=false
  NoDisplay=false
  X-GNOME-Autostart-enabled=true
  Name=Apply Gnome Settings
  Comment=Apply Gnome Settings at next restart
EOF

  #sudo service lightdm restart 
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
system_is_installed() {
	return $(ls /etc/localtime.bak 2>/dev/null | wc -l | grep -c 0)
}

# -----------------------------------------------------------------------------
# Uninstall
# -----------------------------------------------------------------------------
system_uninstall() {
	echo ""
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
system_install() {
	# Remove unnecessary packages
	apt_purge \
		account-plugin-aim \
		account-plugin-jabber \
		account-plugin-salut \
		account-plugin-yahoo \
		aisleriot \
		brasero \
		brasero-cdrkit \
		brasero-common \
		empathy-common \
		empathy \
		firefox \
		gir1.2-rb-3.0 \
		gnome-contacts \
		gnome-mahjongg \
		gnome-mines \
		gnome-sudoku \
		gnomine \
		libbrasero-media3-1 \
		libreoffice-* \
		librhythmbox-core8 \
		maven2 \
		mcp-account-manager-uoa \
		nautilus-sendto-empathy \
		rhythmbox \
		rhythmbox-data \
		rhythmbox-mozilla \
		rhythmbox-plugins \
		rhythmbox-plugin-cdrecorder \
		rhythmbox-plugin-magnatune \
		rhythmbox-plugin-zeitgeist \
		shotwell \
		shotwell-common \
		telepathy-idle \
		thunderbird \
		thunderbird-gnome-support \
		transmission-common \
		transmission-gtk \
		unity-webapps-common \
		webbrowser-app

	# Update system
	apt_update

	# Upgrade system
	apt_upgrade
		
	# Update local time
	system_localtime $LOCALTIME

	# Update gnome settings
	system_gnome_settings $KEYBOARD

	# System clean up
	system_cleanup
}