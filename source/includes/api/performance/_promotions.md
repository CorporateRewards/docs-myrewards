## Promotions

### List all programme promotions

Endpoint to fetch a list of the performance promotions

``` http
GET /api/v2/performance/promotions HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json
[
  {
    "id": 1,
    "name": "Promotion A",
    "start_date": "2025-04-01",
    "end_date": null,
    "close_date": null,
    "status": "active",
    "promotion_type": "self_claim"
  },
  {
    "id": 2,
    "name": "Promotion B",
    "start_date": "2026-01-01",
    "end_date": "2026-02-01",
    "close_date": null,
    "status": "active",
    "promotion_type": "data_upload"
  },
  {
    "id": 3,
    "name": "Promotion C",
    "start_date": "2025-12-01",
    "end_date": "2025-12-31",
    "close_date": null,
    "status": "active",
    "promotion_type": "self_claim"
  }
]
```

#### HTTP Request

`GET /api/v2/performance/promotions`

#### Attributes

Attribute | Type      | Info
--------- |-----------| ----
id | `integer` | Promotion ID
name | `string`  | Promotion name
start_date | `string` | Promotion start date; can be `null` if no start date is set
end_date  | `string` | Promotion end date; can be `null` if no end date is set
close_date | `string` | Promotion close date; can be `null` if no close date is set
status | `string` | Promotion status (one of: 'not_active', 'active', 'archived')
promotion_type | `string` | Promotion type (one of: 'self_claim', 'data_upload', 'allocated_claims')
