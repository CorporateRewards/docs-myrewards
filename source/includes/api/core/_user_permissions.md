## User > Permissions

### GET User permissions

A endpoint to fetch a list of permissions for a given user. Returns an array of permissions displaying it's parent
permissions group name. This is to help identify different permissions when names are the same across separate groups.
It will also display whether the permission is active for the given user and the state of the permission which can
be `Same As User Group` or if the permission has been overridden for that user: `Always Allow` or `Always Deny`.

``` http
GET /api/v2/users/:user_id/permissions HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "permissions" : [
    {
      "id" : 1,
      "name" : "Enable log in",
      "permission_group_name" :  "General",
      "active" : false,
      "state" : "Same As User Group"
    },
    {
      "id" : 2,
      "name" : "Order Rewards",
      "permission_group_name" :  "Rewards module",
      "active" : true,
      "state" : "Always Allow"
    }
  ]
}
```

#### HTTP Request

`GET /api/v2/users/:user_id/permissions`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | permission id
name | string | permission name
permission\_group\_name | string | parent permission group name
active | string | indicates if this permission is active for this user
state | string | indicates whether the permission is granted or denied specifically for this user or if it is the same as the user_group


### POST User permissions

A endpoint to update a list of permissions for a given user. Returns an array of permissions displaying it's parent
permissions group name. This is to help identify different permissions when names are the same across separate groups.
It will also display whether the permission is active for the given user and the state of the permission which can
be `Same As User Group` or if the permission has been overridden for that user: `Always Allow` or `Always Deny`.

``` http
POST /api/v2/users/:user_id/permissions HTTP/1.1
Authorization: Token token=xxx

{
  "permissions" : [
    {
      "id" : 1,
      "name" : "Enable log in",
      "permission_group_name" :  "General",
      "active" : true,
      "state" : "Same As User Group"
    },
    {
      "id" : 2,
      "name" : "Order Rewards",
      "permission_group_name" :  "Rewards module",
      "active" : false,
      "state" : "Always Allow"
    }
  ]
}
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "permissions" : [
    {
      "id" : 1,
      "name" : "Enable log in",
      "permission_group_name" :  "General",
      "active" : true,
      "state" : "Always Allow"
    },
    {
      "id" : 2,
      "name" : "Order Rewards",
      "permission_group_name" :  "Rewards module",
      "active" : false,
      "state" : "Same As User Group"
    }
  ]
}
```

#### HTTP Request

`POST /api/v2/users/:user_id/permissions`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | permission id
name | string | permission name
permission\_group\_name | string | parent permission group name
active | string | indicates if this permission is active for this user
state | string | indicates whether the permission is granted or denied specifically for this user or if it is the same as the user_group
