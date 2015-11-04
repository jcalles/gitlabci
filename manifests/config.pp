# == Class: gitlabci
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
define gitlabci::config($concurrent,
			$username) 
{
#######################################
class { 'sudo':
  manage_sudoersd => false,
}
->
sudo::conf { "${username}":
  content => "${username} ALL=(ALL) NOPASSWD: ALL",
}
sudo::conf { 'vagrant':
  content => 'vagrant ALL=(ALL) NOPASSWD: ALL',
}

###########################################

#class { 'sudo':
#	manage_sudoersd => false,
#	keep_os_defaults => false,
#	defaults_hash    => {
#	requiretty     => false,
#	visiblepw      => true,
#	env_reset	   => true,
#	mail_badpass   => true,
#			},
# 	 confs_hash       => {
#   	"${username}" => {
#      	ensure       => present,
#      	content      => 'gitlab-runner ALL=(ALL) NOPASSWD: ALL',
#    			},
#  	 'sudors' => {
#     	 ensure       => present,
#      	content      => '%sudo ALL=(ALL)  ALL',
#    			},
#},
#}

if defined(User["${username}"])
{
alert("user exist")
}
        else {

        user { "${username}":
                home       => "/home/${username}",
                comment    => 'GitLab Runner',
                managehome => true,
                ensure     => "present",
                shell      => '/bin/bash',
}
        group { "${username}":
                 ensure => 'present',
}
}

if defined(Packege["wget"])
{
alert("package wget instalado")
}
else {
	package {'wget':
	ensure => installed,

}
}
		exec {'download-rummer':
		path => '/usr/bin:/bin:/us/local/bin:/sbin:/usr/sbin', 
		command => $::architecture ? {
		'amd64' => "wget -O /usr/local/bin/gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64 && chmod +x /usr/local/bin/gitlab-ci-multi-runner",
		'386' => "wget -O /usr/local/bin/gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-386 && chmod +x /usr/local/bin/gitlab-ci-multi-runner",
		'arm' => "wget -O /usr/local/bin/gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64 && chmod +x /usr/local/bin/gitlab-ci-multi-runner",
		},
		onlyif  => "test ! -f /usr/local/bin/gitlab-ci-multi-runner",
		timeout => 0,
		require => Package["wget"],
}	
		file {'working':
		ensure => 'directory',
		path => '/gitlab-runner',
		owner => "${username}",
		group => "${username}",
		mode => '0755',
}

		exec {'installservice':
		path => '/usr/bin:/bin:/us/local/bin:/sbin:/usr/sbin', 
		command => "/usr/local/bin/gitlab-ci-multi-runner install --user=${username} --working-directory=/gitlab-runner",
		unless => "test -f /etc/init/gitlab-runner.conf",
		require => Exec["download-rummer"],
}

		file {'config':
		path => '/etc/gitlab-runner/config.toml',
		content => template('gitlabci/config.toml.erb'),
		mode => '0600',
		owner => 'root',
		group => 'root',
		require => Exec["installservice"],

}
}## end class
