#!/bin/sh
COPY_CONFIGS=true

xfce4-panel --quit
kill xfconfd
ansible-playbook --ask-become --extra-vars "config_user=$(whoami) copy_configs=$COPY_CONFIGS" ansible-configs/playbooks/manjaro-development-environment.yml
xfce4-panel &
