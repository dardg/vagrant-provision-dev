#!/bin/bash 
NOW="`date +"%Y%m%d_%H%M%S"`"
LOG_DIR="/home/vagrant/provision-${NOW}"
# -----------------------------------------------------------------------------
# Prepares the provisioning
# -----------------------------------------------------------------------------
prepare_log_dir() {
	log_info "creating directory ${LOG_DIR}"	
	return $(mkdir ${LOG_DIR})
}

# -----------------------------------------------------------------------------
# Checks if $1 is a function
# -----------------------------------------------------------------------------
is_function() {
    declare -F $1 &> /dev/null
    return $?
}

# -----------------------------------------------------------------------------
# Check network connection
# -----------------------------------------------------------------------------
check_internet_connection() {

	local INTERNET_DNS=http://www.google.com
	wget -q --tries=5 --timeout=20 --spider ${INTERNET_DNS}
	if [[ $? -eq 0 ]]; then
        	return 0
	else
        	return 1
	fi
}

# -----------------------------------------------------------------------------
# Black       0;30     Dark Gray     1;30
# Blue        0;34     Light Blue    1;34
# Green       0;32     Light Green   1;32
# Cyan        0;36     Light Cyan    1;36
# Red         0;31     Light Red     1;31
# Purple      0;35     Light Purple  1;35
# Brown       0;33     Yellow        1;33
# Light Gray  0;37     White         1;37
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Log a message with a specific color:
# Black       0;30     Dark Gray     1;30
# Blue        0;34     Light Blue    1;34
# Green       0;32     Light Green   1;32
# Cyan        0;36     Light Cyan    1;36
# Red         0;31     Light Red     1;31
# Purple      0;35     Light Purple  1;35
# Brown       0;33     Yellow        1;33
# Light Gray  0;37     White         1;37
#
# $1 color
# $2 message
# -----------------------------------------------------------------------------
function log_color {
	color=$1
	message=$2

	case "$1" in
        "black")
            color="0;30"
            ;;         
        "blue")
            color="0;34"
            ;;
        "green")
            color="0;32"
            ;;
        "cyan")
            color="0;36"
            ;;
        "red")
            color="0;31"
            ;;
        "purple")
            color="0;35"
            ;;
        "brown")
            color="0;33"
            ;;
        "lightgray")
            color="0;37"
            ;;
        "darkgray")
            color="1;30"
            ;;
        "lightblue")
            color="1;34"
            ;;
        "lightgreen")
            color="1;32"
            ;;
        "lightcyan")
            color="1;36"
            ;;
        "lightred")
            color="1;31"
            ;;
        "lightpurple")
            color="1;35"
            ;;
        "yellow")
            color="1;33"
            ;;
        "white")
            color="1;37"
            ;;
        *)
            color=$1
	esac

	echo -e "\e[${color}m${message}"
}

function log_black { 
	log_color "black" "$1" 
}
function log_blue { 
	log_color "blue" "$1" 
}
function log_green { 
	log_color "green" "$1" 
}
function log_cyan { 
	log_color "cyan" "$1" 
}
function log_red { 
	log_color "red" "$1" 
}
function log_purple { 
	log_color "purple" "$1" 
}
function log_brown { 
	log_color "brown" "$1" 
}
function log_lightgray { 
	log_color "lightgray" "$1" 
}
function log_darkgray { 
	log_color "darkgray" "$1" 
}
function log_lightblue { 
	log_color "lightblue" "$1" 
}
function log_lightgreen { 
	log_color "lightgreen" "$1" 
}
function log_lightcyan { 
	log_color "lightcyan" "$1" 
}
function log_lightred { 
	log_color "lightred" "$1" 
}
function log_lightpurple { 
	log_color "lightpurple" "$1" 
}
function log_yellow { 
	log_color "yellow" "$1" 
}
function log_white { 
	log_color "white" "$1" 
}

# -----------------------------------------------------------------------------
# Display an info message
# -----------------------------------------------------------------------------
function log_info {
	log_color "lightgreen" "INFO - $1"
}

# -----------------------------------------------------------------------------
# Display an error message
# -----------------------------------------------------------------------------
function log_error {
	log_color "lightred" "ERROR - $1"
}

# -----------------------------------------------------------------------------
# Display an error message
# -----------------------------------------------------------------------------
function log_warning {
    log_color "yellow" "WARN - $1"
}

# -----------------------------------------------------------------------------
# Purge the given packages from the system
# $@ the packages to be purged
# -----------------------------------------------------------------------------
function apt_purge {
	for pack in $@;
	do 
		log_info "Removing package ${pack}"
		echo "apt_purge start - ${pack} - `date`"  >>${LOG_DIR}/apt_purge.log 2>&1;
		sudo apt-get purge --auto-remove -y -q ${pack}  >>${LOG_DIR}/apt_purge.log 2>&1;
	done
}

