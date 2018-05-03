# UserGroups

## List UserGroups

A simple endpoint to fetch a list of usergroups used for this programme. Only
accessible if the key has been granted access to users. Returns an array of
user_groups as a flat list, each usergroup will indicate it's parent id
enabling the client end of the API to re-construct the usergroup hierarchy. This
would be required if a registration_question is linked to a tier of user_groups
with a tier being a vertical 'slice' down the hierarchy

``` http
GET /api/v2/user_group HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id" : "1",
    "name" : "dc commics",
    "parent_id" :  null,
    "default" : "false",
    "position" : "1"
  },
  {
    "id" : "2",
    "name" : "justice league",
    "parent_id" : "1",
    "default" : "true",
    "position" : "1"
  }
]
```

### HTTP Request

`GET /api/v2/user_groups`

### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | `integer` | user_group id
name | `string` | user_group name
parent_id | `integer` | parent user_group id
default | `boolean` | indicates if this user_group is the default group for the programme
position | `integer` | position under the parent user_group, used for ordering

