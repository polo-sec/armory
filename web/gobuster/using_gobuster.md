# Using Gobuster

Gobuster is one of the most powerful subdomain enumeration/url-fuzzing tools out there. It's practically a requirement to use
it during any web-based CTF challenges. It's best used in combination with the "SecLists" wordlist library, that can be 
installed from the kali/parrot/blackarch repositories. 

1. Common options:

	These are some of the most common flags you can append to commands you're running

    	-fw – force processing of a domain with wildcard results.
    	-np – hide the progress output.
    	-m  – which mode to use, either dir or dns (default: dir).
    	-q – disables banner/underline output.
   	-t – number of threads to run (default: 10).
    	-u  – full URL (including scheme), or base domain name.
    	-v – verbose output (show all results).
    	-w  – path to the wordlist used for brute forcing (use – for stdin).

2. DNS Bruteforcing

	The DNS mode is used for DNS subdomain brute-forcing. You can use it to find subdomains for a given domain
		
		gobuster dns -d [domain] -w [wordlist]

3. Dir Mode

	The Dir mode is used to find additional content on a specific domain or subdomain. This includes hidden 
	directories and files.

		gobuster dir -u [url] -w [wordlist]
	
	In dir mode, you can brute-force files with specific file extensions using the -x flag:

		gobuster dir -u [url] -w [wordlist] -x .php
	
	You can also use the -c flag to specify the cookies that should accompany your requests, useful for enumeration of 
	cookie-authenticated webpages.

		gobuster dir -u [url] -w [wordlist] -c 'session=123456'

4. Vhost Enumeration

	This mode is useful for fuzzing the vhost of a url, to check for other domains that belong to the target with a 
	different VHOST origin. 

		gobuster vhost -w [wordlist] -u [url]	
