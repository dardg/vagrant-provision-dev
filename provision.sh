#!/bin/bash
#==============================================================================

source /vagrant/modules/utils.sh
source /vagrant/modules/system.sh

# -----------------------------------------------------------------------------
# Install a modul
# $1 the module name
# -----------------------------------------------------------------------------
provision_install() {
	module=$1
	source /vagrant/modules/$module.sh
	log_white "Running provision script - Installing $module..."
	if ( ! is_function ${module}_install ); then
		log_error "$module: missing function ${module}_install" 
		exit 1
	else 
		if ( provision_is_installed $module ); then
			log_info "$module is already installed"
		else
			eval ${module}_install
			if ( provision_is_installed $module ); then
				log_info "$module successfully installed"
			else 
				log_error "failed to install $module" >&2
			fi
		fi
	fi
}

# -----------------------------------------------------------------------------
# Uninstall a module
# $1 the module name
# -----------------------------------------------------------------------------
provision_uninstall() {
	module=$1
	source /vagrant/modules/$module.sh
	log_white "Running provision script - Uninstalling $module..."
	if ( ! is_function ${module}_uninstall ); then
		log_error "$module: missing function ${module}_uninstall"
		exit 1
	else 
		if ( provision_is_installed $module ); then
			eval ${module}_uninstall
			if ( provision_is_installed $module ); then
				log_error "failed to uninstall $module"
			else 
				log_info "$module successfully uninstalled"
			fi
		else
			log_info "$module not installed"
		fi
	fi
}

# -----------------------------------------------------------------------------
# Reinstall a module
# $1 the module name
# -----------------------------------------------------------------------------
provision_reinstall() {
	provision_uninstall $1
	provision_install $1
}

# -----------------------------------------------------------------------------
# Check if a module already installed
# $1 the module name
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
provision_is_installed() {
	module=$1
	source /vagrant/modules/$module.sh
	if ( ! is_function ${module}_is_installed ); then
		log_error "$module: missing function ${module}_is_installed"
		exit 0
	else 
		eval ${module}_is_installed
		return $?
	fi
}

provision_usage() {
	log_info "Usage: provision install <module> | provision uninstall <module> | provision reinstall <module>"
}

provision() {
	action=$1
	module=$2

	if [ ! -f /vagrant/modules/$module.sh ]; then
		log_error "Unable to find module $module" >&2
	else
		if ( ! is_function provision_${action} ); then
			provision_usage
		else 
			eval provision_${action} $module
		fi
	fi
}

provision install system

provision install docker
provision install docker-mysql
provision install java8
provision install maven3
provision install eclipse
provision install nvm
provision install node
provision install yeoman
provision install rvm
provision install ruby
provision install chrome
provision install sublimetext3
provision install sts