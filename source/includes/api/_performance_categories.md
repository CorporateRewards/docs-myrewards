# Performance Categories

## List Performance Categories

Endpoint to fetch a list of the performance categories for a performance module enabled programme

``` http
GET /api/v2/performance/performance_categories HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json
[
    {
        "id": 1,
        "name": "Category Name 1"
    },
    {
        "id": 2,
        "name": "Category Name 2"
    }
]
```

### HTTP Request

`GET /api/v2/performance/performance_categories`

### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | `integer` | The id of the performance category
name | `string` | The name of the performance category
