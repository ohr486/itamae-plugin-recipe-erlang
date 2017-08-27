#!/bin/bash -xe

readonly HOST=$1

vagrant up $HOST --provider=digital_ocean
vagrant status
vagrant ssh-config

bundle exec rake itamae:$HOST
bundle exec rake spec:$HOST
