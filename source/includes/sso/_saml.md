<a name="simple-single-sign-on" class="legacy-link"></a>

## SAML

Our SSO can use [SAML 2.0](https://en.wikipedia.org/wiki/SAML_2.0) to facilitate IdP-initiated Single Sign On to a MyRewards Programme

In this case MyRewards acts as a Service Provider (SP) for a given programme

The client platform is acting as an Identity Provider (IdP)

### Process flow

1. User is challenged to authenticate at the IdP side
2. User Logs in to the IdP
3. User selects access to SP
4. IdP Responds with assertion to user
5. User's browser `POST`s this assertion to the MyRewards programme
6. Session established on MyRewards and user is granted access

### The Assertion

> Example SAML assertion:

```xml
<samlp:Response ID="_UNIQUE-ID" Version="2.0" IssueInstant="2020-01-01T00:00:00.000000Z" Destination="https://programme-name.com/saml/consume" xmlns="urn:oasis:names:tc:SAML:2.0:protocol">
 <!-- [1] -->
 <saml:Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity" xmlns="urn:oasis:names:tc:SAML:2.0:assertion">
  https://www.client-company.com
 </saml:Issuer>

 <!-- [2] -->
 <ds:Signature xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
  <ds:SignedInfo>
   <ds:CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xmlexc-c14n#" />
   <ds:SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsasha1" />
   <ds:Reference URI="#_UNIQUE-ID">
    <ds:Transforms>
     <ds:Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />
     <ds:Transform Algorithm="http://www.w3.org/2001/10/xml-excc14n#" />
    </ds:Transforms>
    <ds:DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />
    <ds:DigestValue>...digestValue...</ds:DigestValue>
   </ds:Reference>
  </ds:SignedInfo>
  <ds:SignatureValue>...signatureValue...</ds:SignatureValue>
  <ds:KeyInfo>
   <ds:X509Data>
    <ds:X509Certificate>...Certificate...</ds:X509Certificate>
   </ds:X509Data>
  </ds:KeyInfo>
 </ds:Signature>

 <samlp:Status>
  <samlp:StatusCode Value="urn:oasis:names:tc:SAML:2.0:status:Success" />
 </samlp:Status>

 <saml:Assertion Version="2.0" ID="_UNIQUE-ID" IssueInstant="2020-01-01T00:00:00.000000Z" xmlns="urn:oasis:names:tc:SAML:2.0:assertion">
  <!-- [1] -->
  <saml:Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity">
   https://www.client-company.com
  </saml:Issuer>

  <!-- [3] -->
  <saml:Subject>
   <saml:NameID Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent">Principal ID</saml:NameID>
  </saml:Subject>

  <!-- [4] -->
  <saml:Conditions NotBefore="2020-01-01T00:00:00.000000Z" NotOnOrAfter="2020-01-01T02:00:00.000000Z">
   <saml:AudienceRestriction>
    <saml:Audience>https://programme-name.com/saml/metadata</saml:Audience>
   </saml:AudienceRestriction>
  </saml:Conditions>

  <saml:AuthnStatement AuthnInstant="2020-01-01T00:00:00.000000Z">
   <saml:AuthnContext>
    <saml:AuthnContextClassRef>urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport</saml:AuthnContextClassRef>
   </saml:AuthnContext>
  </saml:AuthnStatement>

  <saml:AttributeStatement>
   <saml:Attribute Name="uid" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
    <saml:AttributeValue xmlns:q1="http://www.w3.org/2001/XMLSchema" p6:type="q1:string" xmlns:p6="http://www.w3.org/2001/XMLSchema-instance">
     user@client-company.com
    </saml:AttributeValue>
   </saml:Attribute>
  </saml:AttributeStatement>
 </saml:Assertion>
</samlp:Response>
```

> Example form:

```html
<form method="post" action="https://programme-name.com/saml/consume">
 <input type="hidden" name="SAMLResponse" value="AbCdefgh..." />
 <input type="submit" value="Submit" />
</form>
```

> Example conditions:

```xml
<saml:Conditions NotBefore="2020-01-01T00:00:00.000000Z" NotOnOrAfter="2020-01-01T02:00:00.000000Z">
 ...
</saml:Conditions>
```

The value of the `SAMLResponse` parameter is a Base64-encoded `<samlp:Response>` element, which is transmitted to the service provider via the browser (see "Example form" for an example).

The assertion **must** have the following sub-elements (shown with namespaces from "Example SAML assertion"):

#### `saml:Issuer` [1]

Name of the IdP in the form of a url e.g. `https://client-company.com`.

#### `ds:Signature` [2]

All SAML 2.0 Assertions are signed by default. The client company (identity provider) will be required
to include the X.509 Certificate public key in the assertion itself. MyRewards (service provider) will use this to verify the signature.

#### `saml:Subject` [3]

The subject `<saml:NameID>` is always the unique identifier of the user - by default this set as transient, we require this to be persistent - this is as understood by the IdP.

#### `saml:Conditions` [4]

This is the timeframe within which the assertion is valid - our preference is to be set to allow for 2 minutes either side to account for clock drift between servers. MyRewards will verify the validity of an assertion with respect to these conditions after validating the signature.

Our servers are synchronised daily to Europe/London timezone - this will change with Daylight Saving Time. We expect the IdP has their server clocks similarly synchronised. The timestamp used will be in Coordinated Universal Time (UTC) and we strongly recommend adding a window of 1 hour plus 2 minutes to account for both clock drift and Daylight Saving Time.

For example, if the date/time was `Tuesday 9th October, 2018 15:09 (BST)` then we would expect to see the `<saml:Conditions>` element look like the snippet shown in "Example conditions".

#### `saml:AttributeStatement`

The attribute statement is a list of name/value pairs conveying information about the user themselves. We only use one `<saml:Attribute>` with a `Name` specified by the programme configuration (`uid` by default) and expect the value to be one of:

* user's email address - as recorded on MyRewards Programme
* username - as recorded on MyRewards Programme
* unique identifier/primary key for the user as recorded in MyRewards Programme

The value we expect is determined by the programme configuration.

### Next steps

The following information is required to set up SAML SSO on the MyRewards system:

* URL of the identify provider
* Fingerprint of X.509 certificate – this can be extracted from the public key
* URL access redirect
* Failed log in redirect (if not included in the assertion)
* User identifier (id, email or username)

In response, you will be provided with a metadata file - this can often be useful for automatically configuring some IdP systems such as Active Directory Federated Services.

### Further information
For further information on SAML 2.0 please go to the official SAML 2.0 websites:

- [http://www.oasis-open.org/home/index.php](http://www.oasis-open.org/home/index.php)
- [http://saml.xml.org](http://saml.xml.org)
