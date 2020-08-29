#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: ./http_enum.sh [IP] [PORT]"
    exit 2
fi

# Return command line arguments for sanity check
echo "IP: $1"
echo "PORT: $2"

# HTTP enumeration workflow 
http_enum (){
        mkdir -p ./http
        echo "> Starting HTTP Enumeration"
        echo "> Scanning with Nikto"
	nikto -ask=no -h $1:$2 >> ./web/nikto_scan &
	echo "> Pulling plugins and headers with whatweb"
        whatweb -a3 $1:$2 2>/dev/null | tee -a ./web/whatweb
        echo "> Curling interesting files"
        curl -sSiK $1:$2/index.html | tee -a ./web/landingpage &
        curl -sSik $1:$2/robots.txt | tee -a ./web/robots.txt &
        wait
	echo "> Subdomain Enumeration"
        gobuster dir -re -t 65 -u $1:$2 -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt -o ./web/dir_enum -k
	echo "> Vhost Fuzzing"
	gobuster vhost -t 65 -u $1:$2 -w /usr/share/seclists/Discovery/Web-Content/raft-small-directories-lowercase.txt
	echo "> File Enumeration"
	gobuster dir -re -t 65 -x zip,tar,gzip,php,txt,jar,sql,doc,csv,dat,xml,db,dbf,mdb -u $1:$2 -w /usr/share/seclists/Discovery/Web-Content/big.txt -o ./web/files_enum
 	echo "> Scanning with Nuclei"
	nuclei -l ./web/directories_enum -t /home/matt/Documents/armory/web/nuclei/nuclei-templates/ -o /web/nuclei
	# Log commands that have been run
        touch ./http/commands_run
        echo "nikto -h $1" >> ./http/commands_run &
        echo "whatweb -v -a 3 $1" >> ./http/commands_run &
	echo "curl -sSiK $1" >> ./http/commands_run &
        echo "curl -sSiK $1/robots.txt" >> ./http/commands_run &
        echo "gobuster dir -re -t 65 -u $1:$2 -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt -o ./web/dir_enum -k" >> ./http/commands_run &  
        echo "gobuster vhost -t 65 -u $1:$2 -w /usr/share/seclists/Discovery/Web-Content/raft-small-directories-lowercase.txt" >> ./http/commands_run &  
        echo "gobuster dir -re -t 65 -x zip,tar,gzip,php,txt,jar,sql,doc,csv,dat,xml,db,dbf,mdb -u $1:$2 -w /usr/share/seclists/Discovery/Web-Content/big.txt -o ./web/files_enum" >> ./http/commands_run &
        echo "nuclei -target https://juice-shop.herokuapp.com/#/ -t nuclei-templates/ -o results.txt" >> ./http/commands_run &
	wait
        echo "> HTTP Enumeration Complete"
}
