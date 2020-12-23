# Server Side Request Forgery
Server-Side Request Forgery (SSRF) is a web app vulnerability that allows attackers to force the web application server to make requests to resources it normally wouldn't.

For example, a web app may have the functionality to produce screenshots of other websites when a user supplies a URL. This is perfectly valid functionality, however, URLs can also be made for internal IP addresses (e.g. 192.168.1.1, 10.10.10.10, 127.0.0.1 etc.) as well as internal-only hostnames (e.g. localhost, WIN2019SERV.CORP). If a web developer is not careful, an attacker could provide the app with these and manage to screenshot internal resources, which often have less protections

To counter this, user-provided URLs can be checked before they are requested, to ensure that malicious values are not being used. However, due to the complex nature of URLs themselves, there are often many things an attacker can do to bypass these checks.

Note that while the example of SSRF used in this task is effectively a Remote File Inclusion (RFI) vulnerability as well, not every SSRF is. Some SSRF vulnerabilities only trigger a DNS lookup, while others may not return any kind of response to the web app, but can still be used to "port scan" internal systems by measuring the time each request takes to complete. 

In other cases, SSRF may be used as a form of Denial of Service (DoS) since the attacker can continually request that the server download large files simultaneously (taking up memory, disk space, and network bandwidth).

## Example
Notice that the URL for the page looks something like this: http://10.10.170.157/?proxy=http%3A%2F%2Flist.hohoho%3A8080%2Fsearch.php%3Fname%3Dtest

If we use a URL decoder such as this one: https://www.urldecoder.org/ on the value of the "proxy" parameter, we get: http://10.10.170.157/?proxy=http://list.hohoho:8080/search.php?name=test

Since "list.hohoho" is not a valid hostname on the Internet (.hohoho is not a top-level domain), this hostname likely refers to some back-end machine. It seems that the web app works by taking this URL, making a request at the back-end, and then returning the result to the front-end web app. If the developer has not been careful, we may be able to exploit this functionality using Server-Side Request Forgery (SSRF).

The most obvious thing we can try to do first is to fetch the root of the same site. Browse to: http://10.10.170.157/?proxy=http%3A%2F%2Flist.hohoho%3A8080%2F which as a decoded URL is http://10.10.170.157/?proxy=http://list.hohoho:8080/ and observe the repsonse on the webpage. 

This seems to have potential, as in place of the original "test is on the Nice List." message, we instead see "Not Found. The requested URL was not found on this server." This seems like a generic 404 message, indicating that we were able to make the server request the modified URL and return the response.

There are many things we could do now, such as trying to find valid URLs for the "list.hohoho" site. We could also try changing the port number from 8080 to something else, to see if we can connect to any other services running on the host, even if these services are not web servers.

## Port Enumerating with SSRF
1. Try changing the port number from 8080 to just 80 (the default HTTP port): http://10.10.170.157/?proxy=http%3A%2F%2Flist.hohoho%3A80

The message now changes to "Failed to connect to list.hohoho port 80: Connection refused" which suggests that port 80 is not open on list.hohoho.

2. Try changing the port number to 22 (the default SSH port): http://10.10.170.157/?proxy=http%3A%2F%2Flist.hohoho%3A22

The message now changes to "Recv failure: Connection reset by peer" which suggests that port 22 is open but did not understand what was sent (this makes sense, as sending an HTTP request to an SSH server will not get you anywhere!)

Enumerating open ports via SSRF can be performed in this manner, by iterating over common ports and measuring the differences between responses. Even in cases where error messages aren't returned, it is often possible to detect which ports are open vs closed by measuring the time each request takes to complete.

## Accessing Local Services
Another thing we can try to do with SSRF is access services running locally on the server. We can do this by replacing the list.hohoho hostname with "localhost" or "127.0.0.1" (among others). Try this now: http://10.10.170.157/?proxy=http%3A%2F%2Flocalhost

## Bypassing Hostname Filter 
Oops! It looks like the developer has a check in place for this, as the message returned says "Your search has been blocked by our security team."

Indeed, if you try other hostnames (e.g. 127.0.0.1, example.com, etc.) they will all be blocked. The developer has implemented a check to ensure that the hostname provided starts with "list.hohoho", and will block any hostnames that don't.

As it turns out, this check can easily be bypassed. Since the hostname simply needs to start with "list.hohoho", we can take advantage of DNS subdomains and create our own domain "list.hohoho.evilsite.com" which resolves to 127.0.0.1. In fact, we don't even need to buy a domain or configure the DNS, because multiple domains already exist that let us do this. The one we will be using is localtest.me, which resolves every subdomain to 127.0.0.1.

We can therefore set the hostname in the URL to "list.hohoho.localtest.me", bypass the check, and access local services: http://10.10.170.157/?proxy=http%3A%2F%2Flist.hohoho.localtest.me

