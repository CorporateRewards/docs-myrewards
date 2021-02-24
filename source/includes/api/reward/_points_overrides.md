## Points Overrides

### Update a points override

Set or update a points override for a product within your programme.

<aside>
Note that this endpoint uses IDs from
<a href="https://docs.gps.my-rewards.co.uk/#products-list-all-products">GPS</a>,
and not MyRewards
</aside>

If MyRewards has already imported the product from GPS, the points override will take effect on your programme immediately. Otherwise, you will need to wait for the daily sync to have run before the override takes effect.

#### HTTP Request

`PUT /api/v2/points_overrides/{gps_product_id}`

> Header:

```http
PUT /api/v2/points_overrides/1 HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```

> Body:

```json
{
    "points": 200
}
```

> Response:

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "programme_id": 123,
    "gps_product_id": 5678,
    "points": 200
}
```

#### Request Parameters

##### URL Parameters

Parameter | Type | Description
----------|------|----
gps_product_id | `integer` | The product ID (**from GPS**) whose points you want to override

##### Body Parameters

Parameter | Type | Description
----------|------|----
points | `integer` | The points override you want to set. Must be >= 0
