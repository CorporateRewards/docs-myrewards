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
- **Staging:** [https://staging.my-rewards.co.uk](https://staging.my-rewards.co.uk)

A programme can have one or more API keys, each of which will be granted
permission to access different functionality from the API. As a standard, we use
RESTful json endpoints that will accept eithey r HTML/HTTP form data or json data,
HTML/HTTP is preferred.

# Authentication

In order to use our API endpoints, you will need to have an API key created and
for this key to be granted the relevant permissions. To authenticate requests we
require you to pass us this key in the form of an HTTP header called
`Authorization` with the value set as `Token token=APIKEY` or `TOKEN
token=APIKEY:SECRETKEY`.

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
free_text | `boolean` |

# Transactions

## List User's Transactions

This endpoint is designed to list all of a user’s transactions in json format.
The points transactions will be debits and credits with a description field.

All transactions listed in the response will be ordered so as to have the most
recent transaction last in the list.

Please remember that if a user transaction is performed on the MyRewards 2.0
platform since a request is made over the api – this balance will be out of date.

On the server side a check will be made that the user_id you are requesting is

- a valid user
- it is a user for the programme that your api key is scoped to.

That is to say that you can only retrieve transactions for users of your
MyRewards Programme.

The remote_transaction_id is documented in the POST endpoint for creating
transactions, this value is optional, therefore can be `null`

``` http
GET /api/v2/users/123/transactions HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 123,
    "user_id" : 123,
    "description" : "transactions",
    "value" : 100,
    "balance" : 100,
    "transaction_type" : "programme points",
    "remote_transaction_id": "your_id_here",
    "created_at" : "date_time"
  }
]
```

### HTTP Request

`GET /api/v2/users/{user_id}/transactions`

### Attributes

Parameters | Type | Info
---------- | ---- | ----
id | `integer` | id of this transaction
user_id | `integer` | user id of the user this transaction belongs
description | `string` | transaction description
value | `integer` | can be positive or negative. value of points on the transaction
balance | `integer` | users running balance, at the time of the transaction
transaction_type | `string` | indicates the event which caused the transaction
created_at | `string` |

## Show User's Last Transaction

This endpoint is designed to show the latest transaction for the given user in
json format. You can use this endpoint to find the user's current balance.

Please remember that if a user transaction is performed on the MyRewards 2.0
platform since a request is made over the api – this balance will be out of date.

On the server side a check will be made that the user\_id you are requesting is

- a valid user
- it is a user for the programme that your api key is scoped to.

That is to say that you can only retrieve the last transaction for users of your
MyRewards Programme.

The remote_transaction_id is documented in the POST endpoint for creating
transactions, this value is optional, therefore can be `null`

``` http
GET /api/v2/users/123/transactions/last HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 123,
  "user_id" : 123,
  "description" : "transactions",
  "value" : 100,
  "balance" : 100,
  "transaction_type" : "programme points",
  "remote_transaction_id": "your_id_here",
  "created_at" : "date_time"
}
```

### HTTP Request

`GET /api/v2/users/{user_id}/transactions/last`

### Attributes

Parameters | Type | Info
---------- | ---- | ----
id | `integer` | id of this transaction
user_id | `integer` | user id of the user this transaction belongs
description | `string` | transaction description
value | `integer` | can be positive or negative. value of points on the transaction
balance | `integer` | users running balance, at the time of the transaction
transaction_type | `string` | indicates the event which caused the transaction
created_at | `string` | datetime indicating when this points transaction was created

## Create a Points Transaction

**Note this is 'v1' endpoint.** This endpoint is for either crediting or debiting points for a user.
This endpoint will respond with the MyRewards transaction id.
Points transactions have a type of either 'Credit' or 'Debit'.
A points transaction will also have a variety which will be one of:

Variety | Programme Points affecting? | Permitted Type
------- | --------------------------- | --------------
Programme Points | Yes | either
Points Error | Yes | either
Programme Budget | Yes | either
Redemption | No | Debit only
Person 2 Person Transfer | No | either (credit and debit must both be carried out for each user)
Order Cancelation | No | Credit only
Order Adjustment | No | either
Adjustment | Yes | either
Account Closure | Programme config dependant | Debit only

Example below shows a transaction that will credit 100 points to a user debitted from the programme balance. On the users points statement a reason of 'Employee of the month' will be shown.

``` http
POST /api/v1/users/123/transactions HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "transaction":  {
    "transaction_type": "Credit",
    "variety": "Programme Points",
    "points": 100,
    "reason": "Employee of the month"
  }
}
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 123
}
```
### HTTP Request

`POST /api/v1/users/123/transactions`

### Parameters

Parameters | Type | Info
---------- | ---- | ----
transaction_type | `string` | one of 'Credit' or 'Debit'
variety | `string` | Required - see above table and ensure validity with transaction_type
points | `integer` | Required - always greater than 0
reason | `string` | Required - free text up to 250 characters to describe transaction - appears on user points statement
remote_transaction_id | `string` | Optional - a value that can be used to identify this transaction by the client *Caution - there is no validation or contraints for data supplied under this key/field. This is left to the client system to enforce*

### Error responses

Anything other than a 200 will mean that the transaction has failed to go through. It may or may not be appropriate to show only a generic message to indicate failure depending on the use case or level of automation. In either case it is recommended to log the error code and any body/message

-  401 invalid key
-  402 User does not have enough points
-  412 Programme does not have enough points
-  204 User not found
-  406 Invalid Transaction
-  500 Server Error

# Users

In order to identify users, a programme will expect to use either username, email or mobile as a unique key to authenticate user with. As a consumer of this service, it is mandatory to supply a value for this field. Furthermore there will be other fields that have been declared mandatory for your programme and user creation (POST) will fail if these values are not populated or provided.

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

Telephone and mobile number fields must be supplied in international format, meaning starting with a '+' followed by the international country code (I.e. the UK is 44) followed by at least 8 numeric characters.

Answers to the registration questions are provided in an array of objects, nested
under the key `registration_answers_attributes`. The nested objects themselves must
have the keys `registration_question_id` and `answer`.

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
  "telephone" : "+447876543210",
  "mobile" : "+447765432101",
  "tsandcs" : "true",
  "consented" : "true",
  "user_group_id" : "10",
  "registration_answers_attributes" : [
    {
      "registration_question_id" : "2",
      "answer" : "Because I'm Batman"
    },
    {
      "registration_question_id" : "16",
      "answer" : "Alfred"
    }
  ]
}
```

``` http
HTTP/1.1 201 CREATED
Content-Type: Application/json

