# Ticket Passing Attack

## Overview
Pass the ticket works by dumping the TGT from the LSASS memory of the machine. The Local Security Authority Subsystem Service (LSASS) is a memory process that stores credentials on an active directory server and can store Kerberos ticket along with other credential types to act as the gatekeeper and accept or reject the credentials provided.

You can dump the Kerberos Tickets from the LSASS memory just like you can dump hashes!

When you dump the tickets with mimikatz it will give us a .kirbi ticket which can be used to gain domain admin if a domain admin ticket is in the LSASS memory. This attack is great for privilege escalation and lateral movement if there are unsecured domain service account tickets laying around.

The attack allows you to escalate to domain admin if you dump a domain admin's ticket and then impersonate that ticket using mimikatz PTT attack allowing you to act as that domain admin.

You can think of a pass the ticket attack like reusing an existing ticket. We're not creating or destroying any tickets here we're simply reusing an existing ticket from another user on the domain and impersonating that ticket.

## Dumping tickets with Mimikatz

You first need administrator privileges to conduct this attack using mimikatz. If you don't have an elevated command prompt mimikatz will not work properly. 

1. cd Downloads - Navigate to the directory mimikatz is in

2. mimikatz.exe - Run mimikatz

3. privilege::debug - Ensure this outputs [output '20' OK] if it does not that means you do not have the administrator privileges to properly run mimikatz.

4. sekurlsa::tickets /export - This will export all of the .kirbi tickets into the directory that you are currently in.

## Passing the ticket with Mimikatz
Now that we have our ticket ready we can now perform a pass the ticket attack to gain domain admin privileges.

1. kerberos::ptt <ticket> - Run this command inside of mimikatz with the ticket that you harvested from earlier. It will cache and impersonate the given ticket.

2. klist - Here were just verifying that we successfully impersonated the ticket by listing our cached tickets.  

3. You now have impersonated the ticket giving you the same rights as the TGT you're impersonating. To verify this we can look at the admin share.

## Ticket Passing Mitigation
Don't let your domain admins log onto anything except the domain controller - This is something so simple however a lot of domain admins still log onto low-level computers leaving tickets around that we can use to attack and move laterally with.
