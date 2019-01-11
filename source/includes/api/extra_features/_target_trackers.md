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

### Get a Target Tracker's values belonging to a User

> Header:

``` http
GET /api/v2/users/123/target_trackers/456 HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```

> Response

```json
{
  "id": 456,
  "name": "Team",
  "target_tracker_users": {
    "user_id": 123,
    "target_value": "2000"
    "current_value": "1000"
   }
}
```

Returns the specific target_tracker & target_tracker_user data for the specified { user_id } and the
{ id } specified.

#### HTTP Request

`GET api/v2/users/{user_id}/target_trackers/{id}`

#### Parameters

Parameter | Type | Description
--------- | ---- | -----------
user_id | integer | The ID of the user you want to retrieve target_tracker data for
id | integer | The ID of the target_tracker to retrieve

### Update a Target Tracker belonging to a User

> Header: 

``` http
PUT /api/v2/users/123/target_trackers/456 HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```

> Body: 

```json
{
  "target_value": "2000",
  "current_value": "1000"
}
```

> Response

```json
{
  "id": 456,
  "name": "Team",
  "target_tracker_users": {
    "user_id": 123,
    "target_value": "2000"
    "current_value": "1000"
  }
}
```

Update the attributes of the specific target_tracker_user for the user specified { user_id } 
and the { id } specified.

#### HTTP Request

`PUT api/v2/users/{user_id}/target_tracker/{id}`

#### Parameters

Parameter | Type | Description
--------- | ---- | -----------
user_id | integer | The ID of the user you want to update target_tracker_user data for
id | integer | The ID of the target_tracker to retrieve
target_value | float | Your desired target_value
current_value | float | Your desired current_value
