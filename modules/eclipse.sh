#!/bin/bash

ECLIPSE_URL=http://eclipse.cu.be/eclipse/downloads/drops4/R-4.4.2-201502041700/eclipse-SDK-4.4.2-linux-gtk-x86_64.tar.gz

# eclipse
ECLIPSE_REPOS=http://download.eclipse.org/releases/luna,http://download.eclipse.org/eclipse/updates/4.4
ECLIPSE_REPOS=$ECLIPSE_REPOS,http://www.eclipse.org/modeling/emf/updates/,http://download.eclipse.org/modeling/emf/updates/releases/
ECLIPSE_REPOS=$ECLIPSE_REPOS,http://download.eclipse.org/birt/update-site/2.6
ECLIPSE_REPOS=$ECLIPSE_REPOS,http://download.eclipse.org/webtools/repository/luna
ECLIPSE_REPOS=$ECLIPSE_REPOS,http://download.eclipse.org/tools/gef/updates/releases/
ECLIPSE_REPOS=$ECLIPSE_REPOS,http://download.eclipse.org/technology/dltk/updates
ECLIPSE_REPOS=$ECLIPSE_REPOS,http://download.eclipse.org/tools/cdt/releases/luna

# m2eclipse
ECLIPSE_REPOS=$ECLIPSE_REPOS,http://download.eclipse.org/technology/m2e/releases
ECLIPSE_FEATURES=org.eclipse.m2e.feature.feature.group,org.eclipse.m2e.logback.feature.feature.group

# egit
ECLIPSE_REPOS=$ECLIPSE_REPOS,http://download.eclipse.org/egit/updates
ECLIPSE_FEATURES=$ECLIPSE_FEATURES,org.eclipse.egit.feature.group,org.eclipse.jgit.feature.group

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function eclipse_is_installed {
	return $(ls /opt/eclipse/ 2>//dev/null | grep -c eclipse | grep -c 0)
}

# -----------------------------------------------------------------------------
# Uninstall
# -----------------------------------------------------------------------------
function eclipse_uninstall {
	sudo rm -Rf /opt/eclipse
	sudo rm /usr/share/applications/eclipse.desktop
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function eclipse_install {
	wget $ECLIPSE_URL -O /tmp/eclipse.tar.gz -q
	sudo tar -xf /tmp/eclipse.tar.gz -C /opt
	rm /tmp/eclipse.tar.gz

	cat <<EOF | sudo tee /usr/share/applications/eclipse.desktop
	[Desktop Entry]
	Name=Eclipse
	Type=Application
	Exec=env UBUNTU_MENUPROXY= /opt/eclipse/eclipse
	Terminal=false
	Icon=/opt/eclipse/icon.xpm
	Comment=Integrated Development Environment
	NoDisplay=false
	Categories=Development;IDE;
	Name[en]=Eclipse IDE
EOF

	log_info "Installing Eclipse features..."

  	/opt/eclipse/eclipse \
	   -nosplash \
	   -application org.eclipse.equinox.p2.director \
	   -repository $ECLIPSE_REPOS \
	   -installIU $ECLIPSE_FEATURES \
	   -p2.os linux -p2.ws gtk -p2.arch x86_64

}