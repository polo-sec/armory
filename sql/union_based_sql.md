# Union Based SQLi

## Definition

Union-based SQLi is a SQL injection technique that leverages the UNION SQL operator to combine the results of two or more SELECT statements into a single result which is then returned as part of the HTTP response.

## Testing for Union Based SQLi

The UNION keyword lets you execute one or more additional SELECT queries and append the results to the original query. For example:

	SELECT 1, 2 FROM usernames UNION SELECT 1, 2 FROM passwords

This SQL query will return a single result taken from 2 columns: first and second positions from usernames and passwords.

UNION SQLi attack consists of 3 stages:

1. You need to determine the number of columns you can retrieve.
2. You make sure that the columns you found are in a suitable format
3. Attack and get some interesting data.

## Determining the number of columns required in an SQLi Union Attack

There's onm really easy way to detect one. 

The first one involves injecting a series of ORDER BY queries until an error occurs. For example:

	' ORDER BY 1--
	' ORDER BY 2--
	' ORDER BY 3--

And so on until an error occurs. The last value before the query errors out would be the number of columns. 

## Finding columns with a useful data type in an SQL injection UNION attack

Generally, the interesting data that you want to retrieve will be in string form. Having already determined the number of required columns, (for example 4) you can probe each column to test whether it can hold string data by replacing one of the UNION SELECT payloads with a string value. In case of 4 you would submit:

For example:

	' UNION SELECT 'a',NULL,NULL,NULL--
	' UNION SELECT NULL,'a',NULL,NULL--
	' UNION SELECT NULL,NULL,'a',NULL--
	' UNION SELECT NULL,NULL,NULL,'a'--

Here, no encountering an error would indicate that there's data that could be useful.

## Using an SQL injection UNION attack to retrieve interesting data

When you have determined the number of columns and found which columns can hold string data, you can finally start retrieving interesting data.

Suppose that:

* The first two steps showed exactly two existing columns with the useful datatype. 
* The database contains a table called users with the columns username and password.
    (This can be figured out by using the boolean technique from Unit 6)

In this situation, you can retrieve the contents of the user's table by submitting the input:

	' UNION SELECT username, password FROM users --






