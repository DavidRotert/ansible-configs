#!/bin/sh

echo Updating Python apps in /opt ...

/opt/xonsh/bin/pip install --upgrade pip xonsh[full] setproctitle jedi
/opt/spyder/bin/pip install --upgrade pip spyder
/opt/gdbgui/bin/pip install --upgrade pip gdbgui
/opt/eric/bin/pip install --upgrade pip eric-ide
