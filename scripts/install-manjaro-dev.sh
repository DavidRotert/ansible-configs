#!/bin/sh
COPY_CONFIGS=true
DESKTOP=desktop
CONFIG_USER=$(whoami)

sudo pamac install ansible ansible-lint

xfce4-panel --quit
killall xfconfd

ansible-playbook --ask-become --extra-vars "desktop=$DESKTOP config_user=$CONFIG_USER copy_configs=$COPY_CONFIGS" ansible-configs/playbooks/manjaro-development-environment.yml

xfce4-panel &
