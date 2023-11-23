## Users 

In order to identify users, a programme will expect to use either username, email or mobile as a unique key to authenticate users with. As a consumer of this service, it is mandatory to supply a value for this field. Furthermore, there will be other fields that have been declared mandatory for your programme and user creation (POST) could fail if these values are not populated or provided.

Reasons include:

- The field is an identifier (email, username)
- The field is hidden from users so they cannot update this when additional details are requested
- Your programme is not set to require additional details from users, therefore all mandatory fields must be supplied upon creation

### Create a User

> Request: 

``` http
POST /api/v3/users HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
    "title": "Dr",
    "firstname": "John",
    "lastname": "Doe",
    "username": "john.doe",
    "email": "john.doe@email.null",
    "company": "Org Inc",
    "job_title": "Demo User",
    "address_1": "No 1 The Place",
    "address_2": "The Street",
    "town": "The Town",
    "county": "The County",
    "postcode": "TH3 P057",
    "country": "UK",
    "date_of_birth": "1970-01-01",
    "telephone": "+440000000000",
    "mobile": "+440000000000",
    "chosen_locale": "en",
    "user_group_id": "10",
    "tsandcs": "true",
    "consented": "false",
    "marketing_consented": "true",
    "registration_answers_attributes": [
        {
            "registration_question_id": "2",
            "answer": "Working From Home"
        },
        {
            "registration_question_id": "16",
            "answer": [
                "Monday",
                "Wednesday",
                "Friday"
            ]
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
    "title": "Dr",
    "firstname": "John",
    "lastname": "Doe",
    "username": "john.doe",
    "email": "john.doe@email.null",
    "company": "Org Inc",
    "job_title": "Demo User",
    "address_1": "No 1 The Place",
    "address_2": "The Street",
    "town": "The Town",
    "county": "The County",
    "postcode": "TH3 P057",
    "country": "UK",
    "date_of_birth": "1970-01-01",
    "telephone": "+440000000000",
    "mobile": "+440000000000",
    "chosen_locale": "en",
    "user_group_id": "10",
    "tsandcs": "true",
    "consented": "false",
    "marketing_consented": "true",
    "registration_answers_attributes": [
        {
            "registration_question_id": "2",
            "question": {
                "user_locale": "Workplace",
                "stack_locale": "Workplace"
            },
            "answer": "Working From Home"
        },
        {
            "registration_question_id": "16",
            "question": {
                "user_locale": "Work Days",
                "stack_locale": "Work Days"
            },
            "answer": [
                "Monday",
                "Wednesday",
                "Friday"
            ]
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

`"company": { "name": "Org Inc", "identifier": "org-inc-01" }`

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

### Get a User

This endpoint returns a specific user associated with an api key's programme. You have the option to specify either the user's unique MyRewards ID, email address, or the username.

#### Path Parameters

Parameter | Type | Description
--------- | ---- | -----------
id | `integer` | The unique MyRewards ID of the user to return
email | `string` | The email address of the user to return
username | `string` | The username of the user to return

#### HTTP Request

variations of the request that are supported:

- `GET /api/v3/users/{id}`
- `GET /api/v3/users/email/{email}`
- `GET /api/v3/users/username/{username}`

> Request:

``` http
GET /api/v3/users/{id} HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Response:

``` http
HTTP/1.1 200 OK
Content-Type: Application/json

{
    "id": 123,
    "title": "Dr",
    "firstname": "John",
    "lastname": "Doe",
    "username": "john.doe",
    "email": "john.doe@email.null",
    "company": "Org Inc",
    "job_title": "Demo User",
    "address_1": "No 1 The Place",
    "address_2": "The Street",
    "town": "The Town",
    "county": "The County",
    "postcode": "TH3 P057",
    "country": "UK",
    "date_of_birth": "1970-01-01",
    "telephone": "+440000000000",
    "mobile": "+440000000000",
    "chosen_locale": "en",
    "user_group_id": "10",
    "tsandcs": "true",
    "consented": "false",
    "marketing_consented": "true",
    "registration_answers_attributes": [
        {
            "registration_question_id": "2",
            "question": {
                "user_locale": "Workplace",
                "stack_locale": "Workplace"
            },
            "answer": "Working From Home"
        },
        {
            "registration_question_id": "16",
            "question": {
                "user_locale": "Work Days",
                "stack_locale": "Work Days"
            },
            "answer": [
                "Monday",
                "Wednesday",
                "Friday"
            ]
        }
    ]
}
```

### Update a User

> Request: 

``` http
PUT /api/v3/users/{user_id} HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
    "user_group_id": "5",
    "registration_answers_attributes": [
        {
            "registration_question_id": "2",
            "answer": "Office"
        },
        {
            "registration_question_id": "16",
            "answer": [
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday"
            ]
        }
    ]
}
```

> Response: 

``` http
HTTP/1.1 200 OK
Content-Type: Application/json

{
    "id": 123,
    "title": "Dr",
    "firstname": "John",
    "lastname": "Doe",
    "username": "john.doe",
    "email": "john.doe@email.null",
    "company": "Org Inc",
    "job_title": "Demo User",
    "address_1": "No 1 The Place",
    "address_2": "The Street",
    "town": "The Town",
    "county": "The County",
    "postcode": "TH3 P057",
    "country": "UK",
    "date_of_birth": "1970-01-01",
    "telephone": "+440000000000",
    "mobile": "+440000000000",
    "chosen_locale": "en",
    "user_group_id": "5",
    "tsandcs": "true",
    "consented": "false",
    "marketing_consented": "true",
    "registration_answers_attributes": [
        {
            "registration_question_id": "2",
            "question": {
                "user_locale": "Workplace",
                "stack_locale": "Workplace"
            },
            "answer": "Office"
        },
        {
            "registration_question_id": "16",
            "question": {
                "user_locale": "Work Days",
                "stack_locale": "Work Days"
            },
            "answer": [
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday"
            ]
        }
    ]
}
```

The update user api is available to update user information. This uses the same
params as the create user api above.

#### HTTP Request
`PUT /api/v3/users/{user_id}`

`PATCH /api/v3/users/{user_id}`


