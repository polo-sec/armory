# What is SQLi?
A SQL injection (SQLi) attack consists of the injection of a SQL query to the remote web application. A successful SQL injection exploit can read sensitive data from the database (usernames & passwords), modify database data (Add/Delete), execute administration operations on the database (such as shutdown the database), and in some cases execute commands on the operating system.

## SQL Commands
In any case, in the SQL Injection attack, we mainly use only 4 commands: SELECT, FROM, WHERE, and UNION.

*SQL Command 	Description*
SELECT 		Used to select data from a database.
FROM 		Used to specify which table to select or delete data from.
WHERE 		Used to extract only those records that fulfil a specified condition.
UNION 		Used to combine the result-set of two or more SELECT statements.

It is important to mention that 1=1 in SQL stands for True

*Most commonly used comments for SQLi payloads:*

--+ // 

## How does SQLi Work?

SQLi is carried out through abusing a PHP GET parameter (for example ?username=, or ?id=) in the URL of a vulnerable web page. These are usually located in the search fields and login pages, so as a penetration tester, you need to note those down.

Here's an example of a username input field written in PHP:

<?php $username = $_GET['username']; $result = mysql_query("SELECT * FROM users WHERE username='$username'"); ?>

After a variable username was inputted in the code, PHP automatically uses SQL to select all users with the provided username. Exactly this fact can be abused by an attacker.

Let's say a malicious user provides a quotation mark (') as the username input. Then the SQL code will look like this:

SELECT * FROM users WHERE username='''

As you can see, that mark creates a third one and generates an error since the username should only be provided with two. Exactly this error is used to exploit the SQL injection.

Generally speaking, SQL injection is an attack in which your goal is to break SQL code execution logic, inject your own, and then 'fix' the broken part by adding comments at the end.

## Login Bypass with SQL Injection
One of the most powerful applications of SQL injection is definitely login bypassing. It allows an attacker to get into ANY account as long as they know either username or password to it (most commonly you'll only know username).

First, let's find out the reason behind the possibility to do so. Say, our login application uses PHP to check if username and password match the database with following SQL query:

SELECT username,password FROM users WHERE username='$username' and password='$password'

As you see here, the query is using inputted username and password to validate it with the database.

What happens if we input ' or true -- username field there? This will turn the above query into this:

SELECT username,password FROM users WHERE username='' or true -- and password=''

The -- in this case has commented out the password checking part, making the application forget to check if the password was correct. This trick allows you to log in to any account by just putting a username and payload right after it.

Note that some websites can use a different SQL query, such as:

SELECT username,pass FROM users WHERE username=('$username') and password=('$password')

In this case, you'll have to add a single bracket to your payload like so: ') or true– to make it work.

## Blind SQLi
In some cases, developers become smart enough to mitigate SQL Injection by restricting an application from displaying any error. Happily, this does not mean we cannot perform the attack. Blind SQL Injection relies on changes in a web application, during the attack. In other words, an error in SQL query will be noticeable in some other form (i.e changed content or other).

Since in this situation we can only see if an error was produced or not, blind SQLi is carried out through asking 'Yes' or 'No' questions to the database (Error = 'No', No Error = 'Yes').

Through that system, an attacker can guess the database name, read columns and etc. Blind SQLi will take more time than other types but can be the most common one in the wild.

For asking the questions, you can use SUBSTR() SQL function. It extracts a substring from a string and allows us to compare the substring to a custom ASCII character.

substr((select database()),1,1)) = 115 

The above code is asking the database if its name's first letter is equal to 155 ('s' in ASCII table).

Now put this into a payload:

?id=1' AND (ascii(substr((select database()),1,1))) = 115 --+


The payload is the question. If the application does not produce any changes, then the answer is 'Yes' (the database's first letter is 's'). Any error or change = 'No'.

## Union SQLi

UNION SQLi is mainly used for fast database enumeration, as the UNION operator allows you to combine results of multiple SELECT statements at a time.

UNION SQLi attack consists of 3 stages:

1. Finding the number of columns
2. Checking if the columns are suitable
3. Attack and get some interesting data.

### Step One
There are exactly two ways to detect the number of columns:

1. The first one involves injecting a series of ORDER BY queries until an error occurs. (The last value before the error would indicate the number of columns.) For example:
	
	' ORDER BY 1-- ' ORDER BY 2-- ' ORDER BY 3-- # and so on until an error occurs 

2. The second one (most common and effective), would involve submitting a series of UNION SELECT payloads with a number of NULL values (No error = number of NULL matches the number of columns):

	' UNION SELECT NULL-- ' UNION SELECT NULL,NULL-- ' UNION SELECT NULL,NULL,NULL-- # until the error occurs 

### Step Two
Finding columns with a useful data type in an SQL injection UNION attack.

Generally, the interesting data that you want to retrieve will be in string form. Having already determined the number of required columns, (for example 4) you can probe each column to test whether it can hold string data by replacing one of the UNION SELECT payloads with a string value. In case of 4 you would submit:

	' UNION SELECT 'a',NULL,NULL,NULL-- ' UNION SELECT NULL,'a',NULL,NULL-- ' UNION SELECT NULL,NULL,'a',NULL-- ' UNION SELECT NULL,NULL,NULL,'a'-- 

No error = data type is useful for us (string).

### Step Three
When you have determined the number of columns and found which columns can hold string data, you can finally start retrieving interesting data. Suppose that:


* The first two steps showed exactly two existing columns with useful datatype.
* The database contains a table called users with the columns username and password.

In this situation, you can retrieve the contents of the user's table by submitting the input:

' UNION SELECT username, password FROM users --

