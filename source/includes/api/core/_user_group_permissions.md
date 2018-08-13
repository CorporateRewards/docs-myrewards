### User Group > Permissions

### GET UserGroup permissions

A endpoint to fetch a list of permissions for a given user_group. Returns
an array of permissions with each permission displaying its parent permission
group name. This is to help identify different permissions when names are
the same across separate groups. It will also display whether the permission is
active for a given user_group

``` http
GET /api/v2/user_groups/:user_group_id/permissions HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "permissions" : [
    {
      "id" : 1,
      "name" : "permission name",
      "permission_group_name" :  "permission's parent group name",
      "active" : "false"
    },
    {
      "id" : 2,
      "name" : "permission_2 name",
      "permission_group_name" :  "permission's parent group name",
      "active" : "true"
    }
  ]
}
```

#### HTTP Request

`GET /api/v2/user_groups/:user_group_id/permissions`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | permission id
name | string | permission name
permission\_group\_name | string | parent permission group name
active | string | indicates if this permission is active for this user_group


### Update a User Group's Permission set

An endpoint to update the permissions associated with a give user_group. After querying
for the list of permissions associated with a given user_group, you can add or remove
a permission by simply changing the value associated with the `active` key from true
to false or vice-versa. You will be returned the updated list of permissions relative
to the given user_group

``` http
PATCH /api/v2/user_groups/:user_group_id/permissions HTTP/1.1
Authorization: Token token=xxx

{
  "permissions" : [
    {
      "id" : 1,
      "name" : "permission name",
      "permission_group_name" :  "permission's parent group name",
      "active" : "false"
    },
    {
      "id" : 2,
      "name" : "permission_2 name",
      "permission_group_name" :  "permission's parent group name",
      "active" : "false"
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
      "name" : "permission name",
      "permission_group_name" :  "permission's parent group name",
      "active" : "false"
    },
    {
      "id" : 2,
      "name" : "permission_2 name",
      "permission_group_name" :  "permission's parent group name",
      "active" : "false"
    }
  ]
}
```

#### HTTP Request

`PATCH /api/v2/user_groups/:user_group_id/permissions`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | permission id
name | string | permission name
permission\_group\_name | string | parent permission group name
active | string | indicates if this permission is active for this user_group
