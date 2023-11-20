## Submissions

### Get all submissions

An endpoint to get all submissions for a given campaign. Results are paginated and return 100 records per page.

#### HTTP Request

`GET /api/v2/campaigns/{campaign_id}/submissions`

#### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
page | `integer` | The page number that you wish to view. Optional
status | `string` | Status of the submissions to be returned. Optional
user_id | `integer` | ID of a sender that submissions were made by. Optional
created_at_date | `date` | A parameter in ISO-8601 format for scoping submissions that were created from that date onwards. Optional.
created_at_end_date | `date` | A parameter in ISO-8601 format for scoping submissions that were created on or before the given date. Optional.

> Request:

``` http
GET /api/v2/campaigns/{campaign_id}/submissions HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Response:

``` http
HTTP/1.1 200 OK
Content-Type: Application/json

[
    {
        "id": 157,
        "award_id": 1317,
        "status": "approved_l1",
        "sender_id": 111744,
        "points_requested": 100,
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
            }
        },
        "points_approved": 100,
        "approved_by": {
            "level_1": {
                "user_id": 505,
            },
            "level_2": {
                "user_id": null,
            }
        },
        "declined_by": {
            "level_1": {
                "user_id": null,
                "reason": null
            },
            "level_2": {
                "user_id": null,
                "reason": null
            }
        }
    },
    {
        "id": 157,
        "award_id": 1318,
        "status": "pending_l1",
        "sender_id": 111744,
        "points_requested": 200,
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
        },
        "points_approved": 0,
        "approved_by": {
            "level_1": {
                "user_id": null,
            },
            "level_2": {
                "user_id": null,
            }
        },
        "declined_by": {
            "level_1": {
                "user_id": null,
                "reason": null
            },
            "level_2": {
                "user_id": null,
                "reason": null
            }
        }
    }
]
```

### Update a Submission

An endpoint to update a submission for a given recognition campaign.

#### HTTP Request

`POST /api/v2/campaigns/{campaign_id}/submissions/{submission_id}/approve`

#### Request Parameters

#### Body Parameters

Parameter | Type | Description
--------- | ---- | -----------
submission_id | `integer` | The ID of the submission you want to approve
campaign_id | `integer` | The ID of the campaign that the submission belongs to

> Request:

``` http
POST /api/v2/campaigns/{campaign_id}/submissions/{submission_id}/approve HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Response:

``` http
HTTP/1.1 200 OK
Content-Type: Application/json

[
    {
        "id": 157,
        "award_id": 1940,
        "status": "approved_l1",
        "sender_id": 119742,
        "points_requested": 0,
        "created_at": "2019-02-21T11:45:35.000+00:00",
        "updated_at": "2019-02-21T11:45:35.000+00:00",
        "questions_answers": {
            "355": {
                "question": "Please enter your unique reference number:",
                "answer": "sdsdfsfdsfs"
            }
        },
        "points_approved": 0,
        "approved_by": {
            "level_1": {
                "user_id": null
            },
            "level_2": {
                "user_id": null
            }
        },
        "declined_by": {
            "level_1": {
                "user_id": null,
                "reason": null
            },
            "level_2": {
                "user_id": null,
                "reason": null
            }
        }
    }
]
```

### Decline Submission

Endpoint to decline a given submission.

``` http
POST /api/v2/campaigns/{campaign_id}/submissions/{id}/decline HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
  "reason_for_decline_id": "An id for a decline reason",
  "reason_for_decline_text": "Some reason text string"
}
```

``` http
HTTP/1.1 200 Ok
Content-Type: application/json

{
    "id": 162668,
    "award_id": 2078,
    "status": "declined_l2",
    "sender_id": 119742,
    "points_requested": 0,
    "created_at": "2021-09-22T15:52:18.000+01:00",
    "updated_at": "2021-09-22T15:52:18.000+01:00",
    "questions_answers": {
        "355": {
            "question": "Custom q 1 - free text",
            "answer": ""
        }
    },
    "points_approved": 0,
    "approved_by": {
        "level_1": {
            "user_id": null
        },
        "level_2": {
            "user_id": null
        }
    },
    "declined_by": {
        "level_1": {
            "user_id": null,
            "reason": null
        },
        "level_2": {
            "user_id": null,
            "reason": "Declined Reason"
        }
    }
}
```
#### HTTP Request

`POST /api/v2/campaigns/{campaign_id}/submissions/{id}/decline`


#### Request Parameters

##### Body Parameters

If decline reasons are active on the campaign, then one of `reason_for_decline_id` or `reason_for_decline_text`, but not both, should be provided when declining a submission.

Parameter | Type | Description
--------- | ---- | ----
reason\_for\_decline\_id | `integer` | The ID of a reason belonging to the campaign. Mandatory if decline reasons enabled on programme.
reason\_for\_decline\_text | `string` | A text string for a decline reason, can only be provided if the campaign allows free text decline reasons. Optional.
