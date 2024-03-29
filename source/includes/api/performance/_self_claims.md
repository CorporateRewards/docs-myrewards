## Self Claims

### Create a Self Claim

Endpoint to create a self claim against a specific self-claim promotion.

#### HTTP Request

`POST /api/v2/performance/promotions/{promotion_id}/self_claims`

> Header:

``` http
POST /api/v2/performance/promotions/{promotion_id}/self_claims HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Body:

```json
{
  "user_id": 1,
  "sale_date": "2022-01-29",
  "product_or_activity_ref": "p1",
  "quantity": 150,
  "answers": {
    "1": "Free text answer",
    "2": "2017-06-21",
    "3": "abcdefg",
    "4": "Choice A, Choice B",
    "5": "https://invoicefile/12353.doc"
  }
}
```

> Response:

```json
{
  "id": 1234,
  "user_id": 1,
  "sale_date": "2022-01-29",
  "product_or_activity_ref": "p1",
  "quantity": 150,
  "answers": {
    "1": {
        "question": "dynamic question free text?",
        "answer": "Free text answer"
    },
    "2": {
        "question": "dynamic question date select",
        "answer": "2017-06-21"
    },
    "3": {
        "question": "dynamic question scanner",
        "answer": "abcdefg"
    },
    "4": {
        "question": "dynamic question list",
        "answer": "Choice A, Choice B"
    },
    "5": {
        "question": "dynamic question file upload",
        "answer": "https://invoicefile/12353.doc"
    }
  }
}
```

#### Request Parameters

##### Body Parameters

Parameter | Type | Description
--------- | ---- | ----
user_id | `integer` | The user ID of the user making the claim. Mandatory.
sale_date | `string` | The date the product was sold. Mandatory
product_or_activity_ref | `string` | The reference of the product or activity you wish to return claims for. Mandatory.
quantity | `integer` | The quantity of products sold. Mandatory.
answers | `string` | Expected answers depend on their question, which come in the following types: free text, list of values, date select, file upload, scanner. Please provide your answers to dynamic questions as a `question_id` to answer hash, nested under an `answers` key. If the question allows multiple answers, add a comma between each answer. Dynamic questions are sometimes mandatory (if the programme administrator has set them to be).

#### Response Attributes

Attribute | Type | Info
--------- | ---- | ----
id | `integer` | the id of the claim
user_id | `string` | The user ID of the user making the claim.
sale_date | `string` | The date the product was sold.
product_or_activity_ref | `string` | The reference of the claimed product or activity.
quantity | `integer` | The quantity of products sold.
answers | `object` | An object containing questions identified by their id, along with a child object containing the name of the question, and the answer provided for that question.

### Get Self Claims

Endpoint to get self claims against a specific self-claim promotion. Claims can be filtered down via passed-in parameters. If no URL parameters are provided then all claims against the requested promotion are returned. Results are paginated at 100 records per page.


#### HTTP Request

`GET /api/v2/performance/promotions/{promotion_id}/self_claims`

> Header:

``` http
GET /api/v2/performance/promotions/{promotion_id}/self_claims HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Response:

``` http
HTTP/1.1 200 Ok
Content-Type: application/json

{
    "self_claims": [
        {
            "id": 4099,
            "sale_date": "2019-01-29",
            "product_or_activity_ref": "p1",
            "quantity": 150,
            "points_value": 150,
            "user_id": 505,
            "status": "pending",
            "declined_reason": null,
            "created_at": "2019-01-30T14:15:25.000+00:00",
            "updated_at": "2021-01-07T16:41:19.000+00:00",
            "questions_answers": {
                "1174": {
                    "question": "Custom q 1 - free text",
                    "answer": ""
                },
                "1175": {
                    "question": "Custom q 2 - lov r",
                    "answer": ""
                },
                "1176": {
                    "question": "Custom q 3 - lov c",
                    "answer": ""
                },
                "1177": {
                    "question": "Custom q 4 - lov s",
                    "answer": ""
                },
                "1178": {
                    "question": "Custom q 5 - date",
                    "answer": ""
                },
                "1179": {
                    "question": "Custom q 6 - upload",
                    "answer": ""
                }
            }
        },
        {
            "id": 4104,
            "sale_date": "2020-01-02",
            "product_or_activity_ref": "p1",
            "quantity": 10,
            "points_value": 10,
            "user_id": 505,
            "status": "approved",
            "declined_reason": null,
            "created_at": "2020-01-11T14:15:32.000+00:00",
            "updated_at": "2020-01-11T14:15:32.000+00:00",
            "questions_answers": {
                "1174": {
                    "question": "Custom q 1 - free text",
                    "answer": ""
                },
                "1175": {
                    "question": "Custom q 2 - lov r",
                    "answer": ""
                },
                "1176": {
                    "question": "Custom q 3 - lov c",
                    "answer": ""
                },
                "1177": {
                    "question": "Custom q 4 - lov s",
                    "answer": ""
                },
                "1178": {
                    "question": "Custom q 5 - date",
                    "answer": ""
                },
                "1179": {
                    "question": "Custom q 6 - upload",
                    "answer": ""
                }
            }
        },
        {
            "id": 4117,
            "sale_date": "2020-01-23",
            "product_or_activity_ref": "p1",
            "quantity": 5,
            "points_value": 2,
            "user_id": 505,
            "status": "declined",
            "declined_reason": "Not good enough",
            "created_at": "2020-01-23T14:15:32.000+00:00",
            "updated_at": "2020-01-28T10:41:13.000+00:00",
            "questions_answers": {
                "1174": {
                    "question": "Custom q 1 - free text",
                    "answer": ""
                },
                "1175": {
                    "question": "Custom q 2 - lov r",
                    "answer": ""
                },
                "1176": {
                    "question": "Custom q 3 - lov c",
                    "answer": ""
                },
                "1177": {
                    "question": "Custom q 4 - lov s",
                    "answer": ""
                },
                "1178": {
                    "question": "Custom q 5 - date",
                    "answer": ""
                },
                "1179": {
                    "question": "Custom q 6 - upload",
                    "answer": ""
                }
            }
        }
    ]
}
```

