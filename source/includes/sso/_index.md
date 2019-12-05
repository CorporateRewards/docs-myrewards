# Simple Single Sign on

Our SSO uses [SAML 2.0](https://en.wikipedia.org/wiki/SAML_2.0) to facilitate IdP-initiated Single Sign On to a MyRewards Programme

In this case MyRewards acts as a Service Provider (SP) for a given programme

The client platform is acting as an Identity Provider (IdP)

## Process flow

1. User is challenged to authenticate at the IdP side
2. User Logs in to the IdP
3. User selects access to SP
4. IdP Responds with assertion to User
5. User browser `POST`s this assertion to the MyRewards programme
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
  <SignatureValue>...signatureValue</SignatureValue>
  <KeyInfo>
   <X509Data>
    <X509Certificate>......Certificate</X509Certificate>
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

The value of the `SAMLResponse` parameter is the Base64 encoding of a `<samlp:Response>`
element above, which is transmitted to the service provider (`client-company.com`) via the browser, in this case.

The assertion **must** have the following sub-elements (shown with namespaces from example assertion above):

### saml:Issuer
Name of the IdP in the form of a url e.g. `https://client-company.com`

### ds:Signature
All SAML 2.0 Assertions are signed by default. The client company (identity provider) will be required
to include the X.509 Certificate public key in the assertion itself. MyRewards (service provider) will use this to verify the signature.

### saml:Subject
The subject `<NameID>` is always the unique identifier of the user - by default this set as transient, we require this to be persistent - this is as understood by the IdP

### saml:Conditions
This is the timeframe within which the assertion is valid - our preference is to be set to allow for 2 minutes either side to account for clock drift between servers. MyRewards will verify the validity of an assertion with respect to these conditions after validating the signature.

Our servers are synchronised daily to Europe/London timezone - this will change with Daylight Saving Time. We expect the IdP has their server clocks similarly synchronised. The timestamp used will be in Coordinated Universal Time (UTC) and we strongly recommend adding a window of 1 hour plus 2 minutes to account for both clock drift and Daylight Saving Time.

For example, if the date/time was `Tuesday 9th October, 2018 15:09 (BST)` then we would expect to see the `<Conditions>` element look like:

```xml
<Conditions NotBefore="2018-10-09T14:07:47.285382Z" NotOnOrAfter="2018-10-09T16:11:47.285382Z">
```

### saml:AttributeStatement
The attribute statement is a list of name/value pairs conveying information about the user themselves. We only use one `<Attribute>` with a `Name` of `uid` and the value will be one of:

* user's email address - as recorded on MyRewards Programme
* username - as recorded on MyRewards Programme
* unique identifier/primary key for the user as recorded in MyRewards Programme

Which value is used will be determined by the configuration on the programme.

## Next steps

The following information is required to set up SAML SSO on the MyRewards
system

* URL of the identify provider
* Fingerprint of X.509 certificate – this can be extracted from the public key
* URL access redirect
* Failed log in redirect (if not included in the assertion)
* User identifier (id, email or username)

In response, you will be provided with a metadata file back to the IdP - this can often be useful for automatically configuring some IdP systems such as Active Directory Federated Services

## Further information
For further information on SAML 2.0 please go to the official SAML 2.0 websites:

- [http://www.oasis-open.org/home/index.php](http://www.oasis-open.org/home/index.php)
- [http://saml.xml.org](http://saml.xml.org)
