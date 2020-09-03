# IDOR Vulnerabilities

## What is IDOR
IDOR, or Insecure Direct Object Reference, is the act of exploiting a misconfiguration in the way user input is handled, to access resources you wouldn't ordinarily be able to access. 

For example, let's say we're logging into our bank account, and after correctly authenticating ourselves, we get taken to a URL like this https://example.com/bank?account_number=1234. On that page we can see all our important bank details, and a user would do whatever they needed to do and move along their way thinking nothing is wrong.

There is however a potentially huge problem here, a hacker may be able to change the account_number parameter to something else like 1235, and if the site is incorrectly configured, then he would have access to someone else's bank information.

While this may seem dramatic, exploiting this is the real world can have drastic consequences. Let's say you found an IDOR vulnerability in a note keeping site, which allowed you to access the notes of others, you could find plenty of personal details, like passwords, usernames, even credit card information.

## Exploitation

There is no way to automatically exploit this, as the pentester you need to examine the site, and find misconfigurations.
