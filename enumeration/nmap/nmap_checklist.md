# Nmap Checklist

Nmap is the most widely used portscanning tool and can be a critical part of enumerating any capture the flag box. It's always
a good idea to port scan a few times, first using an initial scan to get the lay of the land- and then conducting more in-depth
scans, on larger port ranges to make sure you aren't missing anything. 

1. Initial Scan: nmap -sC -sV -oN nmap/initial [ip]

2. Follow-Up Scan: nmap -sC -sV -p- -oN nmap/full_range 

3. Vulnerability Scan :

	1. Install the .nse script : ln -s `pwd`/scipag_vulscan /usr/share/nmap/scripts/vulscan
	2. nmap -sV --script=vulscan/vulscan.nse [ip]

