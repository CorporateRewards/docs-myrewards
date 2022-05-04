## Reward Points

### Get Reward Points

This endpoint returns reward points for a specified promotion. Results are paginated at 100 reward points per page.

> Request:

``` http
GET /api/v2/performance/promotions/:promotion_id/reward_points HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "page": 1,
}

```


> Response:

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
    {
        "id": 166,
        "promotion_id": 4,
        "name": "product 1",
        "type": "product",
        "reference": "p1",
        "active": true,
        "quantity": 1,
        "points_per_quantity": 1,
        "sale_date_from": "2013-02-01",
        "sale_date_to": "2022-12-31",
        "user_groups": [
            350,
            355
        ],
        "created_at": "2017-06-27T10:58:31.000+01:00",
        "updated_at": "2017-06-27T10:58:31.000+01:00"
    },
    {
        "id": 6345,
        "promotion_id": 4,
        "name": "product 2",
        "type": "product",
        "reference": "p2",
        "active": true,
        "quantity": 1,
        "points_per_quantity": 1,
        "sale_date_from": "2016-12-18",
        "sale_date_to": "2026-11-19",
        "user_groups": [],
        "created_at": "2021-07-25T15:12:58.000+01:00",
        "updated_at": "2021-07-25T15:12:58.000+01:00"
    },
    {
        "id": 6346,
        "promotion_id": 4,
        "name": "product 3",
        "type": "product",
        "reference": "p3",
        "active": true,
        "quantity": 1,
        "points_per_quantity": 1,
        "sale_date_from": "2016-12-18",
        "sale_date_to": "2026-11-19",
        "user_groups": [],
        "created_at": "2021-07-25T15:13:37.000+01:00",
        "updated_at": "2021-07-25T15:13:37.000+01:00"
    }
]
```


#### HTTP Request

`GET /api/v2/performance/promotions/:promotion_id/reward_points?page=1`

#### URL Parameters

Attribute | Type | Info
--------- | ---- | ----
promotion_id | `integer` |  Required. The ID of the promotion to return reward points for.

#### Query Parameters

Attribute | Type | Info
--------- | ---- | ----
page | `integer` |  Optional. The requested page number. Defaults to page 1 if not supplied.

