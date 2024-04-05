## Reward Points

### Get Reward Points

This endpoint returns reward points for a specified promotion. Results are paginated at 100 reward points per page.

> Request:

``` http
GET /api/v2/performance/promotions/{promotion_id}/reward_points?page=1 HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
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

`GET /api/v2/performance/promotions/{promotion_id}/reward_points?page=1`

#### URL Parameters

Attribute | Type | Info
--------- | ---- | ----
promotion_id | `integer` |  Required. The ID of the promotion to return reward points for.

#### Query Parameters

Attribute | Type | Info
--------- | ---- | ----
page | `integer` |  Optional. The requested page number. Defaults to page 1 if not supplied.


### Create Reward Points

This endpoint creates a reward point for a specified promotion.

> Request:

``` http
POST /api/v2/performance/promotions/{promotion_id}/reward_points HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
    "reference": "p1",
    "user_group_ids": [355, 350],
    "quantity": 2,
    "points_per_quantity": 5,
    "date_from": "2012-02-28",
    "date_to": "2025-01-31",
    "active": true
}

```


> Response:

``` http
HTTP/1.1 201 CREATED
Content-Type: application/json

{
    "id": 166,
    "promotion_id": 4,
    "name": "product 1",
    "type": "product",
    "reference": "p1",
    "active": true,
    "quantity": 2,
    "points_per_quantity": 5,
    "sale_date_from": "2012-02-28",
    "sale_date_to": "2025-01-31",
    "user_groups": [
        350,
        355
    ],
    "created_at": "2017-06-27T10:58:31.000+01:00",
    "updated_at": "2017-06-27T10:58:31.000+01:00"
}
```


#### HTTP Request

`POST /api/v2/performance/promotions/{promotion_id}/reward_points`

#### URL Parameters

Attribute | Type | Info
--------- | ---- | ----
promotion_id | `integer` |  Required. The ID of the promotion the reward point belongs to.

#### Body Parameters

Parameter | Type | Description
--------- | ---- | -----------
reference | string | Required. Ref of the [performance product](#performance-module-performance-products) that the reward point is to be claimed against.
user_group_ids | array | Optional. An array of all of the user groups that should be eligible for the reward point.
quantity | integer | Required. The quantity that must be claimed to qualify for the reward point. This must be 1 if returns are enabled on your promotion.
points_per_quantity | integer | Required. The number of points to award per quantity.
date_from | date | Required. The date the reward point is eligible from.
date_to | date | Required. The date the reward point is eligible to.
active | boolean | Optional. The active status of the reward point. Defaults to `false` (not active).


### Update Reward Points

This endpoint updates a single reward point for a specified promotion.

> Request:

``` http
PATCH /api/v2/performance/promotions/{promotion_id}/reward_points/{id} HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
    "user_group_ids": [355, 350],
    "quantity": 2,
    "points_per_quantity": 5,
    "date_from": "2012-02-28",
    "date_to": "2025-01-31",
    "active": true
}

```


> Response:

``` http
HTTP/1.1 200 OK
Content-Type: application/json

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
}
```


#### HTTP Request

`PATCH /api/v2/performance/promotions/{promotion_id}/reward_points/{id}`

#### URL Parameters

Attribute | Type | Info
--------- | ---- | ----
promotion_id | `integer` |  Required. The ID of the promotion the reward point belongs to.
id | `integer` |  Required. The ID of the reward point to update.

#### Body Parameters

Parameter | Type | Description
--------- | ---- | -----------
user_group_ids | array | An array of all of the user groups that should be eligible for the reward point.
quantity | integer | The quantity that must be claimed to qualify for the reward point. This must be 1 if returns are enabled on your promotion.
points_per_quantity | integer | The number of points to award per quantity.
date_from | date | The date the reward point is eligible from.
date_to | date | The date the reward point is eligible to.
active | boolean | The active status of the reward point.
