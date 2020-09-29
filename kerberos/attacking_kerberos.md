# Attacking Kerberos

## Attack Privilege Requirements

* Kerbrute Enumeration - No domain access required 
* Pass the Ticket - Access as a user to the domain required
* Kerberoasting - Access as any user required
* AS-REP Roasting - Access as any user required
* Golden Ticket - Full domain compromise (domain admin) required 
* Silver Ticket - Service hash required 
* Skeleton Key - Full domain compromise (domain admin) required

## Kerbrute 
Kerbrute (https://github.com/ropnop/kerbrute/) is a popular enumeration tool used to brute-force and enumerate valid active-directory users by abusing the Kerberos pre-authentication system.

1. You need to add the DNS domain name along with the machine IP to /etc/hosts inside of your attacker machine or these attacks will not work for you, e.g. 10.10.244.149  CONTROLLER.local

2. You can then use:

	'''./kerbrute userenum --dc [DNS DOMAIN NAME] -d [DNS DOMAIN NAME] [WORDLIST]'''

To brute force user accounts from a domain controller using a supplied wordlist

By brute-forcing Kerberos pre-authentication, you do not trigger the account failed to log on event which can throw up red flags to blue teams. 

When brute-forcing through Kerberos you can brute-force by only sending a single UDP frame to the KDC allowing you to enumerate the users on the domain from a wordlist.

## Rubeus
Rubeus is a powerful tool for attacking Kerberos. Rubeus is an adaptation of the kekeo tool and developed by HarmJ0y the very well known active directory guru.

Rubeus has a wide variety of attacks and features that allow it to be a very versatile tool for attacking Kerberos. Just some of the many tools and attacks include overpass the hash, ticket requests and renewals, ticket management, ticket extraction, harvesting, pass the ticket, AS-REP Roasting, and Kerberoasting.

The tool has way too many attacks and features for me to cover all of them so I'll be covering only the ones I think are most crucial to understand how to attack Kerberos however I encourage you to research and learn more about Rubeus and its whole host of attacks and features here - https://github.com/GhostPack/Rubeus

## Harvesting Tickets (with Rubeus)

Harvesting gathers tickets that are being transferred to the KDC and saves them for use in other attacks such as the pass the ticket attack.

1. Transfer Rubeus.exe to the target machine 
2. cd Downloads - navigate to the directory Rubeus is in
3. Use:

	'''Rubeus.exe harvest /interval:30'''

To tell Rubeus to harvest for TGTs every 30 seconds.

## Password Spraying (with Rubeus)
Rubeus can both brute force passwords as well as password spray user accounts. When brute-forcing passwords you use a single user account and a wordlist of passwords to see which password works for that given user account. In password spraying, you give a single password such as Password1 and "spray" against all found user accounts in the domain to find which one may have that password.

This attack will take a given Kerberos-based password and spray it against all found users and give a .kirbi ticket. This ticket is a TGT that can be used in order to get service tickets from the KDC as well as to be used in attacks like the pass the ticket attack.

1. Before password spraying with Rubeus, you need to add the domain controller domain name to the windows host file. You can add the IP and domain name to the hosts file from the machine by using the echo command:

	echo 10.10.226.2 CONTROLLER.local >> C:\Windows\System32\drivers\etc\hosts

2. cd Downloads - navigate to the directory Rubeus is in
3. Use:

	'''Rubeus.exe brute /password:Password1 /noticket'''

This will take a given password and "spray" it against all found users then give the .kirbi TGT for that user
