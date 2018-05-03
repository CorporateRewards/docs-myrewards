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
  "consented" : "false",
  "marketing_consented" : "true",
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
  "id": 123,
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
  "consented" : "false",
  "marketing_consented" : "true",
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
mobile | `string` | Potentially required - see programme data requirements, if required, must be unique - if supplied must be international format (starting with a '+' followed by international dialing code - UK is 44 - followed by at least 8 numeric characters)
tsandcs | `boolean` | Required
user_group_id | `integer` | optional, will default to programme's default user_group, if not provided
registration_answers_attributes | `array` | array of hashes that contain a registration_question_id and an answer. Some or all of the registration questions may require answers. See registration_questions endpoint documentation
consented | `boolean` | Not required if programme access type is pre_registration with additional details, or SSO or if the programme doesn't have an active privacy policy.
marketing_consented | `boolean` | Can be true or false, not required if programme access type is pre_registration with additional details, or SSO or if the programme doesn't have an active privacy policy.

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
  "id": 123,
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


