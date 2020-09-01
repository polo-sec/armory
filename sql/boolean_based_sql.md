# Boolean Based SQLi

## Definition 

Boolean-based SQL Injection relies on sending an SQL query to the database which forces the application to return a different result depending on whether the query gave a TRUE or FALSE result. Depending on the result, the content of the HTTP response will change, or remain the same (Change in HTTP response usually stands for a FALSE response, while TRUE does not affect anything). This allows an attacker to understand if the payload used returned true or false, even though no data from the database is returned.

## Blind Testing
The boolean based sqli is usually carried out in a blind situation. Blind, in this case, means that there's no actual output and that we cannot see any error message (like we did previously).

## Testing for Boolean Based SQli

### Testing Blind SQLi

1. Browse to 10.10.11.144/sqli-labs/Less-8/?id= and let's take a look.

2. Inputting single or a double quote doesn't produce any result, same as slashes. This gives us the idea of the blindness of our sql injection (or even absence of vulnerability at all). In this situation, we'll have to practically guess the query and exploit the database right away. 

3. Make the id parameter equal to 1. We now see a message:
	
	You are in...........

4. Now, let's blindly assume that the same as in the previous unit, putting 1' as the id value would produce some error.

	10.10.11.144/sqli-labs/Less-8/?id=1'

5. It did! We didn't see the error message but the message disappeared meaning that we were actually able to produce some sort of error. Now, fix we can fix the query by putting --+

	10.10.11.144/sqli-labs/Less-8/?id=1' --+

6. Great! The message is back. See what happened here, even though we are not able to see any SQL output, by making some simple assumption we were able to find a similar pattern.

### Now the Boolean Part

But the difference is that boolean sqli relies on the concept of True-False relation. Let's see how it works here. 

1. Put OR 1 in the link like so

	10.10.11.144/sqli-labs/Less-8/?id=1' OR 1 --+, representing the True value. 

Means we will still see the message. 

2. Putting OR 0: 

	10.10.11.144/sqli-labs/Less-8/?id=1' OR 0 --+, representing the False value.

Won't logically display the message directly proving our ability to perform an SQL injection attack

### Exploitation

Well, now as we can only return True (You are in...........) or False (no message) statements, we need to start playing the game of yes-no with the database. By asking 'questions' about the database length and table quantity we can dump and enumerate the database. 

At this point, it is important to understand that in SQL language we can actually use =, <, > to compare the values.

Try putting different comparison values in the link
	
	10.10.11.144/sqli-labs/Less-8/?id=1' OR 1 < 2 --+ = True
	
	or
	
	10.10.11.144/sqli-labs/Less-8/?id=1' OR 1 > 2 --+ = False

This comparison can be actually helpful for us in asking those 'questions'. For this particular room let's try to get the database's name using blind sql injection.

### Substring 

In sql language, there's a really useful function called SUBSTR() which extracts a substring from a string (starting at any position). 
It takes 3 input values:

1. Operated text (in our case database name)
2. Character to start with
3. Number of characters to extract

For example, running SELECT SUBSTR("Strange Fox", 5, 3) will return us nge.

Therefore, our SQLi payload would look like:
	
	AND (substr((select database()),1,1)) 

This will return us the first character of the database name. 

Now, what we need to do is literally guess the character by trying to compare that payload to some letters. Theoretically, the payload would look like that
	
	1' substr((select database()),1,1)) = s --+

Happily for us, there's a way to avoid using characters and actually speed things up (instead of fuzzing the whole alphabet). If we add ascii() function before the payload, we'll be able to compare it to ascii character values. 
	
	10.10.11.144/sqli-labs/Less-8/?id=1' AND (ascii(substr((select database()),1,1))) = 115 --+

This will once again return us You are in........... because s letter corresponds to 115 in ASCII.

Of course, in the real world we cannot simply guess that so we need to use > and < operators to compare the value of the characters to their ASCII values. 

Now try guessing the second letter using the comparison technique.

Hint:

10.10.11.144/sqli-labs/Less-8/?id=1' AND (ascii(substr((select database()),2,1))) < 115 --+
