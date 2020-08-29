# Nikto Checklist

This is a document intended to provide example usage of the nikto tool, as well as a areminder on looking through output. Nikto is one of the most commonly used website vulnerability scanners in the industry. It is an open source web server scanner that renders a bunch of vulnerabilities found on a website that could be exploited. Hence playing a primary role to perform website assessment and detects possible vulnerabilities on a site to keep it safe from an attacker.

Assume that you have a URL of a target, by using Nikto you need to provide it with one of the three different types of information i.e. an IP Address for a local service, a web domain or an SSL/HTTPS enabled website. These are the three main target information used by Nikto to dig around and hunt the vulnerabilities

1. Nikto on a single host: nikto -h [ip]

2. Nikto on a range of IP's : nikto -h [ip-list.txt]