#### Request Parameters

##### URL Parameters

Parameter | Type | Description
--------- | ---- | ----
status | `string` | Status of the claims to be returned. Optional
product_or_activity_ref | `integer` | The reference of the product or activity you wish to return claims for. Optional.
user_id | `integer` | ID of a user that claims were made by. Optional
created_at_start_date | `string` | A parameter for scoping claims that were created from that date onwards. Optional.
created_at_end_date | `string` | A parameter for scoping claims that were created on or before the given date. Optional.
date_of_sale_start_date | `string` | A parameter for scoping claims with a `sale_date` from the given date onwards. Optional.
date_of_sale_end_date | `string` | A parameter for scoping claims with a `sale_date` on or before the given date. Optional.
page | `integer` | The requested page number. Defaults to page 1 if not supplied. Optional.


#### Response Attributes

Attribute | Type | Info
--------- | ---- | ----
id | `integer` | the id of the claim
sale_date | `string` | the date of sale as provided on the claim
product_or_activity_ref | `string` | the reference of the claimed product or activity
quantity | `integer` | the number of items claimed
points_value | `integer` |the number of points the claim is worth
user_id | `integer` | the id of the user who made the claim
status | `string` | the status of the claim - one of: pending, approved, declined
declined_reason | `string` | optional - a string indicating the reason for decline if the claim is declined
created_at | `string` | the date that the claim was submitted
updated_at | `string` | the date that the claim was last updated
questions_answers | `object` | an object containing questions identified by their id, along with a child object containing the name of the question, and the answer provided for that question

### Update Self Claim

Endpoint to update a pending self claim against a specific self-claim promotion.

#### HTTP Request

`PATCH /api/v2/performance/promotions/{promotion_id}/self_claims/{claim_id}`

> Header:

