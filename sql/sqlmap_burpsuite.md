# SQLMap and Burpsuite

## Overview
The most beneficial feature of sqlmap is its integration with BurpSuite. With BurpSuite, you can capture and save login or search information to use with SQLMap. This is done by intercepting a request. You will need to configure your browser to use BurpSuite as a proxy for this request to capture. The AttackBox has made this simple for you by using the FoxyProxy extension in Firefox.

## Using Saved Requests
We can use saved requets with sqlmap using:

	sqlmap -r filename
