## Returned Claims

### Create Returned Claims

Endpoint to create returned claims against specific claim. Returned claims are created by specifiying identifiers (key/value pairs) for a specific claim.

> Request:

``` http
POST /api/v3/performance/promotions/{promotion_id}/returned_claims HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
    "returns_data": [
        {
            "user_id": 170944,
            "returns_identifier": 'identifier_001',
            "product_or_activity_ref": "TEST-217744",
            "quantity": 5
        },
        {
            "username": "john.doe",
            "returns_identifier": 'identifier_002',
            "product_or_activity_ref": "TEST-115647",
            "quantity": 2
        }
    ]
}
```

> Success response:

``` http
HTTP/1.1 201 CREATED
Content-Type: Application/json
```


> Error response(s):

``` http
HTTP/1.1 400 BAD REQUEST
Content-Type: Application/json

{
    "errors": [
        "please supply valid product_or_activity_ref value(s), for 1st entry",
        "please supply valid returns_identifier, product_or_activity_ref, quantity, user_id value(s), for 2nd entry"
    ]
}
```

``` http
HTTP/1.1 400 BAD REQUEST
Content-Type: Application/json

{
    "errors": [
        "Number of return entries provided is above the max allowed of 50"
    ]
}
```

``` http
HTTP/1.1 400 BAD REQUEST
Content-Type: Application/json

{
    "errors": [
      "No returns data was provided"
    ]
}
```

``` http
HTTP/1.1 400 BAD REQUEST
Content-Type: Application/json

{
    "errors": [
      "Returns are not enabled on this promotion"
    ]
}
```

``` http
HTTP/1.1 404 Not Found
Content-Type: Application/json

{
    "errors": [
      "Promotion not found"
    ]
}
```

#### HTTP Request

`POST /api/v2/performance/promotions/{promotion_id}/returned_claims`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
product\_or\_activity\_ref | `string` | The SKU for the performance product the original claim was assigned.
quantity | `integer` | The quantity to return against the claim.
returns\_identifier | `string` | The returns\_identifier that is assigned to the given claim.
username | `string` | The username or email for the user the original claim was created against, this will be the user points are deducted from. ( Either this or the `user_id` field needs to be supplied. )
user\_id | `user_id` | The MyRewards user ID for the user the original claim was created against, this will be the user points are deducted from. ( Either this or the `username` field needs to be supplied. )

If one record in a set being uploaded fails to be created then all requested records will not be created and an error object will be given back. This object will contain the errors that need to be addressed before proceededing again with the request.

#### HTTP Request

`POST /api/v2/performance/promotions/{promotion_id}/returned_claims`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
product\_or\_activity\_ref | `string` | The SKU for the performance product the original claim was assigned.
quantity | `integer` | The quantity to return against the claim.
returns\_identifier | `string` | The returns\_identifier that is assigned to the given claim.
username | `string` | The username or email for the user the original claim was created against, this will be the user points are deducted from. ( Either this or the `user_id` field needs to be supplied. )
user\_id | `user_id` | The MyRewards user ID for the user the original claim was created against, this will be the user points are deducted from. ( Either this or the `username` field needs to be supplied. )

If one record in a set being uploaded fails to be created then all requested records will not be created and an error object will be given back. This object will contain the errors that need to be addressed before proceededing again with the request.
