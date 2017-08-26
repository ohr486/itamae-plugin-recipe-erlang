#!/bin/bash -xe

readonly HOST=$1

vagrant up $HOST --provider=digital_ocean
bundle exec rake itamae:$HOST -v
bundle exec rake spec:$HOST -v
