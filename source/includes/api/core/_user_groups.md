## User Groups

### Get all User Groups

A simple endpoint to fetch a list of user groups used for this programme. Only
accessible if the key has been granted access to users. Returns an array of
user_groups as a flat list, each user group will indicate it's parent id
enabling the client end of the API to re-construct the user group hierarchy. This
would be required if a registration_question is linked to a tier of user_groups
with a tier being a vertical 'slice' down the hierarchy

``` http
GET /api/v2/user_groups HTTP/1.1
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

### Get a User Group

This endpoint returns a specific user group associated to an api keys programme.

#### Path Parameters

Parameter | Type | Description
--------- | ---- | -----------
user_group_id | `integer` | The ID of the user group you want to return

#### HTTP Request

`GET /api/v2/user_groups/{user_group_id}`

> Request:

``` http
GET /api/v2/user_groups/299 HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```

> Response:

``` http
HTTP/1.1 200 OK
Content-Type: Application/json

{
    "id": 299,
    "name": "Sales",
    "parent_id": 298,
    "default": false,
    "position": 1
}
```

### Create User Groups

An endpoint to create a user group for this programme. Only accessible if the key
has been granted access to users. In order to create a usergroup a name is required.
This usergroup can be nested underneath another user group by passing the parent
user group id. Images can be uploaded to the user group by passing a publicly accessible image url. If
no position is passed then it will default to the bottom of the hierachy.

``` http
POST /api/v2/user_groups HTTP/1.1
Authorization: Token token=xxx

{
  "name": "Example User Group",
  "position": 1,
  "parent_id": null,
  "image_url": "http://example_website.com/image.png"
}
```


``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id" : 1,
  "name": "Example User Group",
  "programme": "Demo Central Perks",
  "parent_id": null,
  "position": 1,
  "default": false,
  "image_url": "http://example_hosted_image_url.com/image.png"
}

```
#### HTTP Request

`POST /api/v2/user_groups`

#### Parameters

Parameters | Type | Info
---------- | ---- | ----
name | `string` | Required - name of the user_group to be created
position | `integer` | position of the user_group in the hierachy
parent_id | `integer` | an optional id field, used if this user group should be nested underneath another
image_url | `string` | a url of user group image
### Update a User Group

This endpoint updates a specific user_group associated to an api keys programme. 

#### Attributes

Attribute | Type | Description
--------- | ---- | -----------
name | `string` |  Name of the user_group
position | `integer` | Position of the user_group in the hierachy
parent_id | `integer` | ID of a user_group that this user_group should be nested underneath. Providing an invalid ID will result in an error.
image_url | `string` | A url of the user_group image

#### HTTP Request

`PUT /api/v2/user_groups/{user_group_id}`

> Request:
``` http
PUT /api/v2/user_groups/{user_group_id} HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "name": "Example Updated User Group",
  "position": 2
}

```

> Response:
``` http
HTTP/1.1 200 OK

{
  "id" : 1,
  "name": "Example Updated User Group",
  "programme": "Demo Central Perks",
  "parent_id": null,
  "position": 2,
  "default": false,
  "image_url": "http://example_hosted_image_url.com/image.png"
}
```