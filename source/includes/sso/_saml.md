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
     john.doe@email.null
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

The value we expect, as well as the name of the attribute to check, is determined by the programme configuration.

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



## SAML User Provisioning

If your programme has been configured to allow user provisioning for SAML SSO you may pass additional attributes in your SAMLResponse to be used to create a user if they don't exist (unless your programme is configured with id as the user identifier, in which case we will never attempt to create a user and you must manage user creation in some other way) or update a user if they do exist. If your programme has not been set up to allow user provisioning, any additional attributes sent will be ignored.

<aside class="warning">WARNING: If your programme uses SAML SSO with JIT (just in time) user provisioning, you must ensure that any relevant user profile changes are made in the IDP’s data source, to prevent data from being changed on next login.</aside>


| User identifier | Create user | Update user |
|-----------------|-------------|-------------|
| id              | No          | Yes         |
| email           | Yes         | Yes         |
| username        | Yes         | Yes         |
### The SAML AttributeStatement


> Example SAML assertion with additional attributes:

```xml
<samlp:Response ID="_UNIQUE-ID" Version="2.0" IssueInstant="2020-01-01T00:00:00.000000Z" Destination="https://programme-name.com/saml/consume" xmlns="urn:oasis:names:tc:SAML:2.0:protocol">
 <saml:Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity" xmlns="urn:oasis:names:tc:SAML:2.0:assertion">
  https://www.client-company.com
 </saml:Issuer>
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
  <saml:Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity">
   https://www.client-company.com
  </saml:Issuer>
  <saml:Subject>
   <saml:NameID Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent">Principal ID</saml:NameID>
  </saml:Subject>
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
      <saml:AttributeValue xsi:type="xs:string">john.doe@email.null</saml:AttributeValue>
    </saml:Attribute>
    <saml:Attribute Name="username" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
      <saml:AttributeValue xsi:type="xs:string">john.doe</saml:AttributeValue>
    </saml:Attribute>
    <saml:Attribute Name="email" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
      <saml:AttributeValue xsi:type="xs:string">john.doe@email.null</saml:AttributeValue>
    </saml:Attribute>
    <saml:Attribute Name="firstname" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
      <saml:AttributeValue xsi:type="xs:string">John</saml:AttributeValue>
    </saml:Attribute>
    <saml:Attribute Name="lastname" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
      <saml:AttributeValue xsi:type="xs:string">Doe</saml:AttributeValue>
    </saml:Attribute>
    <saml:Attribute Name="communication_preference" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
      <saml:AttributeValue xsi:type="xs:string">sms</saml:AttributeValue>
      <saml:AttributeValue xsi:type="xs:string">email</saml:AttributeValue>
    </saml:Attribute>
    <saml:Attribute Name="registration_question_2" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
      <saml:AttributeValue xsi:type="xs:string">Working From Home</saml:AttributeValue>
    </saml:Attribute>
    <saml:Attribute Name="registration_question_16" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
      <saml:AttributeValue xsi:type="xs:string">Monday</saml:AttributeValue>
      <saml:AttributeValue xsi:type="xs:string">Wednesday</saml:AttributeValue>
      <saml:AttributeValue xsi:type="xs:string">Friday</saml:AttributeValue>
    </saml:Attribute>
    <saml:Attribute Name="chosen_locale" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
      <saml:AttributeValue xsi:type="xs:string">en</saml:AttributeValue>
    </saml:Attribute>
    <saml:Attribute Name="user_group_id" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
      <saml:AttributeValue xsi:type="xs:string">10</saml:AttributeValue>
    </saml:Attribute>
    <saml:Attribute Name="company" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
      <saml:AttributeValue xsi:type="xs:string">Org Inc</saml:AttributeValue>
    </saml:Attribute>
    <saml:Attribute Name="company_name" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
      <saml:AttributeValue xsi:type="xs:string">Org Inc</saml:AttributeValue>
    </saml:Attribute>
    <saml:Attribute Name="company_identifier" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic">
      <saml:AttributeValue xsi:type="xs:string">org-inc-01</saml:AttributeValue>
    </saml:Attribute>
  </saml:AttributeStatement>
 </saml:Assertion>
</samlp:Response>
```

Exactly which attributes we will accept depend upon the configuration of your user fields, however you must still always have a `<saml:Attribute>` with a `Name` specified by the programme configuration (`uid` by default) and expect the value to be one of:

* user's email address - as recorded on MyRewards Programme
* username - as recorded on MyRewards Programme
* unique identifier/primary key for the user as recorded in MyRewards Programme

The following standard user fields may be provided as an attributes Name value e.g. `<saml:Attribute Name="firstname">`:

* username
* email
* title
* firstname
* lastname
* job_title
* address_1
* address_2
* town
* postcode
* county
* country
* date_of_birth
* telephone
* mobile
* chosen_locale
* tsandcs
* consented
* marketing_consented
* user_group_id
* company (depending on the configuration of your programme - see below)

#### Companies

If your programme uses a free text company question, then you may just send this as "company" as above, however, if your programme has a managed list of companies, then you must provide the users company details differently and we expect both of the below:

* company_name
* company_identifier


#### Custom registration questions

If your programme has custom registration questions, you must send an attribute with a name prefixed with "registration_question_" followed by the id of the custom question to be answered. e.g. `<saml:Attribute Name="registration_question_123">` where 123 is the id of the registration question. See documentation for getting registration question id's [here](#core-registration-questions-get-all-registration-questions) or contact your MyRewards administrator if you need further assistance.

### Further notes

Whichever field has been set up as your user identifier for your integration should be sent as an attribute with the name specified as your identifier field. For example, if your programme has been set up with username as the user identifier, and uid as the identifier field, then you should send the value in `<saml:Attribute Name="uid">` and not `<saml:Attribute Name="username">`. If you do send `<saml:Attribute Name="username">` and that is your user identifier it will be ignored.