# -----------------------------------------------------------------------------
# Update the system
# -----------------------------------------------------------------------------
function apt_update {
  log_info "Updating OS"
  sudo apt-key update -y >${LOG_DIR}/apt_update_key.log 2>&1
  sudo apt-get update -y >${LOG_DIR}/apt_update.log 2>&1
  sudo apt-get update -y --fix-missing >${LOG_DIR}/apt_update_missing.log 2>&1
}
 
# -----------------------------------------------------------------------------
# Upgrade the system
# -----------------------------------------------------------------------------
function apt_upgrade {
  log_info "Upgrading OS"
  sudo apt-get upgrade -y -q >${LOG_DIR}/apt_upgrade.log 2>&1
  #sudo apt-get dist-upgrade -y -q >${LOG_DIR}/apt_upgrade_dist.log 2>&1
  sudo apt-get install -y -q unattended-upgrades >${LOG_DIR}/apt_upgrade_unattended.log 2>&1
  sudo apt-get install -y -q debian-goodies >${LOG_DIR}/apt_install_debian-goodies.log 2>&1
  log-info "Updating Vmware Tools"
  fix_vmware_tools_script
}

# -----------------------------------------------------------------------------
# Install the given packages to the system
# $@ the packages to be installed
# -----------------------------------------------------------------------------
function apt_install {
	for pack in $@;
	do 
		log_info "Installing package ${pack}"
    	echo "apt_install start - ${pack} - `date`" >>${LOG_DIR}/apt_install_${pack}.log 2>&1
    	sudo apt-get install -y -q ${pack} >>${LOG_DIR}/apt_install_${pack}.log 2>&1
	done
}

# -----------------------------------------------------------------------------
# Install the given packages to the system
# $@ the packages to be installed
# -----------------------------------------------------------------------------
function apt_install_full {
	for pack in $@;
	do 
		log_info "Installing full package ${pack} with suggestions & recommendations"
    	echo "apt_install-full start - ${pack} - `date`" >>${LOG_DIR}/apt_install_${pack}.log 2>&1
    	sudo apt-get install --install-suggests -y -q ${pack} >>${LOG_DIR}/apt_install_${pack}.log 2>&1
	done
}

# -----------------------------------------------------------------------------
# Force Install the given packages to the system
# $@ the packages to be installed
# -----------------------------------------------------------------------------
function apt_force_install {
	for pack in $@;
	do 
		log_info "Force Installing package ${pack}"
    	echo "apt_force_install start - ${pack} - `date`" >>${LOG_DIR}/apt_install_${pack}.log 2>&1
    	sudo apt-get install -y --force-yes -q ${pack} >>${LOG_DIR}/apt_install_${pack}.log 2>&1
	done
}

# -----------------------------------------------------------------------------
# Install from package file the given packages to the system
# $@ the packagefile containing the packages to be installed
# -----------------------------------------------------------------------------
function apt_install_from_packagefile {
	for packagefile in $@;
	do 
		log_info "Installing package from packagefile ${packagefile}"
    		echo "apt_install_from_packagefile start - ${packagefile} - `date`" >>${LOG_DIR}/apt_install_${packagefile}.log 2>&1
         	cat ${packagefile}| xargs sudo apt-get install -y >>${LOG_DIR}/apt_install_${packagefile}.log 2>&1
	done
}



# -----------------------------------------------------------------------------
# Add the given repository
# $1 the repository (e.g. timothy-downey/maven3)
# -----------------------------------------------------------------------------
function apt_repository_add {
	
	if ( ! apt_repository_is_added $1 ); then
		log_info "Adding repository $1"
		sudo add-apt-repository -y ppa:$1 >${LOG_DIR}/apt_repository_add.log 2>&1
		apt_update
	fi	
}

# -----------------------------------------------------------------------------
# Remove the given repository
# $1 the repository (e.g. timothy-downey/maven3)
# -----------------------------------------------------------------------------
function apt_repository_remove {
	
	if ( apt_repository_is_added $1 ); then
		log_info "Removing repository $1"
		sudo add-apt-repository --remove -y ppa:$1 >${LOG_DIR}/apt_repository_remove.log 2>&1
		apt_update
	fi	
}


# -----------------------------------------------------------------------------
# Check if a package is installed. 
# Return 0 if installed, 1 otherwise
# $1 package name
# -----------------------------------------------------------------------------
function apt_is_installed {
	echo "apt_is_installed start - ${pack} - `date`" >>${LOG_DIR}/apt_is_installed_error.log
	return $(dpkg-query -W -f='${Status}' $1 2>>${LOG_DIR}/apt_is_installed_error.log | grep -c "ok installed" | grep -c 0)
}

# -----------------------------------------------------------------------------
# Check if a repository is installed. 
# Return 0 if added, 1 otherwise
# $1 ppa name
# -----------------------------------------------------------------------------
function apt_repository_is_added {
	return $(grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep -v list.save | grep -v deb-src | grep deb | grep $1 | wc -l | grep -c 0)	
}
