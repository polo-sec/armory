# The Common Gateway Interface (CGI) and Exploitation

## What is the CGI?
Webservers don't just display websites. They are capable of interacting with the operating system directly. The Common Gateway Interface or CGI for short is a standard means of communicating and processing data between a client such as a web browser to a web server. Despite their age, CGI scripts are still relied upon from devices such as embedded computers to IoT devices, Routers, and the likes, who can't run complex frameworks like PHP or Node. 

Simply, this technology facilitates interaction with programmes such as Python script files, C++ and Java application, or system commands all within the browser - as if you were executing it on the command line.

## Finding CGI
Whilst CGI has the right intentions and use cases, this technology can quickly be abused by people like us! The commonplace for CGI scripts to be stored is within the /cgi-bin/ folder on a webserver. Take, for example, this systeminfo.sh file that displays the date, time and the user the webserver is running as. It can be run by calling it from the cgi bin directory:

	"10.10.12.86/cgi-bin/systeminfo.sh"

When navigating to the location of this script using our browser, the script is executed on the web server, the resulting output of this is then displayed to us. How could we use this?

## Arbitrary Command Execution
We could, perhaps, parse our own commands through to this script that will be executed. Because we know that this is a Ubuntu machine,  we can try some Linux commands like ls to list the contents of the working directory:

	"10.10.12.86/cgi-bin/systeminfo.sh&ls"

Or on a Windows machine, the systeminfo command reveals some useful information:

	"10.10.12.86/cgi-bin/systeminfo.sh&systeminfo"

This is achieved by parsing the command as an argument with ?& i.e. ?&ls. As this is a web server, any spaces or special characters will need to be URL encoded.
