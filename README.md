# vagrant-dev
Ubuntu Desktop 14.04 with preinstalled development tools

vagrant-dev
===========

Ubuntu Desktop 14.04 with preinstalled development tools

## What's inside the box?

* Ubuntu 14.04 Desktop (with french apple keyboard and timezone)
* docker
* docker container with mysql:5.7
* java8
* maven3
* eclise luna 4.4.2
* Node Version Manager 0.24.1 - Version can be configured in modules/nvm.sh
* Node 0.12.2 - Version can be configured in modules/node.sh
* Yeoman with bower, grunt-cli and gulp
* Ruby Version Manager stable - Version can be configured in modules/rvm.sh
* Ruby 2.2.1 - Version can be configured in modules/ruby.sh
* Chrome 
* Sublime Text 3 with Packet Control
* STS 3.6.4.RELEASE

## Pre requisite

Requires vagrant-reload plugin (https://github.com/aidanns/vagrant-reload)

```
vagrant plugin install vagrant-reload
```

## Installation

Just create the box

```
vagrant up
```


