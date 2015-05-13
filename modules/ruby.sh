#!/bin/bash

RVM_DIR=$HOME/.rvm
RUBY_VERSION=2.2.1

if [  -f $RVM_DIR/scripts/rvm ]; then source $RVM_DIR/scripts/rvm; fi

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function ruby_is_installed {
	return $(which ruby | wc -l | grep -c 0)
}

# -----------------------------------------------------------------------------
# Uninstall
# -----------------------------------------------------------------------------
function ruby_uninstall {
	if ( rvm_is_installed ); then
		rvm uninstall $RUBY_VERSION
	else 
		log_error "rvm is required"
	fi
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function ruby_install {
	if ( rvm_is_installed ); then
		apt_install \
			git-core \
			curl \
			zlib1g-dev \
			build-essential \
			libssl-dev \
			libreadline-dev \
			libyaml-dev \
			libsqlite3-dev \
			sqlite3 \
			libxml2-dev \
			libxslt1-dev \
			libcurl4-openssl-dev \
			python-software-properties \
			libffi-dev
		
		rvm use --install --default --create $RUBY_VERSION
		ruby -v

		# Now we tell Rubygems not to install the documentation for each package locally
		echo "gem: --no-ri --no-rdoc" > ~/.gemrc

		gem install \
			bundler \
			compass \
			sass
	else
		log_error "rvm is required"
	fi
}