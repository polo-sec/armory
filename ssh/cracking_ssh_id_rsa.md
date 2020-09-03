# Cracking SSH Keys (id_rsa) with John the Ripper

## What is the id_rsa file? 
SSH uses public/private key pairs, so id_rsa is your RSA private key. This key can allow access to an ssh account, when logged in with using the modifier -i [id_rsa filename]. It's worth noting that the id_rsa key needs to have its permissions set to 600 otherwise SSH does not consider it a valid key

## Cracking SSH passwords with John the Ripper
If, through exposure on a website or nfs / smb file share, you can get hold of an id_rsa file, the password that needs to be used in conjunction with it to log into an SSH account can sometimes be cracked. 

1. Use ssh2john to create a John the Ripper compatible hash with

	ssh2john id_rsa > hashed_id_rsa

2. Then provide John the Ripper with the hash and either use the built-in wordlist, or a different one from seclists/rockyou

	john hashed_id_rsa

