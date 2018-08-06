## Permissions

Permissions are used to grant access to administrative and reporting areas of the programme.  They are also used to manage user access and ordering rights

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
    "resource_user_group_name": "user group name"
  },
  {
    "id": 8910,
    "name": "text",
    "hint": "some more text",
    "resource_user_group_name": "another user group name"
  }
]
```

This endpoint retrieves all permissions for the current stack

#### HTTP Request

`GET /api/v2/resources`