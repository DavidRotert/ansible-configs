#!/bin/sh
COPY_CONFIGS=true
CONFIG_USER=$(whoami)

xfce4-panel --quit
killall xfconfd
ansible-playbook --ask-become --extra-vars "config_user=$CONFIG_USER copy_configs=$COPY_CONFIGS" ansible-configs/playbooks/manjaro-development-environment.yml
xfce4-panel &
