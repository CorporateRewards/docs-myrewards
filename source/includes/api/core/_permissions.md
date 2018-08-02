## Permissions ( Resources )

### Get all Permissions

> Header: 

``` http
GET /api/v2/resources HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```

> Response:

```json
[
  {
    "id": 1234,
    "name": "text",
    "hint": "some more text",
    "resource_user_group_id": 4567,
    "resource_user_group_name": "user group name"
  },
  {
    "id": 8910,
    "name": "text",
    "hint": "some more text",
    "resource_user_group_id": 1234,
    "resource_user_group_name": "another user group name"
  }
]
```

This endpoint retrieves all permissions ( resources ) for the current stack

#### HTTP Request

`GET /api/v2/resources`
