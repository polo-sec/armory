# AD Domain Services + Authentication

## Overview
The Active Directory domain services are the core functions of an Active Directory network; they allow for management of the domain, security certificates, LDAPs, and much more. This is how the domain controller decides what it wants to do and what services it wants to provide for the domain.

## Domain Services
Domain Services are exactly what they sound like. They are services that the domain controller provides to the rest of the domain or tree. There is a wide range of various services that can be added to a domain controller; however, we'll only be going over the default services that come when you set up a Windows server as a domain controller. Outlined below are the default domain services:

* LDAP - Lightweight Directory Access Protocol; provides communication between applications and directory services
* Certificate Services - allows the domain controller to create, validate, and revoke public key certificates
* DNS, LLMNR, NBT-NS - Domain Name Services for identifying IP hostnames

