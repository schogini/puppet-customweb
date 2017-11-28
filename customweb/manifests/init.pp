# Class: customweb
# ===========================
#
# This is a web application with custom theme deployed using Puppet module and templates
#
# Authors
# -------
#
# Gayatri S Ajith <gayatri@schogini.com>
#
# Copyright
# ---------
#
# Copyright 2017 Gayatri S Ajith
#
class customweb {
  $who = 'Gayatri'
  $pagetitle = 'Puppet Custom Web'
  $desc = 'This is a description via a custom Puppet module'
  $pagetime = generate('/bin/date', '+%Y-%d-%m %H:%M:%S')
  exec { 'apt-update':
    command => '/usr/bin/apt-get update'
  }
  package { 'apache2':
    require => Exec['apt-update'],
    ensure => installed
  }
  service { 'apache2':
    ensure => running
  }
  package { 'php5':
    require => Exec['apt-update'],
    ensure => installed
  }
  package { 'libapache2-mod-php5':
    require => Exec['apt-update'],
    ensure => installed
  }
  file { '/etc/apache2/mods-available/php5.conf':
    content => '<IfModule mod_php5.c>
<FilesMatch "\.php$">
  SetHandler application/x-httpd-php
</FilesMatch>
</IfModule>',
    require => Package['apache2'],
    notify => Service['apache2']
  }
  file { '/var/www/html/':
    ensure => directory,
    source => 'puppet:///modules/customweb/customweb',
    recurse => 'remote',
  }
  file { '/var/www/html/index.html':
    ensure => file,
    content => template('customweb/customweb.erb'),
    require => Package['apache2']
  }
  file { '/var/www/html/i.php':
    ensure => file,
    content => "<?php echo 7+3; ?>\n",
    require => Package['apache2']
  }
}
