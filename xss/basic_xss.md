# XSS (Cross-Site Scripting)

XSS or Cross-site scripting is a vulnerability that allows attackers to run javascript in web applications. These are one of the most found bugs in web applications. Their complexity ranges from easy to extremely hard, as each web application parses the queries in a different way. 

## DOM (Special)
DOM XSS (Document Object Model-based Cross-site Scripting) uses the HTML environment to execute malicious javascript. This type of attack commonly uses the <script></script> HTML tag.

### Testing for DOM

We will use the iframe tag with an alert: 

<iframe src="javascript:alert(`xss`)"> 

This type of XSS is also called XFS (Cross-Frame Scripting), is one of the most common forms of detecting XSS within web applications.

Websites that allow the user to modify the iframe will most likely be vulnerable to XSS.   

	1. All we have to do is input this into a vulnerable input field! 


## Persistant XSS
Persistent XSS is javascript that is run when the server loads the page containing it. These can occur when the server does not sanitise the user data when it is uploaded to a page. These are commonly found on blog posts.

### Testing for Persistant XSS
Persistant XSS means changing a value that's held server-side.

	1. For this we need to find a value that the user can control- that is stored server-side, and then change it to our 
	iframe tester. (Often we can do this with HTTP Headers)

	2. We can then change the value of this paramater to our iframe tester e.g. through a burp intercept 
 
## Reflected XSS
Reflected XSS is javascript that is run on the client-side end of the web application. These are most commonly found when the server doesn't sanitise search data. 

### Testing for Reflected XSS


