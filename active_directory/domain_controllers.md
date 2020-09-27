# Domain Controllers

## What is an AD Domain Controller? 
A domain controller is a Windows server that has the Active Directory Domain Services (AD DS) installed, and has been promoted to a domain controller in the forest.

## Why are Domain Controllers important?
Domain controllers are the center of AD-- they control the rest of the domain. The Domain Controller is responsive for:

1. Holding the AD DS data store
2. Handling authentication and authorization services
3. Replicating updates conducted by other Domain Controllers in the forest 
4. Allowing admin access to manage domain resources

## The AD DS Data Store
The AD Data Store holds the databases and the processes needed to store and managage directory information such as: Users, Groups and Services. 

* Contains the NTDS.dit - a database that contains all of the information of an Active Directory domain controller as well as password hashes for domain users
* Stored by default in %SystemRoot%\NTDS
* accessible only by the domain controller

