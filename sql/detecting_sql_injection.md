# Detecting SQL Injection

SQL injection is carried out by entering a malicious input to hijack an SQL query. The most common example is abusing a PHP GET parameter (for example $username, or $id) in the URL of a vulnerable web page. Those are usually located in the search fields and login pages, so as a penetration tester, you need to note those down.


1. Error Based SQLi

	So, now after you got all the PHP GET parameters and login pages you can actually proceed to detecting 
	SQLi. To test this we want to cause a certain error displaying at least a small error message (which can
	even disclose some information, like a database type).

	Therefore, we could check the webpage asking for PHP validation using an "id" form by converting:
	
		http://10.10.173.170/sqli-labs/Less-1/
	To 
		http://10.10.173.170/sqli-labs/Less-1/index.php?id=1

	Knowing that this gives us interaction with the PHP get paramater, lets try and exploit it by putting 
	escape characters into our query.
		
		http://10.10.173.170/sqli-labs/Less-1/index.php?id='
	
	This returns a MySQL error:

		You have an error in your SQL syntax; check the manual that corresponds to your MySQL server
		version for the right syntax to use near '''' LIMIT 0,1' at line 1
	
	Showing two key pieces of information:
		
		Where the syntax errors: near '''' LIMIT 0,1' at line 1
		The DBMS: MySQL
	
2. Automatic Enumeration 

	We can use DSSS https://github.com/stamparm/DSSS.git to automatically check the php url for SQLi low-
	hanging fruit:

	1. python3 dsss.py -u [url/.php?id=] 
	
	This will suggest exploits for us to use 


		


