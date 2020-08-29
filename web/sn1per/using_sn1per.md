# Using Sn1per

Sniper is an extremely aggressive automatic enumeration and exploitation tool, commonly used to find low hanging fruit in real
world pentest engagements. It not only automatically enumerates some services, but can automatically exploit some, and return
the loot to the user. 

1. Normal Mode
	sniper -t <TARGET>

2. Normal Mode + Osint + Recon
	sniper -t <TARGET> -o -re

3. Stealth Mode + Osint + Recon
	sniper -t <TARGET> -m stealth -o -re

4. Discover mode
	sniper -t <cidr> -m discover -w <worspace_alias>

5. Scan only specific port
	sniper -t <target> -m port -p <portnum>

6. Fullportonly scan mode
	sniper -t <target> -fp

7. Web mode - port 80 + 443 only!
	sniper -t <target> -m web

8. HTTP web port mode
	sniper -t <target> -m webporthttp -p <port>

9. HTTPS web port mode
	sniper -t <target> -m webporthttps -p <port>

10. Webscan mode
	sniper -t <target> -m webscan 

11. Enable bruteforce
	sniper -t <target> -b

12. Airstrike mode
	sniper -f targets.txt -m airstrike

13. Nuke mode with list, bruteforce enabled, fullportscan enabled, osint enabled, recon enabled, workspace & loot enabled
	sniper -f targets.txt -m nuke -w <workspace_alias>

14. Mass port scan mode
	sniper -f targets.txt -m massportscan

15. Mass web scan mode
	sniper -f targets.txt -m massweb

16. Mass webscan scan mode
	sniper -f targets.txt -m masswebscan

17. Mass vuln scan mode
	sniper -f targets.txt -m massvulnscan

18. Port scan mode
	sniper -t <target> -m port -p <port_num>

19. List workspaces
	sniper --list

20. Delete workspace
	sniper -w <workspace_alias> -d

21. Delete host from workspace
	sniper -w <workspace_alias> -t <target> -dh

22. Get sniper scan status
	sniper --status

23. Loot reimport function
	sniper -w <workspace_alias> --reimport

24. Loot reimportall function
	sniper -w <workspace_alias> --reimportall

25. Loot reimport function
	sniper -w <workspace_alias> --reload

26. Loot export function
	sniper -w <workspace_alias> --export

27. Scheduled scans
	sniper -w <workspace_alias> -s daily|weekly|monthly

28. Use a custom config
	sniper -c /path/to/sniper.conf -t <target> -w <workspace_alias>

29. Update sniper
	sniper -u|--update
