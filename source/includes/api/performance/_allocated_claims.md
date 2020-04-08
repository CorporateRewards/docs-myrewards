## Allocated Claims

### View Allocated Claims

Endpoint to view allocated claims against a specific promotion. Claims can be scoped down via passed in parameters. Only 100 records are returned at a time.

``` http
GET /api/v2/performance/promotions/1/allocated_claims HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "user_group_id": 1,
  "company_id": 1,
  "status": "pending",
  "created_at_date_range": "01/01/2020, 02/02/2020",
  "date_of_sale_date_range": "01/01/2020, 02/02/2020"
}
```

``` http
HTTP/1.1 200 Ok
Content-Type: application/json

{
  "allocated_claims":
    [
        {
            "id": 1,
            "sale_date": "01/02/2018",
            "product_or_activity_ref": "AAA1234",
            "quantity": 2,
            "user_group_id": 2,
            "company_id": 5,
            "status": "pending",
            "created_at": "01/02/2018",
            "some_custom_field": "some custom answer"
        },
        {
            "id": 2,
            "sale_date": "01/02/2018",
            "product_or_activity_ref": "AAA1234",
            "quantity": 1,
            "user_group_id": 2,
            "company_id": 5,
            "status": "pending",
            "created_at": "01/02/2018",
            "some_custom_field": "another custom answer"
        }
    ]
}
```

#### HTTP Request

`GET /api/v2/performance/promotions/1/allocated_claims`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
promotion\_id | `integer` | The ID of the promotion claim is for. Mandatory.
user\_group\_id | `integer` | ID of a user_group that allocated_claims belong to, used for scoping down results. Optional
company\_id | `integer` | ID of a company that allocated_claims belong to, used for scoping down results. Optional
status | `string` | Required Status for the allocated_claims that are returned, used for scoping down results. Optional
created\_at\_date\_range | `string` | A supplied date range that returned allocated_claims are expected to be created within, comma and space seperated. Used for scoping down results. Optional.
date\_of\_sale\_date\_range | `string` | A supplied date range that returned allocated_claims are expected to have sale_date within. Comma and space seperated. Used for scoping down results. Optional.
page | `integer` | The requested page number. Defaults to page 1 if not supplied. Optional.

### Create Allocated Claims

Endpoint to create allocated claims against specific promotion. Claims are created by using the `data_field` names from above as key/value pairs. Your request must include `user_group_id` or `company_id,` depending on the promotion configuration.

``` http
POST /api/v2/performance/promotions/1/allocated_claims HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "allocated_claims":
    [
        {
            "sale_date": "01/02/2018",
            "product_or_activity_ref": "AAA1234",
            "quantity": 2,
            "user_group_id": 2,
            "company_id": 5,
            "some_custom_field": "some custom answer"
        },
        {
            "sale_date": "03/12/2017",
            "product_or_activity_ref": "BBB4567",
            "quantity": 1,
            "user_group_id": 5,
            "company_id": 3,
            "some_other_custom_field": "some other custom answer"
        }
    ]
}
```

``` http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "allocated_claims":
    [
        {
            "id": 1,
            "sale_date": "01/02/2018",
            "product_or_activity_ref": "AAA1234",
            "quantity": 2,
            "user_group_id": 2,
            "company_id": 5,
            "some_custom_field": "some custom answer"
        },
        {
            "id": 2,
            "sale_date": "03/12/2017",
            "product_or_activity_ref": "BBB4567",
            "quantity": 1,
            "user_group_id": 5,
            "company_id": 3,
            "some_other_custom_field": "some other custom answer"
        }
    ]
}

```

#### HTTP Request

`POST /api/v2/performance/promotions/1/allocated_claims`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
promotion\_id | `integer` | The ID of the promotion claim is for.
sale\_date | `date` | The date when this piece of data was created. Mandatory. 
product\_or\_activity\_ref | `string` | The SKU for the performance product to claim against
quantity | `integer` | The quantity of products sold. Mandatory.
user\_group\_id | `integer` | ID of the user group claim relates to (either this or company_id needs to be supplied)
company\_id | `integer` | ID of the MyRewards company claim related to (either this or user_group_id needs to be supplied)

You will also need to provide any custom data fields as extra keys for each piece of claim data in snake case format which is provided in the name field for the [GET List Data Fields](#list-all-data-fields) for a Promotion.

Eg:

Attribute | Type | Info
--------- | ---- | ----
some\_custom\_field | `custom field type` | A custom answer for this field