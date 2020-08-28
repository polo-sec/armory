# SMB Enumeration Checklist

This document is a checklist intended to serve as a cheatsheet for enumerating, and exploiting
an exposed capture the flag deployment. It is a basis for reconnaissance, not a covering-all 
bases guide, manual enumeration should always be done where possible.

1. Enumerate hostname:
	nmblookup -A [ip]  

2. Netbios scan:
	nbtscan [cidr]

3. Check for anonymous login:
	smbclient -L 
	Anonymous:NOPASSWD

3. List shares:
	smbmap -H [ip/hostname]
	echo exit | smbclient -L \\\\[ip]
	nmap --script smb-enum-shares -p 139,445 [ip]

4. Attempt to mount smb shares locally 

	mkdir /mnt/smb
	mount -t cifs //[ip]/[share] /mnt/smb/

4. Check null sessions:
	smbmap -H [ip/hostname]
	rpcclient -U "" -N [ip]
	smbclient \\\\[ip]\\[share name]

5. Vulnerability scan:
	nmap --script smb-vuln* -p 139,445 [ip]

6. General scan:
	enum4linux -a [ip]

7. Manually inspect target:
	smbclient -L [ip/hostname]
