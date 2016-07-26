---
title: MyRewards - API Reference

language_tabs:
- http

search: true
---

# Introduction
Welcome to the MyRewards API documentation.

The first thing you will have to find out is the correct API endpoint to use for
the right environment.

- **Production:** [https://my-rewards.co.uk](https://my-rewards.co.uk)
- **Staging:** [http://staging.my-rewards.co.uk](http://staging.my-rewards.co.uk)

A programme can have one or more API keys, each of which will be granted
permission to access different functionality from the API. As a standard, we use
RESTful json endpoints that will accept either HTML/HTTP form data or json data,
HTML/HTTP is preferred.

# Authentication

In order to use our API endpoints, you will need to have an API key created and
for this key to be granted the relevant permissions. To authenticate requests we
require you to pass us this key in the form of an HTTP header called
`Authorization` with the value of `Token token=YOURAPIKEYHERE`.

<aside class="warning">You must set the <strong>Authorization</strong> as detailed above</aside>

# RegistrationQuestions

## List RegistrationQuestions

A simple endpoint will be created to fetch registration_questions for this
programme (Again scoped by API key). This is potentially optional as a list of
registration_question_ids could be provided, although this list will have to be
managed and maintained carefully. Should required fields be added to this list
it will require development on the client side of the API unless this list can
be dynamically consulted via the api.

``` http
GET /api/v2/registration_questions HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id" : 1234,
    "label" : "text",
    "mandatory" : "false",
    "field_type" : "radio",
    "options" : "text_1 text_2 text_3",
    "field_name" : "field_lavel",
    "free_text" : "false"
  }
]
```

### HTTP Request

`GET /api/v2/registration_questions`

### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | `integer` | registration question identifier
label | `string` | label displayed on the form to the end user
manadatory | `boolean` | boolean if this question is manadatory for registration
field_type | `string` | options: [check_box, date_select, radio, select, text, user_group]
options | `string` | options set for a choice question for check_box, select, or radio
field_name | `string` | the actual field name
free_text | `boolean` | ???

# Users

## Create User

In order to create a user account on the MyRewards 2.0 platform there is often
some information about the user we are creating that needs to be known before
the account can be successfully created.

Firstly, the user group that the user will be created as a member of must be
known, we provide an endpoint to query the usergroups for your programme and if
necessary to reconstruct the hierarchy for the usergroups see the usergroups
section.

Additionally, user accounts can have extra data required over and above the
minimal default fields for a user account. Typically, these take the form of
employee data, membership number etc and can be defined as part of your
programme. These extra data are called registration_questions, for more
information please see the registration_questions section.

Once desired usergroup and any additional registration_questions (and answers)
for a user are known, a registration request can be processed.

``` http
POST /api/v2/users HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "username" : "bwayne",
  "email" : "bruce@wayneinc.com",
  "title" : "Mr",
  "firstname" : "Bruce",
  "lastname" : "Wayne",
  "company" : "Wayne Inc",
  "job_title" : "CEO",
  "address_1" : "Wayne Manor",
  "address_2" : "1007 Mountain Drive",
  "town" : "Gotham",
  "postcode" : "G1 1BM",
  "county" : "New Jersey",
  "country" : "United States",
  "date_of_birth" : "1980-02-19",
  "telephone" : "07876543210",
  "mobile" : "07765432101",
  "password" : "IAmBatman",
  "tsandcs" : "true",
  "user_group_id" : "10",
  "registration_questions" : { }
}
```

``` http
HTTP/1.1 201 CREATED
Content-Type: Application/json
```

### HTTP Request

`POST /api/v2/users`

### Parameters

Parameters | Type | Info
---------- | ---- | ----
username | `string` | must be unique to the programme.
email | `string` | valid email address and unique to the programme.
title | `string` | salutation (Mr, Mrs, Ms, etc) no strict validation.
firstname | `string` |
lastname | `string` |
company | `string` |
job_title | `string` |
address_1 | `string` |
address_2 | `string` | optional
town | `string` |
postcode | `string` |
county | `string` | optional
country | `string` | optional
date_of_birth | `date` | must be provided in reverse date format `YYYY-MM-DD`, optional
telephone | `string` | optional
mobile | `string` | optional
password | `string` | minimum length 6 characters, plaintext
tsandcs | `boolean` |
user_group_id | `integer` | optional, will default to programme's default user_group, if not provided
registration_questions | `hash` | registration_question_ids and answers in a hash object

# UserGroups

## List UserGroups

A simple endpoint to fetch a list of usergroups used for this programme. Only
accessible if the key has been granted access to users. Returns an array of
user_groups as a flat list, each usergroup will indicate it's parent id
enabling the client end of the API to re-construct the usergroup hierarchy. This
would be required if a registration_question is linked to a tier of user_groups
with a tier being a vertical 'slice' down the hierarchy

``` http
GET /api/v2/user_group HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id" : "1",
    "name" : "dc commics",
    "parent_id" :  null,
    "default" : "false",
    "position" : "1"
  },
  {
    "id" : "2",
    "name" : "justice league",
    "parent_id" : "1",
    "default" : "true",
    "position" : "1"
  }
]
```

### HTTP Request

`GET /api/v2/user_groups`

### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | `integer` | text
name | `string` | text
parent_id | `integer` | text
default | `boolean` | text
position | `integer` | text
