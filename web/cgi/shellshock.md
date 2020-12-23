# Shellshock

## A CGI Attack
Now we understand the application that's running, tools such as Metasploit can be used to confirm suspicions and hopefully leverage them! After some independent research, this application is vulnerable to the ShellShock attack (CVE 2014-6271).

In order for the attack used as the example in this task to work, the options would be set like so:

    LHOST - 10.0.0.10 (our PC)
    RHOST - 10.0.0.1 (the remote PC)
    TARGETURI /cgi-bin/systeminfo.sh (the location of the script)
