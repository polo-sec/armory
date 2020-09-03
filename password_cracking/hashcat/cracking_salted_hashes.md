# Cracking salted hashes with Hashcat 

## What is a salted hash?

Salting a hash is the process of adding random data to the input of a hash function to guarantee a unique output, the hash, even when the inputs are the same. Consequently, the unique hash produced by adding the salt can protect us against different attack vectors, such as rainbow table attacks, while slowing down dictionary and brute-force attacks.

Importantly, this means that if you're in a situation where hash-cracking is clearly the pathway that is meant to be taken, you need to use special syntax in order to crack a salted hash.

## Information needed

1. You'll need to identify the type of hash that your result is, e.g. sha256, md5 etc. You can do this using hashid- or preferably look at how the hash is being generated. This will give you a clue as to what the hashing algorithm is.

2. Refer to the hashcat help menu:
	
	hashcat -h
   
   or https://hashcat.net/wiki/doku.php?id=hashcat

   To get the mode number that refers to the hash method being used, in combination with a salted value, e.g:

   	1710 | sha512($pass.$salt) | Raw Hash, Salted and/or Iterated

## Cracking the hash

1. Check the arguments required, and the format that hashcat needs to crack them. In the case of mode 1710, we need to supply either the variables above ($pass.$salt) to the hashcat argument or alternatively it can be done on one line, like so:

	hashcat -m 1710 "6d05358f090eea56a238af02e47d44ee5489d234810ef6240280857ec69712a3e5e370b8a41899d0196ade16c0d54327c5654019292cbfe0b5e98ad1fec71bed:1c362db832f3f864c8c2fe05f2002a05" 

	Note the ":" used to seperate the main password hash and the salt 

2. Attach a wordlist such as /usr/share/seclists/Passwords/Database-Leaks/rockyou.txt and crack!
