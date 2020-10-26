# Persistence Using Registries

## Overview

Depending on the registries a low privileged user might be able to edit them. With this in mind, an attacker could edit the registries to achieve persistence. An example of an editable registry is: 

	HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run

## Method

1. First, let's move the backdoor to the AppData folder. You can either move it from the Downloads folder or upload it again to the AppData folder.

2. Drop into a shell and use the reg add function to create a registry that will run our backdoor as follows:

	add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v Backdoor /t REG_SZ /d "C:\Users\[USERNAME]\AppData\Roaming\backdoor.exe

3. If done correctly you will recieve the message: "The operation completed successfully" 
