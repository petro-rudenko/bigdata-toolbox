# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.require_version ">= 1.6.2"
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "chef/ubuntu-14.04"
  config.vm.post_up_message = "Congratulation! 3 nodes docker cluster is ready. 
  Now you can login to ambari: http://127.0.0.1:8080 or hue http://127.0.0.1:8000 or ssh to gateway node: ssh root@127.0.0.1 -p 2223 (password: hadoop)"
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 80, host: 42080, host_ip: "127.0.0.1", auto_correct: true #Apache http
  config.vm.network :forwarded_port, guest: 111, host: 42111, host_ip: "127.0.0.1", auto_correct: true #NFS portmap
  config.vm.network :forwarded_port, guest: 2223, host: 2223, host_ip: "127.0.0.1", auto_correct: true #Gateway node
  config.vm.network :forwarded_port, guest: 8000, host: 8000, host_ip: "127.0.0.1", auto_correct: true #Hue
  config.vm.network :forwarded_port, guest: 8020, host: 8020, host_ip: "127.0.0.1", auto_correct: true #Hdfs
  config.vm.network :forwarded_port, guest: 8042, host: 8042, host_ip: "127.0.0.1", auto_correct: true #NodeManager
  config.vm.network :forwarded_port, guest: 8050, host: 8050, host_ip: "127.0.0.1", auto_correct: true #Resource manager
  config.vm.network :forwarded_port, guest: 8080, host: 8080, host_ip: "127.0.0.1", auto_correct: true #Ambari
  config.vm.network :forwarded_port, guest: 8088, host: 8088, host_ip: "127.0.0.1", auto_correct: true #Yarn RM
  config.vm.network :forwarded_port, guest: 8443, host: 8443, host_ip: "127.0.0.1", auto_correct: true #Knox gateway
  config.vm.network :forwarded_port, guest: 8744, host: 8744, host_ip: "127.0.0.1", auto_correct: true #Storm UI
  config.vm.network :forwarded_port, guest: 8888, host: 8888, host_ip: "127.0.0.1", auto_correct: true #Tutorials
  config.vm.network :forwarded_port, guest: 10000, host: 10000, host_ip: "127.0.0.1", auto_correct: true #HiveServer2 thrift
  config.vm.network :forwarded_port, guest: 10001, host: 10001, host_ip: "127.0.0.1", auto_correct: true #HiveServer2 thrift http
  config.vm.network :forwarded_port, guest: 11000, host: 11000, host_ip: "127.0.0.1", auto_correct: true #Oozie
  config.vm.network :forwarded_port, guest: 15000, host: 15000, host_ip: "127.0.0.1", auto_correct: true #Falcon
  config.vm.network :forwarded_port, guest: 19888, host: 19888, host_ip: "127.0.0.1", auto_correct: true #Job history
  config.vm.network :forwarded_port, guest: 50070, host: 50070, host_ip: "127.0.0.1", auto_correct: true #WebHdfs
  config.vm.network :forwarded_port, guest: 50075, host: 50075, host_ip: "127.0.0.1", auto_correct: true #Datanode
  config.vm.network :forwarded_port, guest: 50111, host: 50111, host_ip: "127.0.0.1", auto_correct: true #WebHcat
  config.vm.network :forwarded_port, guest: 60080, host: 60080, host_ip: "127.0.0.1", auto_correct: true #WebHBase

  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on the "Usage" link above
    config.cache.scope = :box

  end


  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "puppet/manifests", "/puppet/manifests"
  # config.vm.synced_folder "puppet/modules", "/puppet/modules"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
     vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
     vb.customize ["modifyvm", :id, "--memory", "6024"]
     vb.customize ["modifyvm", :id, "--cpus", 2]
     vb.customize ['modifyvm', :id, '--nicpromisc1', 'allow-all']
     vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
     #vb.customize ["modifyvm", :id, "--nictype1", "Am79C973"]
     vb.customize ["modifyvm", :id, "--nic2", "none"]
     vb.customize ["modifyvm", :id, "--mouse", "usbtablet"]
     
  end
  #

 config.vm.provision "shell", path: "prepare.sh"
  
  
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with CFEngine. CFEngine Community packages are
  # automatically installed. For example, configure the host as a
  # policy server and optionally a policy file to run:
  #
  # config.vm.provision "cfengine" do |cf|
  #   cf.am_policy_hub = true
  #   # cf.run_file = "motd.cf"
  # end
  #
  # You can also configure and bootstrap a client to an existing
  # policy server:
  #
  # config.vm.provision "cfengine" do |cf|
  #   cf.policy_server_address = "10.0.2.15"
  # end

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #
  # config.vm.provision "puppet" do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision "chef_solo" do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision "chef_client" do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
