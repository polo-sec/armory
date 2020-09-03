# SSH Tunnels 

## What is an SSH tunnel
An SSH tunnel is a type of port forwarding that you can set up over SSH, it allows a certain port on your system to be forwarded, through an SSH connection, to a different IP address on the network that has been SSH'd into- as though the connection was coming from the machine that has been SSH'd into. This, in an attacking scenario, allows you to remotely access internal services, from applications on your own attacking machine, over an SSH session.

## Setting up an SSH tunnel
### What you need
1. The credentials of the user you're trying to SSH tunnel as 
2. The location and port for the remote service you're trying to access, in this case- it's jenkins on port 8080

### Syntax
1. You can then start an SSH tunnel with this command:

	ssh -L 8080:172.17.0.2:8080 aubreanna@10.10.91.238

	the "-L" argument supplied is for local port forwarding, which is this type of SSH tunnel.

2. You can now access the service on that port, e.g. jenkins, through localhost:8080 (or whatever port you specified after the -L) as though it was on your local network. E.g. through a browser.
