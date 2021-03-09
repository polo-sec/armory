# Stored XSS

## Overview
Stored cross-site scripting is the most dangerous type of XSS. This is where a malicious string originates from the website itself. This often happens when a website allows user input that is not sanitised before storage in the database.

## Example Scenario
A attacker creates a payload in a field when signing up to a website that is stored in the websites database. If the website doesn't properly sanitise that field, when the site displays that field on the page, it will execute the payload to everyone who visits it.

However, this payload wont just execute in your browser but any other browsers that display the malicious data inserted into the database.
