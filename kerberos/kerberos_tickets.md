# Kerberos Tickets 

## Types of ticket
The main ticket that you will see is a ticket-granting ticket, these can come in various forms, such as:

* A .kirbi for Rubeus 
* A .ccache for Impacket

The most common ticket that you will see is a .kirbi ticket. A ticket is typically base64 encoded and can be used for various attacks. 

The ticket-granting ticket is only used with the KDC in order to get service tickets. Once you give the TGT to the server, it will then get user details such as:

* User details
* Session key

Before then encrypting the ticket with the service account's NTLM hash. 

Your TGT then gives the encrypted timestamp, session key, and encrypted TGT. The KDC will then authenticate the TGT and give back a service ticket that can be used to access the requested service. 

A normal TGT will only work with that given service account that is connected to it. However a KRBTGT allows you to get any service ticket that you want, allowing you to access everything on the domain. 


