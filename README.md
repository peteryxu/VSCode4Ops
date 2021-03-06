# added on 03/05 from Web edit

# python virutalenv
brew install python3
pip3 install virtualenv

# create/activate/deactivate enviroments
virtualenv -p python3 <desired-path>
source <desired-path>/bin/activate
deactivate

# select intepreter in VSC

Selecting an interpreter sets the python.pythonPath value in your workspace settings to the path of the interpreter. To see the setting, select File > Preferences > Settings (Code > Preferences > Settings on macOS), then select the Workspace Settings tab.

Note: If you select an interpreter without a workspace folder open, VS Code sets python.pythonPath in your user settings instead, which sets the default interpreter for VS Code in general. The user setting makes sure you always have a default interpreter for Python projects. The workspace settings lets you override the user setting.

# python getting started in VSC
https://code.visualstudio.com/docs/python/python-tutorial

