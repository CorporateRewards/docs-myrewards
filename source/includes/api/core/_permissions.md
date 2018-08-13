## Permissions

Permissions are used to grant access to administrative and reporting areas of the programme.  They are also used to manage user access and ordering rights

### Get all Permissions

> Header:

``` http
GET /api/v2/permissions HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```

> Response:

```json
[
  {
    "id" : 6,
    "name" : "Enable log in",
    "hint" : "Enable log in",
    "permission_group_name" : "General"
  },
  {
    "id" : 11,
    "name" : "Order Rewards",
    "hint" : "User can order rewards if tehy have sufficient points available",
    "permission_group_name" : "Rewards module"
  }
]
```

This endpoint retrieves all permissions for the current stack

#### HTTP Request

`GET /api/v2/permissions`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | permission id
name | string | permission name
hint | string | permission hint
permission\_group\_name | string | parent permission group name
