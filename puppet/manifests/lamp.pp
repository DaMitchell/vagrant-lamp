
Exec 
{
	path => [
		"/usr/bin", 
		"/bin", 
		"/usr/sbin", 
		"/sbin", 
		"/usr/local/bin", 
		"/usr/local/sbin"
	]
}

exec {"apt-get update":
	command => "/usr/bin/apt-get update"
}

#Install apache
class {"apache": }

#Install the php apache mod
class {"apache::mod::php": }

file{"/etc/apache2/sites-enabled/default":
	ensure  => present,
    source  => "/vagrant/puppet/templates/vhost",
    require => Package["apache2"],
	notify  => Service["apache2"]
}

#Include php
include php

