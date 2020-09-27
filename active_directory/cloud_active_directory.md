# Active Directory in the Cloud

## The Role of AD in the Cloud
Recently there has been a shift in Active Directory pushing the companies to cloud networks for their companies. The most notable AD cloud provider is Azure AD. Its default settings are much more secure than an on-premise physical Active Directory network; however, the cloud AD may still have vulnerabilities in it.

## Azure AD Overview
Azure acts as the middle man between your physical Active Directory and your users' sign on. This allows for a more secure transaction between domains, making a lot of Active Directory attacks ineffective.

## Cloud Security Overview
The best way to show you how the cloud takes security precautions past what is already provided with a physical network is to show you a comparison with a cloud Active Directory environment:

| Windows Server AD 	| Azure AD 		|
| :-------------------- | --------------------: |
| LDAP		    	| Rest APIs		|
| NTLM		    	| OAuth/SAML		|
| Kerberos	    	| OpenID		|
| OU Tree		| Flat Structure	|
| Domains and Forests	| Tenants		|
| Trusts		| Guests		|

