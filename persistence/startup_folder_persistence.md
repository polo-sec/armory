# Startup Folder Persistence

## Overview
Supposing we do not consider privilege escalation is necessary and we just want to have access to the system in case the user restarts the machine the simplest method would be moving the backdoor to the startup folder.

## The Startup Folder
The path of the startup folder is: 

	C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup. %username% is the username of whatever user you have access to. 

Browse to that path and upload the binary you generated with msfvenom. Since the binary is in the startup folder every time a user restarts its computer and logs in the backdoor will be executed and Metasploit will receive the connection.
