# Enumerating NFS

Network File System (NFS) allows remote hosts to mount the systems/ directories over a network. An NFS server can export directory that can be mounted on a remote Linux machine. This allows the user to share the data centrally to all the machines in the network. This is meant to show basic enumeration techniques to use when an NFS share is discovered on a target machine.

1. Showmount: showmount -e [ip]

2. Mount any viewable directories:

	1. mkdir /tmp/infosec

	2. mount -t nfs [ip]:/home /tmp/infosec 

	Note, when mounting NFS shares, if the share is obviously a "home" folder, check for SSH keys / .bash_history data

3. Privilege Escalation:

	 A weakly configured NFS can lead us to elevated privileges if several settings are misconfigured: i.e 

	 	no_root_squash, sync and no_subtree_check

	 1. Compile the bash binary located at /useful_tools/rootme.c : gcc rootme.c -o rootme 

	 2. Copy the binary to a user-accessable location in the mounted NFS share

	 3. Set the SUID bit: chmod 4755 rootme

	 4. From the logged-in shell go to the directory where you transferred the rootme binary and use ls -la to check the
	 owner of the file is root.

	 5. From your logged in shell run the “rootme” binary file. Since the file is owned by the root user and the suid bit
	 is set, the command inside it will give the shell with root privilege.
		
