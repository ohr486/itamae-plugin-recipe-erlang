#!/bin/bash -xe

echo "### ci/setup.sh ###"

echo "# install vagrant"
wget https://releases.hashicorp.com/vagrant/1.9.8/vagrant_1.9.8_x86_64.rpm
rpm -i vagrant_1.9.8_x86_64.rpm
vagrant plugin install vagrant-digitalocean

#gem uninstall bundler --all --force
#gem install bundler --no-document

# put ssh keys
echo "# put ssh key"
echo "# $DIGITALOCEAN_KEY_PRIVATE"
echo "# $DIGITALOCEAN_KEY_PUBLIC"

mkdir -m 700 -p $HOME/.ssh
set +x
echo -e "$DIGITALOCEAN_KEY_PRIVATE" > $HOME/.ssh/id_rsa.vagrant
echo -e "$DIGITALOCEAN_KEY_PUBLIC"  > $HOME/.ssh/id_rsa.vagrant.pub
set -x

chmod 600 $HOME/.ssh/id_rsa.vagrant
