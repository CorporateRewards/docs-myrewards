## Target Trackers

A target tracker is used to display a target value to a user and their achievement against that target.

### Get All Target Trackers

> Header:

``` http
GET /api/v2/target_trackers HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```

```json
[
  {
    "id": 1234,
    "name": "text"
    "currency": "points"
  },
  {
    "id": 4567,
    "name": "some other text"
    "currency": "£"
  }
]
```

This endpoint retrieves all target_trackers that belong to a programme (scoped by api key)

#### HTTP Request

`GET /api/v2/target_trackers`
