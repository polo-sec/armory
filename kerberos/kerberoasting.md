# Kerberoasting

## Overview
Kerberoasting allows a user to request a service ticket for any service with a registered SPN then use that ticket to crack the service password. If the service has a registered SPN then it can be Kerberoastable however the success of the attack depends on how strong the password is and if it is trackable as well as the privileges of the cracked service account. To enumerate Kerberoastable accounts I would suggest a tool like BloodHound to find all Kerberoastable accounts, it will allow you to see what kind of accounts you can kerberoast if they are domain admins, and what kind of connections they have to the rest of the domain. That is a bit out of scope for this room but it is a great tool for finding accounts to target.

## Tools 
In order to perform the attack, we'll be using both Rubeus as well as Impacket so you understand the various tools out there for Kerberoasting. There are other tools out there such a kekeo and Invoke-Kerberoast but I'll leave you to do your own research on those tools.

## Kerberoating with Rubeus

1. cd Downloads - navigate to the directory Rubeus is in

2. Rubeus.exe kerberoast - This will dump the Kerberos hash of any kerberoastable users

3. Then, copy the hash onto your attacker machine- and put it into a .txt file so we can crack it with hashcat using:

	''hashcat -m 13100 -a 0 hash.txt wordlist.txt'' 



