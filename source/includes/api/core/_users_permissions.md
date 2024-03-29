## User > Permissions

### GET User permissions

An endpoint to fetch a list of permissions for a given user. Returns an array of permissions displaying it's parent
permissions group name. This is to help identify different permissions when names are the same across separate groups.
It will also display whether the permission is active for the given user and the state of the permission which can
be `Same As User Group` or if the permission has been overridden for that user: `Always Allow` or `Always Deny`.

``` http
GET /api/v2/users/{user_id}/permissions HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
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

`GET /api/v2/users/{user_id}/permissions`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | Required permission id
name | string | Required permission name
permission\_group\_name | string | Required parent permission group name
active | string | Required indicates if this permission is active for this user
state | string | Required indicates whether the permission is granted or denied specifically for this user or if it is the same as the user_group


### POST User permissions

A endpoint to update a list of permissions for a given user. Returns an array of permissions displaying it's parent
permissions group name. This is to help identify different permissions when names are the same across separate groups.
It will also display whether the permission is active for the given user and the state of the permission which can
be `Same As User Group` or if the permission has been overridden for that user: `Always Allow` or `Always Deny`.

The only value that this request will change is the `active` field. The other fields are present
to make it easier to move from the `GET` request to a `POST` without having to reformat
or delete much of the `GET` request response.

N.B. When specifying active = true this will set the permission to "Always allow"
setting to false will have the effect of "Always deny"

``` http
PATCH /api/v2/users/{user_id}/permissions HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}

{
  "permissions" : [
    {
      "id" : 1,
      "name" : "Enable log in",
      "permission_group_name" :  "General",
      "active" : true
    },
    {
      "id" : 2,
      "name" : "Order Rewards",
      "permission_group_name" :  "Rewards module",
      "active" : false
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
      "active" : true
    },
    {
      "id" : 2,
      "name" : "Order Rewards",
      "permission_group_name" :  "Rewards module",
      "active" : false
    }
  ]
}
```

#### HTTP Request

`PATCH /api/v2/users/{user_id}/permissions`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | Required permission id
name | string | Required permission name
permission\_group\_name | string | Required parent permission group name
active | string | Required indicates if this permission is active for this user
