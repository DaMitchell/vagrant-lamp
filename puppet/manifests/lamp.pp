# LAMP Puppet manifest

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class system-update 
{
    file { "/etc/apt/sources.list.d/dotdeb.list":
        owner  => root,
        group  => root,
        mode   => 664,
        source => "/vagrant/conf/apt/dotdeb.list",
    }

    exec { 'dotdeb-apt-key':
        cwd     => '/tmp',
        command => "wget http://www.dotdeb.org/dotdeb.gpg -O dotdeb.gpg &&
                    cat dotdeb.gpg | apt-key add -",
        unless  => 'apt-key list | grep dotdeb',
        require => File['/etc/apt/sources.list.d/dotdeb.list'],
        notify  => Exec['apt_update'],
    }

	exec { 'apt-get update':
		command => 'apt-get update',
	}

	$sysPackages = [ "build-essential" ]
  
	package { $sysPackages:
		ensure => "installed",
		require => Exec['apt-get update'],
	}			
}

class setup-apache
{
	include apache
	
	a2mod { 'rewrite': ensure => present; }
	
	apache::vhost { $fqdn :
		priority => '20',
		port => '80',
		docroot => $docroot,
		configure_firewall => false,
	}
}

class setup-php
{
	include php
}

class development 
{
	$devPackages = [ "curl", "git" ]
  
	package { $devPackages:
		ensure => "installed",
		require => Exec['apt-get update'],
	}
}

#Install apache
#class {"apache": }

#Install the php apache mod
#class {"apache::mod::php": }

#file{"/etc/apache2/sites-enabled/default":
#	ensure  => present,
#    source  => "/vagrant/puppet/templates/vhost",
#    require => Package["apache2"],
#	notify  => Service["apache2"]
#}

class { 'apt':
  always_apt_update    => true
}

Exec["apt-get update"] -> Package <| |>

include system-update
include development

include setup-apache
