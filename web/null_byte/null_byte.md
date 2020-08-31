# Null Bytes

A Poison Null Byte is actually a NULL terminator. By placing a NULL character in the string at a certain byte, the string will tell the server to terminate at that point, nulling the rest of the string. 

## Using a null byte character bypass

When looking at a URL that prevents specific file access, we can sometimes get around this by using a character bypass called "Poison Null Byte". A Poison Null Byte looks like this: %00. Note that we can download it using the url, so we will encode this into a url encoded format.

The Poison Null Byte will now look like this: %2500. Adding this and then a .md will bypass the 403 error!
