# Capabilities in Linux

For the purpose of performing permission checks, traditional UNIX implementations distinguish two categories of processes: privileged processes (whose effective user ID is 0, referred to as superuser or
root), and unprivileged processes (whose effective UID is nonzero). Privileged processes bypass all kernel permission checks, while unprivileged processes are subject to full permission checking based on the process's credentials (usually: effective UID, effective GID, and supplementary group list).

1. You can list the permissions you have using 

	getcap -r / 2>/dev/null

2. This will then display the programs / binaries / scripts you're able to execute with elevated permissions. 
