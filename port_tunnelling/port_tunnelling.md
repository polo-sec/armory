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
