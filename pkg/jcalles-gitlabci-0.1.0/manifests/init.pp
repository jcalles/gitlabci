# == Class: gitlabci
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class gitlabci {
gitlabci::config {'config':
concurrent => '2',
username => 'gitlab-runner',
}
	
}