``` http
PATCH /api/v2/performance/promotions/{promotion_id}/self_claims/{claim_id} HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Body:

```json
{
  "sale_date": "2022-01-29",
  "product_or_activity_ref": "p1",
  "quantity": 150,
  "answers": {
    "1": "Free text answer",
    "2": "2017-06-21",
    "3": "abcdefg",
    "4": "Choice A, Choice B",
    "5": "https://invoicefile/12353.doc"
  }
}
```

> Response:

```json
{
  "id": 1234,
  "user_id": 1,
  "sale_date": "2022-01-29",
  "product_or_activity_ref": "p1",
  "quantity": 150,
  "points": 300,
  "answers": {
    "1": {
        "question": "dynamic question free text?",
        "answer": "Free text answer"
    },
    "2": {
        "question": "dynamic question date select",
        "answer": "2017-06-21"
    },
    "3": {
        "question": "dynamic question scanner",
        "answer": "abcdefg"
    },
    "4": {
        "question": "dynamic question list",
        "answer": "Choice A, Choice B"
    },
    "5": {
        "question": "dynamic question file upload",
        "answer": "https://invoicefile/12353.doc"
    }
  }
}
```

#### Request Parameters

##### Body Parameters

Parameter | Type | Description
--------- | ---- | ----
sale_date | `string` | The date the product was sold. Mandatory
product_or_activity_ref | `string` | The reference of the product or activity you wish to return claims for. Mandatory.
quantity | `integer` | The quantity of products sold. Mandatory.
points | `integer` | Explicitly set the value of points that the claim is worth. Optional, calculated from the product/activity, quantity and sale date otherwise.
answers | `string` | Expected answers depend on their question, which come in the following types: free text, list of values, date select, file upload, scanner. Please provide your answers to dynamic questions as a `question_id` to answer hash, nested under an `answers` key. If the question allows multiple answers, add a comma between each answer. Dynamic questions are sometimes mandatory (if the programme administrator has set them to be).

#### Response Attributes

Attribute | Type | Info
--------- | ---- | ----
id | `integer` | the id of the claim
user_id | `string` | The user ID of the user making the claim.
sale_date | `string` | The date the product was sold.
product_or_activity_ref | `string` | The reference of the claimed product or activity.
quantity | `integer` | The quantity of products sold.
points | `integer` | The value of points that the claim is worth.
answers | `object` | An object containing questions identified by their id, along with a child object containing the name of the question, and the answer provided for that question.

### Decline Self Claim

Endpoint to decline a specified claim.


#### HTTP Request

`POST /api/v2/performance/promotions/{promotion_id}/self_claims/{claim_id}/decline`


> Header:

``` http
POST /api/v2/performance/promotions/{promotion_id}/self_claims/{claim_id}/decline HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
  "reason_for_decline_id": 1,
  "reason_for_decline_text": "Some reason text string"
}
```

> Response:

``` http
HTTP/1.1 200 Ok
Content-Type: application/json

{
    "id": 4117,
    "sale_date": "2020-01-23",
    "product_or_activity_ref": "p1",
    "quantity": 5,
    "points_value": 2,
    "user_id": 505,
    "status": "declined",
    "declined_reason": "Not good enough",
    "created_at": "2020-01-23T14:15:32.000+00:00",
    "updated_at": "2020-01-28T10:41:13.000+00:00",
    "questions_answers": {
        "1174": {
            "question": "Custom q 1 - free text",
            "answer": ""
        },
        "1175": {
            "question": "Custom q 2 - lov r",
            "answer": ""
        },
        "1176": {
            "question": "Custom q 3 - lov c",
            "answer": ""
        },
        "1177": {
            "question": "Custom q 4 - lov s",
            "answer": ""
        },
        "1178": {
            "question": "Custom q 5 - date",
            "answer": ""
        },
        "1179": {
            "question": "Custom q 6 - upload",
            "answer": ""
        }
    }
}

```

#### Request Parameters

##### Body Parameters

If decline reasons are active on the promotion, then one of `reason_for_decline_id` or `reason_for_decline_text`, but not both, should be provided when declining a claim.

Parameter | Type | Description
--------- | ---- | ----
reason_for_decline_id | `integer` | Required conditional - The ID of a reason for decline belonging to the promotion.
reason_for_decline_text | `string` | Required conditional - A text string of a reason for decline. Can only be provided if the promotion allows free text decline reasons.

### Approve Self Claim

Endpoint to approve a specified claim.


#### HTTP Request

`POST /api/v2/performance/promotions/{promotion_id}/self_claims/{claim_id}/approve`


> Header:

``` http
POST /api/v2/performance/promotions/{promotion_id}/self_claims/{claim_id}/approve HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
  "points_value": 100
}
```

> Response:

``` http
HTTP/1.1 200 Ok
Content-Type: application/json

{
    "id": 4117,
    "sale_date": "2020-01-23",
    "product_or_activity_ref": "p1",
    "quantity": 5,
    "points_value": 100,
    "user_id": 505,
    "status": "approved",
    "declined_reason": null,
    "created_at": "2020-01-23T14:15:32.000+00:00",
    "updated_at": "2020-01-28T10:41:13.000+00:00",
    "questions_answers": {
        "1174": {
            "question": "Custom q 1 - free text",
            "answer": ""
        },
        "1175": {
            "question": "Custom q 2 - lov r",
            "answer": ""
        },
        "1176": {
            "question": "Custom q 3 - lov c",
            "answer": ""
        },
        "1177": {
            "question": "Custom q 4 - lov s",
            "answer": ""
        },
        "1178": {
            "question": "Custom q 5 - date",
            "answer": ""
        },
        "1179": {
            "question": "Custom q 6 - upload",
            "answer": ""
        }
    }
}

```

#### Request Parameters

##### Body Parameters

Parameter | Type | Description
--------- | ---- | ----
points_value | `integer` | Optional. If provided, the value of points awarded for the claim will be updated to match the value supplied. If the value exceeds the available programme budget, an error will be returned and the claim will not be approved.
