#!/bin/sh
xfce4-panel --quit
kill xfconfd
ansible-playbook --ask-become --extra-vars "config_user=$(whoami) copy_configs=false install_plasma=true" ansible-configs/playbooks/manjaro-development-environment.yml
xfce4-panel &
