# Forced Browsing 

## What is Forced Browsing
Forced browsing is the art of using logic to find resources on the website that you would not normally be able to access. For example let's say we have a note taking site, that is structured like this. http://example.com/user1/note.txt. It stands to reason that if we did http://example.com/user2/note.txt we may be able to access user2's note.

Taking this a step further, if we ran wfuzz on that url, we could enumerate users we don't know about, as well as get their notes. This is quite devastating, because we can then run further attacks on the users we find, for example bruteforcing each user we find, to see if they have weak passwords.

## Manual Exploitation 
Lets use our note application example. When we properly authenticate, we are shown our note- with the URL changing to:
	http://10.10.112.112/noot/note.txt

We can therefore assume that 

	http://10.10.112.112/admin/note.txt

Could show an admin user and their note- if it exists. 

Forced browsing will often require some logic on the part of the hacker. To properly exploit this, you should keep notes on everything you find, building a picture of how the web application functions is essential.

## Automatic Exploitation

A tool such as wfuzz or dirsearch can find resources that normal users wouldn't be able to find. wfuzz will be the better tool in most cases, as it allows you better control over the path, so we'll go over basic wfuzz usage, and use it to exploit the our example site.
