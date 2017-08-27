#!/bin/bash -xe

readonly HOST=$1

vagrant up $HOST --provider=digital_ocean

# for debug
echo `whoami`
echo `pwd`
echo `ls -alh ~/.ssh`
echo `ls -alh`
echo `vagrant ssh-config`

#bundle exec rake itamae:$HOST -v
#bundle exec rake spec:$HOST -v
