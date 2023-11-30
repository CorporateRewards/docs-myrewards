## Sales Data

### Create Sales Data

Endpoint to create claims against specific promotion. Claims are created by using the data_field names from above as key/value pairs.

> Request:

``` http
POST /api/v2/performance/data HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
    "data": [
        {
            "sale_date": "2022-03-10",
            "product_or_activity_ref": "TEST-217744",
            "quantity": 1,
            "user_id": 170944
        },
        {
            "sale_date": "2022-03-10",
            "product_or_activity_ref": "TEST-217744",
            "quantity": 1,
            "user_id": 170944
        }
    ]
}
```

> Success response:

``` http
HTTP/1.1 201 CREATED
Content-Type: Application/json

{
    "results": [
        {
            "claims": [
                {
                    "claim": {
                        "id": 48992,
                        "state": "approved",
                        "points": 1
                    },
                    "errors": []
                }
            ]
        },
        {
            "claims": [
                {
                    "claim": {
                        "id": 48993,
                        "state": "approved",
                        "points": 1
                    },
                    "errors": []
                },
                {
                    "claim": {
                        "id": 48994,
                        "state": "approved",
                        "points": 1
                    },
                    "errors": []
                }
            ]
        },
        {
            "claims": [
                {
                    "claim": {
                        "id": null,
                        "state": null,
                        "points": null
                    },
                    "errors": [
                        "No reward points found"
                    ]
                }
            ]
        },
        {
            "claims": [
                {
                    "claim": {
                        "id": null,
                        "state": null,
                        "points": null
                    },
                    "errors": [
                        "No reward points found",
                        "Product not found"
                    ]
                }
            ]
        },
        {
            "claims": [
                {
                    "claim": {
                        "id": 48995,
                        "state": "approved",
                        "points": 1
                    },
                    "errors": []
                }
            ]
        },
        {
            "claims": [
                {
                    "claim": {
                        "id": null,
                        "state": null,
                        "points": null
                    },
                    "errors": [
                        "No reward points found",
                        "User not found"
                    ]
                }
            ]
        }
    ]
}
```


> Error response:

``` http
HTTP/1.1 422 UNPROCESSABLE ENTITY
Content-Type: Application/json

{
    "errors": [
        "quantity: Please select a valid quantity."
    ],
    "index_of_failed_data": 5
}
```
#### HTTP Request

`POST /api/v2/performance/promotions/{promotion_id}/data`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
sale\_date | `date` | The date when this piece of data was created
product\_or\_activity\_ref | `string` | The SKU for the performance product to claim against
quantity | `integer` | The quantity of products sold
username | `string` | The username or email for the user to assign points to ( Either this or the `user_id` field needs to be supplied. )
user\_id | `user_id` | The MyRewards user ID for the user to assign points to ( Either this or the `username` field needs to be supplied. )

You will also need to provide any custom data fields as extra keys for each piece of claim data in snake case format which is provided in the name field for the GET List Data Fields for a Promotion. The Promotion ID will need to correspond to an existing & valid promotion

If one record in a set being uploaded fails to be created either by being invalid (see note on validity below) or through a programme not having enough points - all records in the request will fail to be created and you will receive a 422 unprocessable entity response along with error details and the zero based index of the record that caused the failure.

Validity - A record is considered invalid if there is something wrong with the claim that would be created as a result. For example if the reward available for the product sent requires a quantity of 2 but you send a quantity of 1, or if a required answer has not been provided. A record will **not** be considered invalid if we cannot find the user, we cannot find the product, or we cannot find an appropriate reward to assign as without these key pieces of information we can't attempt to create a claim, instead we will continue with the remainder of the request and create the claims that we can. This is done so that if you are sending multiple requests and one of them fails because of a problem with the user or product/reward which is highly likely to happen with batches, we do not fail the entire batch for this one reason. You will still receive a 201 created response if not all of the records resulted in a valid claim, but you will receive a response object detailing what claims if any were created for each record, and what errors prevented a claim from being created where appropriate. This means that even if no claims are created, you will still receive a 201 created response, and you must use the response data to determine if any claims were created.


