# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider :digital_ocean do |provider, override|
    override.vm.box = "digital_ocean"
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    provider.token = ENV["DIGITALOCEAN_ACCESS_TOKEN"]
    provider.region = "sgp1"
    provider.size = "512MB"

    if ENV["WERCKER"] == "true"
      provider.ssh_key_name = "wercker-#{ENV['WERCKER_GIT_REPOSITORY']}"
      override.ssh.private_key_path = "~/.ssh/id_rsa.vagrant"
      override.vm.synced_folder ".", "/vagrant", disabled: true
    else
      provider.ssh_key_name = "local"
      override.ssh.private_key_path = "~/.ssh/id_rsa"
    end
    override.nfs.functional = false
  end

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "512"
  end

  config.vm.define "centos7" do |c|
    c.vm.box = "centos/7"
    c.vm.provider :digital_ocean do |provider, override|
      provider.image = "centos-7-0-x64"
      c.vm.hostname = "itamae-erlang-centos7"
      c.vm.hostname += "-#{ENV["WERCKER_RUN_ID"]}" if ENV["WERCKER_RUN_ID"]
    end
    c.vm.hostname = "centos7"
    c.vm.hostname += "-#{ENV["WERCKER_RUN_ID"]}" if ENV["WERCKER_RUN_ID"]
  end

  config.vm.define "aws" do |a|
    a.vm.box = "mvbcoding/awslinux"
    a.vm.hostname = "aws"
    a.vm.hostname += "-#{ENV["WERCKER_RUN_ID"]}" if ENV["WERCKER_RUN_ID"]
  end
end
