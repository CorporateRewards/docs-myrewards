# Performance Module

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
    "name": "superpower",
    "label": "Superpower",
    "mandatory": true,
    "field_type": "list_values",
    "answers": "Super-strengh\r\nFlight\r\nOther",
    "created_at": "2016-04-14T13:34:03.000+01:00",
    "updated_at": "2016-04-14T13:34:03.000+01:00",
    "position": 1
  },
  {
    "id": 197,
    "promotion_id": 1,
    "name": "hero_name",
    "label": "Hero name",
    "mandatory": true,
    "field_type": "free_text",
    "answers": null,
    "created_at": "2016-04-14T13:35:03.000+01:00",
    "updated_at": "2016-04-14T13:35:03.000+01:00",
    "position": 2
  }
]
```

### HTTP Request

```http
GET /api/v2/performance/promotions/1/data_fields HTTP/1.1
Authorization: Token token=xxx
```

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "data": [
    {
      "customer_name": "Bob",
      "invoice_date": "2018-01-01",
      "product_or_activity_ref": "PRE",
      "quantity": 2,
      "value_of_sale": 100.35,
      "username": "juliet@corporaterewards.co.uk"
    }
  ]
}
```

### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | `integer` | data\_field id
promotion_id | `integer` | promotion id
name | `string` | data\_field name in snake case format.
label | `string` | data\_field label.
mandatory | `boolean` | Whether this field is required
field\_type | `string` | One of: 'free\_text', 'numeric', 'list\_values', 'date'
answers | `string` | A '\r\n' separated list of allowed answers
created\_at | `date` | The time at which this field was created
updated\_at | `date` | The time at which this field was last updated
position | `integer` | Position of the data field within the form


## Create Sales Data

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

### HTTP Request

`POST /api/v2/performance/promotions/1/data`

### Attributes

Attribute | Type | Info
--------- | ---- | ----
sale\_date | `date` | The date when this piece of data was created
product\_or\_activity\_ref | `string` | The SKU for the performance product to claim against
quantity | `integer` | The quantity of products sold
username | `string` | The username or email for the user to assign points to ( Either this or the `user_id` field needs to be supplied. )
user\_id | `user_id` | The MyRewards user ID for the user to assign points to ( Either this or the `username` field needs to be supplied. )

You will also need to provide any custom data fields as extra keys for each piece of claim data in snake case format which is provided in the name field for the GET List Data Fields for a Promotion. The Promotion ID will need to correspond to an existing & valid promotion

If one record in a set being uploaded fails to be created either by being invalid or through a programme not having enough points - all records in the request will fail to be created