{
  "id": 123
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
  "telephone" : "+447876543210",
  "mobile" : "+447765432101",
  "tsandcs" : "true",
  "consented" : "true",
  "user_group_id" : "10",
  "registration_answers_attributes" : [
    {
      "registration_question_id" : "2",
      "answer" : "Because I'm Batman"
    },
    {
      "registration_question_id" : "16",
      "answer" : "Alfred"
    }
  ]
}
```

### HTTP Request

`POST /api/v2/users`

### Parameters

Parameters | Type | Info
---------- | ---- | ----
username | `string` | may be required, see user identification above, must be unique to the programme if required
email | `string` | valid email address and may be required, see user identification above, must be unique to the programme if required
title | `string` | salutation (Mr, Mrs, Ms, etc) no strict validation.
firstname | `string` | Required
lastname | `string` | Required
company | `string` | Potentially required - see programme data requirements
job_title | `string` | Potentially required - see programme data requirements
address_1 | `string` | Potentially required - see programme data requirements
address_2 | `string` | optional
town | `string` | Potentially required - see programme data requirements
postcode | `string` | Potentially required - see programme data requirements
county | `string` | Potentially required - see programme data requirements
country | `string` | Potentially required - see programme data requirements
date_of_birth | `date` | must be provided in reverse date format `YYYY-MM-DD`, Potentially required - see programme data requirements
telephone | `string` | Potentially required - see programme data requirements - if supplied must be international format (starting with a '+' followed by international dialing code - UK is 44 - followed by at least 8 numeric characters)
mobile | `string` | Potentially required - see programme data requirements - if supplied must be international format (starting with a '+' followed by international dialing code - UK is 44 - followed by at least 8 numeric characters)
tsandcs | `boolean` | Required
user_group_id | `integer` | optional, will default to programme's default user_group, if not provided
registration_answers_attributes | `array` | array of hashes that contain a registration_question_id and an answer. Some or all of the registration questions may require answers. See registration_questions endpoint documentation
consented | `boolean` | Not required if programme access type is pre_registration with additional details, or SSO or if the programme doesn't have an active privacy policy. 

## Update User

The update user api is available to update user information. This uses the same
params as the create user api above.

``` http
PUT /api/v2/users/123 HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "firstname" : "Joker",
  "lastname" : "Hahaha"
}
```

``` http
HTTP/1.1 200 OK
Content-Type: Application/json

