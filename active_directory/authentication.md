# AD Authentication / Kerberos

## Domain Authentication Overview 
The most important part of Active Directory -- as well as the most vulnerable part of Active Directory -- is the authentication protocols set in place.

## Authentication Types
There are two main types of authentication in place for Active Directory: NTLM and Kerberos.

* Kerberos - The default authentication service for Active Directory uses ticket-granting tickets and service tickets to authenticate users and give users access to other resources across the domain.

* NTLM - default Windows authentication protocol uses an encrypted challenge/response protocol

The Active Directory domain services are the main access point for attackers and contain some of the most vulnerable protocols for Active Directory.
