# Performance Products

## Creating a Product

Endpoint to create performance products for a programme with the performance module enabled.

``` http
POST /api/v2/performance/performance_product_batches HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
    "performance_products":[
        {
            "performance_category_id": 1,
            "name": "Test Product 1",
            "ref": "abc1236",
            "product_type": "product",
            "value": 10,
            "description": "some description"
        },
        {
            "performance_category_id": 1,
            "name": "Test Product 2",
            "ref": "abc5766",
            "product_type": "product",
            "value": 10,
            "description": "some description"
        }
    ]
}
```

``` http
HTTP/1.1 201 Created
Content-Type: application/json

[
    {
        "id": 1,
        "peformance_category_id": 1,
        "name": "Test Product 1",
        "ref": "abc1236",
        "product_type": "product",
        "value": 10,
        "description": "some description"
    },
    {
        "id": 2,
        "peformance_category_id": 1,
        "name": "Test Product 2",
        "ref": "abc5766",
        "product_type": "product",
        "value": 10,
        "description": "some description"
    }
]
```

#### HTTP Request

`POST /api/v2/performance/performance_product_batches`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
performance\_category\_id | `integer` | The id of the category the product will belong to. This must be valid for your programme
name | `string` | The name of the product. Must be unique
ref | `string` | The reference for the product. Must be unique
product\_type | `string` | Must be either 'product' or 'activity'
value | `integer` | A positive two digit number. Must be the value in RRP or the cost value of the product in your programme's currency. If the product\_type is 'product', this must be provided
description | `text` | Some text describing the product. Optional


## Updating a Product

Endpoint to update performance products for a programme with the performance module enabled.

``` http
PUT /api/v2/performance/performance_product_batches HTTP/1.1
PATCH /api/v2/performance/performance_product_batches HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
    "performance_products":[
        {
            "id": 1,
            "performance_category_id": 1,
            "name": "Update Name",
            "ref": "abc1236",
            "product_type": "product",
            "value": 10,
            "description": "Updated Description"
        }
    ]
}
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
    {
        "id": 1,
        "peformance_category_id": 1,
        "name": "Updated name",
        "ref": "abc1236",
        "product_type": "product",
        "value": 10,
        "description": "Updated description"
    }
]
```

#### HTTP Request

```
PUT /api/v2/performance/performance_product_batches
PATCH /api/v2/performance/performance_product_batches
```

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | `integer` | The id of the performance product to be updated
performance\_category\_id | `integer` | The id of the category the product will belong to. This must be valid for your programme
name | `string` | The name of the product. Must be unique
ref | `string` | The reference for the product. Must be unique
product\_type | `string` | Must be either 'product' or 'activity'
value | `integer` | A positive two digit number. Must be the value in RRP or the cost value of the product in your programme's currency. If the product\_type is 'product', this must be provided
description | `text` | Some text describing the product. Optional

