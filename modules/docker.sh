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
	sudo rm /usr/local/bin/docker-compose /etc/bash_completion.d/docker-compose
	sudo rm -Rf /var/lib/docker
	sudo deluser vagrant docker
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function docker_install {
	# Install docker
	wget -qO- https://get.docker.com/ | sh
	sudo usermod -aG docker vagrant
	# Install docker-compose
	sudo sh -c "curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
	sudo chmod +x /usr/local/bin/docker-compose
	sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/1.2.0/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"
 	# Install docker-cleanup command
	cd /tmp
	git clone https://gist.github.com/76b450a0c986e576e98b.git
	cd 76b450a0c986e576e98b
	sudo mv docker-cleanup /usr/local/bin/docker-cleanup
	sudo chmod +x /usr/local/bin/docker-cleanup
}

