# Simple Single Sign on

Our SSO uses [SAML 2.0](https://en.wikipedia.org/wiki/SAML_2.0) to facilitate IdP initiated Single Sign On to a MyRewards Programme

In this case MyRewards 2.0 acts as a Service Provider (SP) for a given programme

The client platform is acting as an Identity Provider (IdP)

## Process flow

1. User is challenged to authenticate at the IdP side
2. User Logs in to the IdP
3. User selects access to SP
4. IdP Responds with assertion to User
5. User browser POSTs this assertion to MyRewards Programme
6. Session established on MyRewards and user is granted access

## The Assertion

Below is an example of a typical SAML assertion

```xml
<samlp:Response ID="_UNIQUE ID" Version="2.0" IssueInstant="2015-07-07T11:24:46.676007Z" Destination="https://www.myrewards.co.uk/SAML20SingleSignOn.aspx" xmlns="urn:oasis:names:tc:SAML:2.0:protocol">
 <Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity" xmlns="urn:oasis:names:tc:SAML:2.0:assertion">https://www.client-company.com</Issuer>
 <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
  <SignedInfo>
   <CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xmlexc-c14n#" />
   <SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsasha1" />
   <Reference URI="#_ UNIQUE ID">
    <Transforms>
     <Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />
     <Transform Algorithm="http://www.w3.org/2001/10/xml-excc14n#" />
    </Transforms>
    <DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />
    <DigestValue>...digestValue</DigestValue>
   </Reference>
  </SignedInfo>
  <SignatureValue>...signatureVlue</SignatureValue>
  <KeyInfo>
   <X509Data>
    <X509Certificate>......Certificate
    </X509Certificate>
   </X509Data>
  </KeyInfo>
 </Signature>
 <Status>
  <StatusCode Value="urn:oasis:names:tc:SAML:2.0:status:Success" />
 </Status>
 <Assertion Version="2.0" ID="_8dfde5d9-afb8-48d1-8733-7f51584697df" IssueInstant="2015-07-07T11:24:47.285382Z" xmlns="urn:oasis:names:tc:SAML:2.0:assertion">
  <Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity">https://www.client-company.com/</Issuer>
  <Subject>
   <NameID Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent">Principal ID</NameID>
  </Subject>
  <Conditions NotBefore="2015-07-07T11:22:47.285382Z" NotOnOrAfter="2015-07-07T11:26:47.285382Z">
   <AudienceRestriction>
    <Audience>my-rewards.co.uk</Audience>
   </AudienceRestriction>
  </Conditions>
  <AuthnStatement AuthnInstant="2010-07-07T11:24:47.285382Z">
   <AuthnContext>
    <AuthnContextClassRef>urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport</AuthnContextClassRef>
   </AuthnContext>
  </AuthnStatement>
  <AttributeStatement>
   <Attribute Name="uid" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
    <AttributeValue xmlns:q1="http://www.w3.org/2001/XMLSchema" p6:type="q1:string" xmlns:p6="http://www.w3.org/2001/XMLSchema-instance">
     CompanyNumber
    </AttributeValue>
   </Attribute>
  </AttributeStatement>
 </Assertion>
</samlp:Response>
```

The Assertion is passed via a HTTPS post to the MyRewards Assertion consumer service:

```html
<form method="post" action="https://programme-name.com/saml/consume">
 <input type="hidden" name="SAMLResponse" value="response" />
 <input type="submit" value="Submit" />
</form>
```

The value of the SAMLResponse parameter is the base64 encoding of a <samlp:Response>
element above, which is transmitted to the service provider (client-company.com) via the browser, in this case.

The assertion **must** have the following sub elements (shown with name spaces from example assetion above):

### saml:Issuer
Name of the IdP in the form of a url i.e. https://client-company.com

### ds:Signature
All SAML 2.0 Assertions are signed by default. The client company (Identity provider) will be required
to include the X509 Certificate public key in the assertion itself. MyRewards (service provider) will use this to verify the signature.

### saml:Subject
The subject NameID is always the unique identifier of the user - by default this set as transient, we require this to be persistent - this is as understood by the IdP

### saml:Conditions
This is the timeframe within which the assertion is valid - our preference is to be set to allow for 2 minutes either side to account for clockdrift between servers. MyRewards will verify the validity of an assertion with respect to these conditions after validating the signature.

Our servers are syncronized daily to Europe/London timezone - this will change with Daylight Savings time. We expect the IdP has their server clocks similarly syncronsied. The timestamp used will use Coordinanted Universal Time (UTC) and we strongly recommend adding a window of 1 hour plus 2 minutes to account for both clockdrift and Daylight Savings time.

For example, if the date time was Tuesday the 9th of October, 2018 15:09 (BST) then we would expect to see the Conditions element look like:
<Conditions NotBefore="2018-10-09T14:07:47.285382Z" NotOnOrAfter="2018-10-09T16:11:47.285382Z">

### saml:AttributeStatement
The attribute statement is a list of name/value pairs conveying information about the user themselves. We only use one attribute with a name of uid and the value will be one of:
* users email address - as recorded on MyRewards Programme
* username - as recorded on MyRewards Programme
* unique identifier/primary key for the user as recorded in MyRewards Programme

Which value is used will be determined by Programme configuration

## Next steps

Corporate Rewards will require the following information to set up SAML SSO on the MyRewards
system
* URL of the identify provider
* Thumbprint of x509 certificate – this can be extracted from the public key
* URL access redirect
* Failed log in redirect (if not included in the assertion)
* User identifier

In response, Corporate Rewards will provide a metadata file back to the IdP - this can often be useful for automatically configuring some IdP systems such as Active Directory Federated Services

## Further information
For further information on SAML2.0 please go to the official SAML2.0 websites:
http://www.oasis-open.org/home/index.php
http://saml.xml.org
