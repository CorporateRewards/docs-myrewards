## Sales Data

### Create Sales Data

Endpoint to create claims against specific promotion. Claims are created by using the data_field names from above as key/value pairs.

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

``` http
HTTP/1.1 201 CREATED
```

#### HTTP Request

`POST /api/v2/performance/promotions/{promotion_id}/data`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
sale\_date | `date` | The date when this piece of data was created
product\_or\_activity\_ref | `string` | The SKU for the performance product to claim against
quantity | `integer` | The quantity of products sold
returns\_identifier | `string` | The returns\_identifier to be assigned to the given claim. (Only required if returns are enabled on the given promotion. )
username | `string` | The username or email for the user to assign points to ( Either this or the `user_id` field needs to be supplied. )
user\_id | `user_id` | The MyRewards user ID for the user to assign points to ( Either this or the `username` field needs to be supplied. )

You will also need to provide any custom data fields as extra keys for each piece of claim data in snake case format which is provided in the name field for the GET List Data Fields for a Promotion. The Promotion ID will need to correspond to an existing & valid promotion

If one record in a set being uploaded fails to be created either by being invalid or through a programme not having enough points - all records in the request will fail to be created


