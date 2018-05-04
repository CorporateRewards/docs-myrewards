## Sales Data

### Create Sales Data

Endpoint to create claims against specific promotion. Claims are created by using the data_field names from above as key/value pairs.

``` http
POST /api/v2/performance/data HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

[
    {
        "id": 468,
        "promotion_id": 36,
        "name": "customer_name",
        "label": "Customer name",
        "mandatory": false,
        "field_type": "list_values",
        "answers": "Bob\r\nHarry\r\nSuzy",
        "created_at": "2018-01-10T08:50:50.000+00:00",
        "updated_at": "2018-01-26T12:51:15.000+00:00",
        "position": 0
    },
    {
        "id": 464,
        "promotion_id": 36,
        "name": "invoice_date",
        "label": "Invoice date",
        "mandatory": true,
        "field_type": "date",
        "answers": "",
        "created_at": "2018-01-10T08:43:59.000+00:00",
        "updated_at": "2018-01-10T08:51:04.000+00:00",
        "position": 1
    },
    {
        "id": 465,
        "promotion_id": 36,
        "name": "product_or_activity_ref",
        "label": "Product or Activity Ref",
        "mandatory": true,
        "field_type": "free_text",
        "answers": null,
        "created_at": "2018-01-10T08:43:59.000+00:00",
        "updated_at": "2018-01-10T08:43:59.000+00:00",
        "position": 2
    },
    {
        "id": 466,
        "promotion_id": 36,
        "name": "quantity",
        "label": "Quantity",
        "mandatory": true,
        "field_type": "numeric",
        "answers": null,
        "created_at": "2018-01-10T08:43:59.000+00:00",
        "updated_at": "2018-01-10T08:43:59.000+00:00",
        "position": 3
    },
    {
        "id": 567,
        "promotion_id": 36,
        "name": "value_of_sale",
        "label": "Value of sale",
        "mandatory": true,
        "field_type": "numeric",
        "answers": "",
        "created_at": "2018-01-26T12:52:48.000+00:00",
        "updated_at": "2018-02-07T15:03:41.000+00:00",
        "position": 4
    },
    {
        "id": 467,
        "promotion_id": 36,
        "name": "username",
        "label": "Username",
        "mandatory": true,
        "field_type": "free_text",
        "answers": null,
        "created_at": "2018-01-10T08:43:59.000+00:00",
        "updated_at": "2018-01-10T08:43:59.000+00:00",
        "position": 5
    }
]
```

``` http
HTTP/1.1 201 CREATED
```

#### HTTP Request

`POST /api/v2/performance/promotions/1/data`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
sale\_date | `date` | The date when this piece of data was created
product\_or\_activity\_ref | `string` | The SKU for the performance product to claim against
quantity | `integer` | The quantity of products sold
username | `string` | The username or email for the user to assign points to ( Either this or the `user_id` field needs to be supplied. )
user\_id | `user_id` | The MyRewards user ID for the user to assign points to ( Either this or the `username` field needs to be supplied. )

You will also need to provide any custom data fields as extra keys for each piece of claim data in snake case format which is provided in the name field for the GET List Data Fields for a Promotion. The Promotion ID will need to correspond to an existing & valid promotion

If one record in a set being uploaded fails to be created either by being invalid or through a programme not having enough points - all records in the request will fail to be created


