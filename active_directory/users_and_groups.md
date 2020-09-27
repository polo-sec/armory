# AD Users and Groups

## Defaults
The users and groups that are inside of an Active Directory are up to you; when you create a domain controller it comes with default groups and two default users: Administrator and guest. It is up to you to create new users and create new groups to add users to

## Users Overview
Users are the core to Active Directory; without users why have Active Directory in the first place? There are four main types of users you'll find in an Active Directory network; however, there can be more depending on how a company manages the permissions of its users. The four types of users are:

1. Domain Admins - This is the big boss: they control the domains and are the only ones with access to the domain controller.

2. Service Accounts (Can be Domain Admins) - These are for the most part never used except for service maintenance, they are required by Windows for services such as SQL to pair a service with a service account.

3. Local Administrators - These users can make changes to local machines as an administrator and may even be able to control other normal users, but they cannot access the domain controller

4. Domain Users - These are your everyday users. They can log in on the machines they have the authorization to access and may have local administrator rights to machines depending on the organization.

## Groups Overview
Groups make it easier to give permissions to users and objects by organizing them into groups with specified permissions. There are two overarching types of Active Directory groups:

1. Security Groups - These groups are used to specify permissions for a large number of users

2. Distribution Groups - These groups are used to specify email distribution lists. As an attacker these groups are less beneficial to us but can still be beneficial in enumeration

## Default Security Groups

* Domain Controllers - All domain controllers in the domain
* Domain Guests - All domain guests
* Domain Users - All domain users
* Domain Computers - All workstations and servers joined to the domain
* Domain Admins - Designated administrators of the domain
* Enterprise Admins - Designated administrators of the enterprise
* Schema Admins - Designated administrators of the schema
* DNS Admins - DNS Administrators Group
* DNS Update Proxy - DNS clients who are permitted to perform dynamic updates on behalf of some other clients (such as DHCP servers).
* Allowed RODC Password Replication Group - Members in this group can have their passwords replicated to all read-only domain controllers in the domain
* Group Policy Creator Owners - Members in this group can modify group policy for the domain
* Denied RODC Password Replication Group - Members in this group cannot have their passwords replicated to any read-only domain controllers in the domain
* Protected Users - Members of this group are afforded additional protections against authentication security threats. See http://go.microsoft.com/fwlink/?LinkId=298939 for more information.
* Cert Publishers - Members of this group are permitted to publish certificates to the directory
* Read-Only Domain Controllers - Members of this group are Read-Only Domain Controllers in the domain
* Enterprise Read-Only Domain Controllers - Members of this group are Read-Only Domain Controllers in the enterprise
* Key Admins - Members of this group can perform administrative actions on key objects within the domain.
* Enterprise Key Admins - Members of this group can perform administrative actions on key objects within the forest.
* Cloneable Domain Controllers - Members of this group that are domain controllers may be cloned.
* RAS and IAS Servers - Servers in this group can access remote access properties of users


