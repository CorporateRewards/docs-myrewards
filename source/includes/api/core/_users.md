## Users 

In order to identify users, a programme will expect to use either username, email or mobile as a unique key to authenticate user with. As a consumer of this service, it is mandatory to supply a value for this field. Furthermore, there will be other fields that have been declared mandatory for your programme and user creation (POST) will fail if these values are not populated or provided.

### Create a User

> Request: 

``` http
POST /api/v3/users HTTP/1.1
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
  "chosen_locale: "en",
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
      "answer" : [ "Alfred", "Bruce" ]
    }
  ]
}
```

> Response: 

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
  "chosen_locale: "en",
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

In order to create a user account on the MyRewards 2.0 platform there is often
some information about the user we are creating that needs to be known before
the account can be successfully created.

#### User group
The user group that the user will be created as a member of must be
known, we provide an endpoint to query the usergroups for your programme and if
necessary to reconstruct the hierarchy for the usergroups see the usergroups
section.

#### Phone numbers
Telephone and mobile number fields must be supplied in international format, meaning starting with a '+' followed by the international country code (I.e. the UK is 44) followed by at least 8 numeric characters.

#### Registration questions
User accounts can have extra data required over and above the
minimal default fields for a user account. Typically, these take the form of
employee data, membership number etc and can be defined as part of your
programme. These extra data are called registration_questions, for more
information please see the registration_questions section.

Answers to the registration questions are provided in an array of objects, nested
under the key `registration_answers_attributes`. The nested objects themselves must
have the keys `registration_question_id` and `answer`. If the question allows multiple
answers, then the value for `answer` should be an array, as show in the example below.

#### Chosen Locale
When creating or updating a user, if the associated programme has locale marked as mandatory, `chosen_locale` must be provided. Failure to do so will result in an error. When locale is not mandatory and a `chosen_locale` value is not provided, the value will be set to the programme default locale.

#### Company
When providing a user's company, the value must match what is expected by the programme, 
i.e. if the company is a free-text field, then a `string` should be provided. If, however, the
programme is using a managed list of companies, the value must be an object containing the
`name` and `identifier` strings. 

##### Example 1: Company as a free-text field:
`"company": "Luther Corp"` 

##### Example 2: Company as a manage list:

`"company": { "name": "Luther Corp", "identifier": "lth-18" }`

If the company can not be found, it will be created. Existing companies will have their `name` 
updated if different.

The response from the API will also differ depending whether the company is free-text or a 
managed list and will mirror the format sent in the request. The "Update a user" below shows
an example of the response when the company is a managed list.

To unset company, pass `null` as shown below:

`"company": null`

#### HTTP Request

`POST /api/v3/users`

#### Parameters

Parameters | Type | Info
---------- | ---- | ----
username | `string` | may be required, see user identification above, must be unique to the programme if required
email | `string` | valid email address and may be required, see user identification above, must be unique to the programme if required
title | `string` | salutation (Mr, Mrs, Ms, etc) no strict validation.
firstname | `string` | Required
lastname | `string` | Required
company | `mixed` | Potentially required - see programme data requirements. Should be a `string` or an `object` - see "Company" section above.
job_title | `string` | Potentially required - see programme data requirements
address_1 | `string` | Potentially required - see programme data requirements
address_2 | `string` | optional
town | `string` | Potentially required - see programme data requirements
postcode | `string` | Potentially required - see programme data requirements
county | `string` | Potentially required - see programme data requirements
country | `string` | Potentially required - see programme data requirements
date_of_birth | `date` | must be provided in reverse date format `YYYY-MM-DD`, Potentially required - see programme data requirements
telephone | `string` | Potentially required - see programme data requirements - if supplied must be international format (starting with a '+' followed by international dialling code - UK is 44 - followed by at least 8 numeric characters)
mobile | `string` | Potentially required - see programme data requirements, if required, must be unique - if supplied must be international format (starting with a '+' followed by international dialling code - UK is 44 - followed by at least 8 numeric characters)
chosen_locale | `string` | Potentially required - see programme data requirements.
tsandcs | `boolean` | Required
user_group_id | `integer` | optional, will default to programme's default user_group, if not provided
registration_answers_attributes | `array` | array of hashes that contain a registration_question_id and an answer. Some or all of the registration questions may require answers. See registration_questions endpoint documentation
consented | `boolean` | Not required if programme access type is pre_registration with additional details, or SSO or if the programme doesn't have an active privacy policy.
marketing_consented | `boolean` | Can be true or false, not required if programme access type is pre_registration with additional details, or SSO or if the programme doesn't have an active privacy policy.

### Update a User

> Request: 

``` http
PUT /api/v3/users/123 HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "firstname": "Joker",
  "lastname": "Hahaha",
  "company": {
    "name": "Wayne Inc",
    "identifier": "wayne-18"
  }
}
```

> Response: 

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
  "company": {
    "id": 4454,
    "name": "Wayne Inc",
    "identifier": "wayne-18"
  },
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
  "chosen_locale: "en",
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

The update user api is available to update user information. This uses the same
params as the create user api above.

#### HTTP Request
`PUT /api/v3/users/{user_id}`

`PATCH /api/v3/users/{user_id}`


