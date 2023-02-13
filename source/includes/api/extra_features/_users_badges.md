## Badges

### GET User Badges

An endpoint to fetch a list of badges for a given user.

``` http
GET /api/v2/users/{user_id}/badges HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 12,
    "badge_name": "Log In",
    "badge_collection_name": "Apprentice",
    "badge_won": true,
    "awarded_at": "2017-07-04T16:41:30.000+01:00",
    "updated_at": "2017-07-04T16:42:13.000+01:00"
  },
  {
    "id": 11,
    "badge_name": "E-Learning Test",
    "badge_collection_name": "Apprentice",
    "badge_won": false,
    "awarded_at": "2017-07-04T16:34:34.000+01:00",
    "updated_at": "2017-07-04T17:15:10.000+01:00"
  }
]
```

#### HTTP Request

`GET /api/v2/users/{user_id}/badges`

#### Request Parameters

Parameter | Type | Description
--------- | ---- | -----------
user\_id | integer | The ID of the user


### PUT User Badge

A endpoint to update a badge for a given user.

``` http
PUT /api/v2/users/{user_id}/badges/{badge_id} HTTP/1.1
Authorization: Token token=xxx
```

```json
{
  "badge_won": "true"
}
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

  {
    "id": 11,
    "badge_name": "E-Learning Test",
    "badge_collection_name": "Apprentice",
    "badge_won": true,
    "awarded_at": "2017-07-04T16:34:34.000+01:00",
    "updated_at": "2017-07-04T17:15:10.000+01:00"
  }
```

#### HTTP Request

`PUT /api/v2/users/{user_id}/badges/{badge_id}`

#### URL Parameters

Parameter | Type | Description
--------- | ---- | -----------
id | integer | Required badge id
user\_id | integer | The ID of the user

#### Body Parameters

Attribute | Type | Info
--------- | ---- | ----
badge_won | string | Required badge won status
