## Data Fields 

### List all Data Fields

A simple endpoint to fetch a list of the data fields for a performance module
enabled programme scoped to a Promotion. Returns an array of data fields as a flat list.

``` http
GET /api/v2/performance/promotions/{promotion_id}/data_fields HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
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
    "answers": "Super-strength\r\nFlight\r\nOther",
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

#### HTTP Request

```http
GET /api/v2/performance/promotions/{promotion_id}/data_fields HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
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
      "username": "john.doe@noemail.com"
    }
  ]
}
```

#### Attributes

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



