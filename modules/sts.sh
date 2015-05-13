#!/bin/bash

STS_URL=http://dist.springsource.com/release/STS/3.6.4.RELEASE/dist/e4.4/spring-tool-suite-3.6.4.RELEASE-e4.4.2-linux-gtk-x86_64.tar.gz

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
sts_is_installed() {
	return $(ls /opt/sts-bundle 2>/dev/null | wc -l | grep -c 0)
}

# -----------------------------------------------------------------------------
# Uninstall
# -----------------------------------------------------------------------------
sts_uninstall() {
	sudo rm -Rf /opt/sts-bundle
	sudo rm /usr/share/applications/sts.desktop
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
sts_install() {
	wget $STS_URL -O /tmp/sts.tar.gz -q
	sudo tar -xf /tmp/sts.tar.gz -C /opt
	rm /tmp/sts.tar.gz

	cat <<EOF | sudo tee /usr/share/applications/sts.desktop
	[Desktop Entry]
	Name=STS
	Type=Application
	Exec=env UBUNTU_MENUPROXY= /opt/sts-bundle/sts-3.6.4.RELEASE/STS
	Terminal=false
	Icon=/opt/sts-bundle/sts-3.6.4.RELEASE/icon.xpm
	Comment=Integrated Development Environment
	NoDisplay=false
	Categories=Development;IDE;
	Name[en]=STS IDE
EOF

}