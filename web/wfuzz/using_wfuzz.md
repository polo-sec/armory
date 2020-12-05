# Wfuzz the URL fuzzing tool

## Using Wfuzz

Wfuzz is a web application, and primarily a URL, fuzzing utility. Fuzzing is trying all sorts of different data against an application in order to try and get a response that contains valuable information. It's particularly useful for positional fuzzing on a URL, for example:

	http://localhost:80/VARIABLE/note.txt

We want to fuzz the VARIABLE section of this URL, in order to do this, we just replace that position with "FUZZ" and add the rest of our syntax, like this:

	wfuzz -c -z file,/usr/share/seclists/Discovery/Web-Content/big.txt http://10.10.152.117/FUZZ/note.txt

We can see that when there isn't a note.txt it returns a 404, with 57 words. Let's hide 57 words by setting --hw to 57.


	wfuzz -c -z file,/usr/share/seclists/Discovery/Web-Content/big.txt --hw 57 http://10.10.152.117/FUZZ	    /note.txt
## Bruteforcing Usernames

If we were attempting to bruteforce usernames with wfuzz, we could use the syntax

	wfuzz -c -z file,/root/Documents/MrRobot/fsoc.dic — hs Invalid -d “log=FUZZ&pwd=aaaaa” //
	http://192.168.240.129/wp-login.php

This translates to:

    -c : makes the output colourful, this is a personal choice.

    -z : payload/wordlist — the list you want it to use.

    — hs : ignore response containing Invalid, h in this instance being hide and s is actually the 
    regex switch in this instance.

    -d : the post request

    FUZZ : the section of the post I want to fuzz


To clarify what is going on here, I had identified that a response containing ‘Invalid’ on this particular WordPress install occurred when an incorrect user name was entered, so the above string was used to pass the contents of the fsoc.dic file into the section of the request ‘FUZZ’. The ‘FUZZ’ variable is wfuzz’s way of identifying where it should be inserting the word from the wordlist. Then I told it where to send the attempts.

## Bruteforcing Passwords

After my brute force returned a user name that didn’t generate an ‘Invalid’ I essentially reversed the location of the FUZZ variable and made a tweak to the response to ignore.

wfuzz -c -z file,/root/Documents/MrRobot/fsoc.dic — hs incorrect -d “log=eliott&pwd=FUZZ” http://192.168.240.129/wp-login.php

## Directory Bruteforcing 

Here is the syntax we could use to fuzz directories from the URL, similar to gobuster, except we can

	root@kali:~/necromancer# wfuzz -c -z file,/root/necromancer/thing.txt -z file,
	/usr/share/wordlists/rockyou.txt — hc 404 http://192.168.56.102/
	amagicbridgeappearsatthechasm/FUZZ/FUZ2Z

## Including Headers

-H headers : Use headers (ex:”Host:www.mysite.com,Cookie:id=1312321&user=FUZZ")
