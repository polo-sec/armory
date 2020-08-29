# Using Nuclei 

This document is intended to show how to use the basics of nuclei for finding web vulnerabilities. It's by no means an
exhaustive list, you can visit https://nuclei.projectdiscovery.io/nuclei/ for a more complete guide for customising template
scanning / vulnerability assessment.

Nuclei is a target scanner used to send requests to a target, based on templates, meaning it's extremely extendible, and can
be adapted to scan different factors based on the template you're using. It's good at finding easy to spot vulns, and
automatically checking CVE's across a range of pages. 

1. Running nuclei with a single template.

	This will run the tool against all the hosts in urls.txt and returns the matched results.

		nuclei -l urls.txt -t files/git-core.yaml -o results.txt
	
	You can also pass the list of hosts at standard input (STDIN). This allows for easy integration in automated workflows
	/ pipelines. For example: 

		cat urls.txt | nuclei -t files/git-core.yaml -o results.txt

2. Working with multiple templates.

	This will run the tool against all the hosts in urls.txt with all the templates in the cve's directory and returns 
	the matched results.

		nuclei -l urls.txt -t cves/* -o results.txt 

3. Example Scripted Workflow

	using subfinder to get url's which are then filtered and scanned

		subfinder -d hackerone.com -silent | httpx -silent | nuclei -t cves/ -o results.txt

4. Updating the nuclei templates:

	It's important to keep the nuclei templates updated, they're actively worked on to include the latest vulnerabilities

		nuclei -update-templates

