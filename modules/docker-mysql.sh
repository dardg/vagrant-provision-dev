#!/bin/bash
# https://github.com/docker-library/docs/tree/master/mysql

HOSTPORT=3306
CONTAINERPORT=3306
CONTAINERNAME=mysql
CONTAINERIMAGE=mysql:5.7
MYSQL_ROOT_PASSWORD=root

# -----------------------------------------------------------------------------
# Check if already installed
# Return 0 if installed, 1 otherwise
# -----------------------------------------------------------------------------
function docker-mysql_is_installed {
	return $(which docker-mysql-start | wc -l | grep -c 0)
}

# -----------------------------------------------------------------------------
# Uninstall
# -----------------------------------------------------------------------------
function docker-mysql_uninstall {
	(docker ps -a | grep $CONTAINERIMAGE | grep -c $CONTAINERNAME) >/dev/null && (docker stop $CONTAINERNAME) && (docker rm $CONTAINERNAME) && (docker rmi $CONTAINERIMAGE)
	sudo rm -f /usr/bin/docker-mysql*
}

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
function docker-mysql_install {
	if ( provision_is_installed docker ); then
		echo "docker run --name $CONTAINERNAME -p 127.0.0.1:$HOSTPORT:$CONTAINERPORT -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -d $CONTAINERIMAGE" | sudo tee /usr/bin/docker-mysql-run >/dev/null
		sudo chmod +x  /usr/bin/docker-mysql-run

		echo "docker stop $CONTAINERNAME" | sudo tee /usr/bin/docker-mysql-start >/dev/null
		sudo chmod +x  /usr/bin/docker-mysql-start

		echo "docker stop $CONTAINERNAME" | sudo tee /usr/bin/docker-mysql-stop >/dev/null
		sudo chmod +x  /usr/bin/docker-mysql-stop
		
		sudo docker-mysql-run
	else
		log_error "docker is required" >&2
	fi
}