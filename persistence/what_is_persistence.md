# What is Persistence?

## Overvieww
Persistence is a post-exploitation activity used by penetration testers in order to keep access to a system throughout the whole assessment and not to have to re-exploit the target even if the system restarts.

It can be considered that there are two types of persistence. These two types are:

* Low privileged persistence

Low privileged persistence means that the penetration tester gained and uses persistence techniques to keep his access to the target system under a normal user profile/account (a domain user with no administrative rights).

* Privileged user persistence

After gaining access to a system, sometimes (because it would be inaccurate to say always), a penetration tester will do privilege escalation in order to gain access to the highest privilege user that can be on a Windows machine (nt authority\system).

## Common methods of persistence

* Startup folder persistence
* Editing registry keys
* Using scheduled tasks
* Using BITS
* Creating a backdoored service
* Creating another user
* Backdooring RDP
