#!/bin/sh

echo Updating Python apps in /opt ...

sudo python3 -m venv --upgrade /opt/xonsh
sudo /opt/xonsh/bin/pip install --upgrade pip xonsh[full] setproctitle jedi

sudo python3 -m venv --upgrade /opt/spyder
sudo /opt/spyder/bin/pip install --upgrade pip spyder

sudo python3 -m venv --upgrade /opt/gdbgui
sudo /opt/gdbgui/bin/pip install --upgrade pip gdbgui
