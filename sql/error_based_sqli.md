# Error-Based SQLi 

## Definition
Error-based SQLi is a SQL Injection technique that relies on error messages which are used to retrieve any sensitive information. In some cases, error-based SQL injection alone is enough for an attacker to enumerate an entire database.

## Approach
So, as seen from the definition, we actually want to create a SQL error, displaying some sensitive content. As you might have seen in the previous example, we were able to get the database type by creating an error. Now we need to go beyond that and get something more interesting.

## Manual Exploitation
Using the example from before of:

	http://10.10.173.170/sqli-labs/Less-1/index.php?id=

We know that putting in an ID value, e.g. 1 gets us a Login name and password. Let's think of that in terms of SQL language. This id parameter is attached to a certain username (login name) and password which are being chosen from the database.

Lets try and convert that to SQL syntax:

	select login_name, password from table where id=

See, just by looking at the basic output, we were able to retrieve some common SQL patterns. Now, as a part of error-based SQLi, we can exploit it.

Now try inputting 1' as the id parameter and let's analyze the error closely.

	syntax to use near ''1'' LIMIT 0,1' at line 1

We can see that the web app is producing an error due to four single quotes around the 1
As in Unit 3, we can understand that error as 'one extra' single quote which cannot be recognized by the system.

What do I mean by that? Well, in this case when the application is taking the id input, it is putting it between two single quotes like so:

	' 1 '


But when we input 1' we produce this scenario:

	' 1' '

We are, in a way, closing the first single quote, at the same time creating the third. This, later on, makes the system automatically close the third one, displaying syntax to use near ''1''error.

Well, if we can close the single quotes that easily, it means that we are able to break out of the query and provide custom commands.

If you try putting AND 1=1 (which corresponds to true) after the single quote, we still get this error.
In order to get around that, we need to fix the query back. It's done by commenting out the rest by using -- and providing + as the blank space at the end. The query should end up looking like this:

	10.10.173.170/sqli-labs/Less-1/index.php?id=1' AND 1=1 --+

Entering this gives us...nothing. Well in this situation that's GREAT! Because it means that we've used the errors to generate an SQL command that will run, with custom commands and not error out!

We can try this automatically by fuzzing the URL with many different payloads, which you can find in the payloads section. 
