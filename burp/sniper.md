# Using BurpSuite's Sniper Tool

We can capture a login request, but instead of sending it through the proxy, we will send it to Intruder. This lets us change paramaters much easier than something like hydra. Albeit at the cost of speed. 

## Conducting a password bruteforce with Sniper

1. Goto Positions and then select the Clear § button. In the password field place two § inside the quotes. 

2. For the payload, we will be using the best1050.txt from Seclists. (Which can be installed: apt-get install seclists)

3. Once the file is loaded into Burp, start the attack. You will want to filter for the request by status. A failed request will receive a 401 Unauthorized whereas a successful request will return a 200 OK.


