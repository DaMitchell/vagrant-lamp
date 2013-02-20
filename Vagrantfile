# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

    config.vm.define :lamp do |lamp_config|
	
        lamp_config.vm.box = "precise64"
		lamp_config.vm.box_url = "http://files.vagrantup.com/precise64.box"
		
        lamp_config.ssh.max_tries = 10
		
        lamp_config.vm.forward_port 22, 2222
        lamp_config.vm.forward_port 80, 8080
        lamp_config.vm.forward_port 3306, 8989
		
        lamp_config.vm.host_name = "lamp"

        lamp_config.vm.provision :puppet do |puppet|
			puppet.facter = { 
				"fqdn" => "test.lamp", 
				"hostname" => "www", 
				"docroot" => '/vagrant/public/'
			}
            puppet.manifests_path = "puppet/manifests"
            puppet.manifest_file  = "lamp.pp"
            puppet.module_path = "puppet/modules"
            #puppet.options = "--verbose --debug"
            #puppet.options = "--verbose"
        end
    end
end
