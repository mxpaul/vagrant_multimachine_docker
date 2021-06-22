# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vagrant.plugins = ["vagrant-hostmanager"]
	config.hostmanager.enabled = true
	config.hostmanager.manage_guest = true
	config.hostmanager.manage_host = false
	config.hostmanager.include_offline = true
	config.hostmanager.ignore_private_ip = false

	config.vm.define "app" do |app|
		app.vm.box = "ubuntu/trusty64"
		app.vm.hostname = "app"
		app.vm.network "forwarded_port", guest: 7654, host: 7654
		app.vm.network :private_network, ip: "172.30.30.30", bridge: "br-multivagrant"


		app.vm.synced_folder "code/", "/home/vagrant/code", disabled: false,
			create: true,
			id: "code"

		app.vm.provider :virtualbox do |vb|
			vb.customize ["modifyvm", :id, "--memory", "512"]
			vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
			vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
		end
	end

	config.vm.define "pgdb" do |pgdb|
		pgdb.vm.hostname = "pgdb"
		pgdb.vm.network :private_network, ip: "172.40.40.40", bridge: "br-multivagrant"
		pgdb.hostmanager.aliases = %w(pgserver pg_db pgdb pg)
    pgdb.hostmanager.manage_guest = false
		pgdb.vm.provider "docker" do |d|
			d.image = "postgres:13.2"
			d.env = {
				"POSTGRES_DB"       => "db",
				"POSTGRES_USER"     => "postgres",
				"POSTGRES_PASSWORD" => "postgres",
			}
		end 
	end

	###########################################################
	## Ability to run locally slightly different steps
	###########################################################
	env_name = ENV["ENV_VAGRANT"]
	ansible_group_vars = {}
	if env_name.respond_to?(:to_str) && env_name.eql?("mxp")
		ansible_group_vars['use_google_dns'] = true
	end
	###########################################################

	config.vm.provision "ansible" do |ansible|
		ansible.verbose = "v"
		ansible.playbook = "ansible/site.yml"
		ansible.groups = {
			"allinone" => [ "app" ],
			"allinone:vars" => ansible_group_vars,
		}
	end

end

