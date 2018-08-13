## User Groups

### Get all User Groups

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
    "id" : 1,
    "name" : "dc comics",
    "parent_id" :  null,
    "default" : "false",
    "position" : 1
  },
  {
    "id" : 2,
    "name" : "justice league",
    "parent_id" : 1,
    "default" : "true",
    "position" : 1
  }
]
```

#### HTTP Request

`GET /api/v2/user_groups`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | user_group id
name | string | user_group name
parent\_id | integer | parent user_group id
default | boolean | indicates if this user_group is the default group for the programme
position | integer | position under the parent user_group, used for ordering

### Manage User Groups

An endpoint to create a usergroup for this programme. Only accessible if the key
has been granted access to users. In order to create a usergroup a name is required.
This usergroup can be nested underneath another usergroup by passing the parent
user group id. Images can be uploaded to the usergroup by passing an image url. If
no position is passed then it will default to the bottom of the hierachy.

``` http
POST /api/v2/user_groups HTTP/1.1
Authorization: Token token=xxx

{
  "name": "Example User Group",
  "position": 1,
  "parent_id": nil,
  "default": true,
  "image_url": "http://example_website.com/image.png"
}
```


``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id" : 1,
  "name": "Example User Group",
  "position": 1,
  "parent_id": nil,
  "default": true,
  "image_url": "http://example_hosted_image_url.com/image.png"
}

```
#### HTTP Request

`POST /api/v2/users_groups`

#### Parameters

Parameters | Type | Info
---------- | ---- | ----
name | `string` | Required - name of the user_group to be created
position | `integer` | position of the user_group in the hierachy
parent_id | `integer` | an optional id field, used if the this usergroup should be nested underneath another
default | `string` | can be true or false depending if the new user group should be the default one that new users are placed within
image_url | `string` | a url of an image you wish to upload to identify the user group with