{
  "id": 123
  "username" : "bwayne",
  "email" : "bruce@wayneinc.com",
  "title" : "Mr",
  "firstname" : "Joker",
  "lastname" : "Hahaha",
  "company" : "Wayne Inc",
  "job_title" : "CEO",
  "address_1" : "Wayne Manor",
  "address_2" : "1007 Mountain Drive",
  "town" : "Gotham",
  "postcode" : "G1 1BM",
  "county" : "New Jersey",
  "country" : "United States",
  "date_of_birth" : "1980-02-19",
  "telephone" : "+447876543210",
  "mobile" : "+447765432101",
  "tsandcs" : "true",
  "user_group_id" : "10",
  "registration_answers_attributes" : [
    {
      "registration_question_id" : "2",
      "answer" : "Because I'm Batman"
    },
    {
      "registration_question_id" : "16",
      "answer" : "Alfred"
    }
  ]
}
```

### HTTP Request
`PUT /api/v2/users/{user_id}`

`PATCH /api/v2/users/{user_id}`

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
id | `integer` | user_group id
name | `string` | user_group name
parent_id | `integer` | parent user_group id
default | `boolean` | indicates if this user_group is the default group for the programme
position | `integer` | position under the parent user_group, used for ordering


# Performance - Data Fields

## List Data Fields for a Programme

A simple endpoint to fetch a list of the data fields for a performance module
enabled programme. Returns an array of data fields as a flat list.

``` http
GET /api/v2/performance/data_fields HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 196,
    "name": "Superpower",
    "mandatory": true,
    "field_type": "list_values",
    "answers": "Super-strengh\r\nFlight\r\nOther",
    "created_at": "2016-04-14T13:34:03.000+01:00",
    "updated_at": "2016-04-14T13:34:03.000+01:00",
    "position": 1,
    "selector": "superpower"
  },
  {
    "id": 197,
    "name": "Hero name",
    "mandatory": true,
    "field_type": "free_text",
    "answers": null,
    "created_at": "2016-04-14T13:35:03.000+01:00",
    "updated_at": "2016-04-14T13:35:03.000+01:00",
    "position": 2,
    "selector": "hero-name"
  }
]
```

### HTTP Request

`GET /api/v2/performance/data_fields`

### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | `integer` | data\_field id
name | `string` | data\_field name
mandatory | `boolean` | Whether this field is required
field\_type | `string` | One of: 'free\_text', 'numeric', 'list\_values', 'date'
answers | `string` | A '\r\n' separated list of allowed answers
created\_at | `date` | The time at which this field was created
updated\_at | `date` | The time at which this field was last updated
position | `integer` | Position of the data field within the form
selector | `selector` | The selector given to this data field on the form

## List Data Fields for a Promotion

A simple endpoint to fetch a list of the data fields for a performance module
enabled programme scoped to a Promotion. Returns an array of data fields as a flat list.

``` http
GET /api/v2/performance/promotions/1/data_fields HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 196,
    "promotion_id": 1,
    "name": "Superpower",
    "mandatory": true,
    "field_type": "list_values",
    "answers": "Super-strengh\r\nFlight\r\nOther",
    "created_at": "2016-04-14T13:34:03.000+01:00",
    "updated_at": "2016-04-14T13:34:03.000+01:00",
    "position": 1,
    "selector": "superpower"
  },
  {
    "id": 197,
    "promotion_id": 1,
    "name": "Hero name",
    "mandatory": true,
    "field_type": "free_text",
    "answers": null,
    "created_at": "2016-04-14T13:35:03.000+01:00",
    "updated_at": "2016-04-14T13:35:03.000+01:00",
    "position": 2,
    "selector": "hero-name"
  }
]
```

### HTTP Request

`GET /api/v2/performance/promotions/1/data_fields`

### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | `integer` | data\_field id
promotion_id | `integer` | promotion id
name | `string` | data\_field name
mandatory | `boolean` | Whether this field is required
field\_type | `string` | One of: 'free\_text', 'numeric', 'list\_values', 'date'
answers | `string` | A '\r\n' separated list of allowed answers
created\_at | `date` | The time at which this field was created
updated\_at | `date` | The time at which this field was last updated
position | `integer` | Position of the data field within the form
selector | `selector` | The selector given to this data field on the form

# Performance - Sales Data

## Create Sales Data

Endpoint to create claims against promotions and performance products.

If the creation of one claim fails, either because it is invalid or because the
programme does not have enough points, all of the claims will fail to create.

``` http
POST /api/v2/performance/data HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "data": [
    {
      "date_of_sale": "2016-10-01",
      "product_or_activity": "Booking type 1",
      "quantity": 1,
      "username": "user@example.com",
      "Custom Data Field Date": "2016-10-01",
      "Custom Data Field Text": "DV1"
    }
  ]
}
```

``` http
HTTP/1.1 201 CREATED
```

### HTTP Request

`POST /api/v2/performance/data`

### Attributes

Attribute | Type | Info
--------- | ---- | ----
date\_of\_sale | `date` | The date when this piece of data was created
product\_or\_activity | `string` | The SKU for the performance product to claim against
quantity | `integer` | The quantity of products sold
username | `string` | The username or email for the user to assign points to
user\_id | `user_id` | The MyRewards user ID for the user to assign points to

You will also need to provide any custom data fields as extra keys for
each piece of claim data. For instance, if 'Venue Code' was a mandatory data field
you would also need to send that for each claim.



# Performance - Sales Data - Specifying a Promotion

## Create Sales Data

Endpoint to create claims against specific promotion.

``` http
POST /api/v2/performance/data HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "promotion_id": 1,
  "data": [
    {
      "date_of_sale": "2016-10-01",
      "product_or_activity": "Booking type 1",
      "quantity": 1,
      "username": "user@example.com",
      "Custom Data Field Date": "2016-10-01",
      "Custom Data Field Text": "DV1"
    }
  ]
}
```

``` http
HTTP/1.1 201 CREATED
```

### HTTP Request

`POST /api/v2/performance/promotions/1/data`

### Attributes

Attribute | Type | Info
--------- | ---- | ----
date\_of\_sale | `date` | The date when this piece of data was created
product\_or\_activity | `string` | The SKU for the performance product to claim against
quantity | `integer` | The quantity of products sold
username | `string` | The username or email for the user to assign points to
user\_id | `user_id` | The MyRewards user ID for the user to assign points to
promotion\_id | `integer` | The ID of a valid promotion to assign the claim to

As above you will also need to provide any custom data fields as extra keys for
each piece of claim data. For instance, if 'Venue Code' was a mandatory data field
you would also need to send that for each claim. The Promotion ID will need to
correspond to an existing & valid promotion

