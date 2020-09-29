# Kerberos 

## What is Kerberos
Kerberos is the default authentication services for Microsoft Windows domains. It's intended to be more "secure" than just using NTLM by using third party ticket authorization as well as stronger encryption. Even though NTLM has a lot more attack vectors to choose from, Kerberos still has a handful of underlying vulnerabilities just like NTLM that we can use to our advantage.

## Terminology

* Ticket Granting Ticket (TGT) - A ticket-granting ticket is an authentication ticket used to request service tickets from the Ticket Granting Service for specific resources from the domain.

* Key Distribution Center (KDC) - The Key Distribution Center is a service for issuing TGTs and service tickets that consist of the Authentication Service and the Ticket Granting Service. 

* Authentication Service (AS) - The Authentication Service issues TGTs to be used by the TGS in the domain to request access to other machines and service tickets.

* Ticket Granting Service (TGS) - The Ticket Granting Service takes the TGT and returns a ticket to a machine on the domain.

* Service Principal Name (SPN) - A Service Principal Name is an identifier given to a service instance to associate a service instance with a domain service account. Windows requires that services have a domain service account which is why a service needs an SPN set.

* KDC Long Term Secret Key (KDC LT Key) - The KDC key is based on the KRBTGT service account. It is used to encrypt the TGT and sign the PAC.

* Privilege Attribute Certificate (PAC) - The PAC holds all of the user's relevant information, it is sent along with the TGT to the KDC to be signed by the Target LT Key and the KDC LT Key in order to validate the user.

* Client Long Term Secret Key (Client LT Key) - The client key is based on the computer or service account. It is used to check the encrypted timestamp and encrypt the session key.

* Service Long Term Secret Key (Service LT Key) - The service key is based on the service account. It is used to encrypt the service portion of the service ticket and sign the PAC.

* Session Key - Issued by the KDC when a TGT is issued. The user will provide the session key to the KDC along with the TGT when requesting a service ticket.


## The AS-REQ Step in Detail:

Starts with a user requesting a Ticket Granting Ticket (TGT )from the Key Distribution Center (KDC). In order to validate the user and create a TGT, the KDC must follow these exact steps:

	1. The user encrypts a timestampted with it's NT hash and sends it to the AS. 

	2. The KDC attempts to decrypt the timestamp using the NT hash from the user

	3. If the KDC succeeds then the KDC will issue a TGT as well as a session key for the user.

## Ticket Granting Contents 

To understand how Kerberos authentication works you first need to understand what these tickets contain and how they're validated. A service ticket contains two portions: the service provided portion and the user-provided portion. I'll break it down into what each portion contains.

	* Service Portion: User Details, Session Key, Encrypts the ticket with the service account NTLM hash.
    	
	* User Portion: Validity Timestamp, Session Key, Encrypts with the TGT session key.


## Authentication Process Overview

1. AS-REQ - The client requests an Authentication Ticket or Ticket Granting Ticket (TGT).

2. AS-REP - The Key Distribution Center verifies the client and sends back an encrypted Ticket Granting Ticket (TGT) + Session Key.

3. TGS-REQ - The client sends the encrypted TGT to the Ticket Granting Server (TGS) with the service principle name (SPN) of the service that the client wants to access. 

4. TGS-REP - The Key Distribution Center verifies the TGT of the user and that the user has access to the service, then sends a valid session key for the service to the client.

5. AP-REQ - The client requests the service and sends the valid session key to prove the user has access. 

6. AP-REP - The service grants access.


