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
Authorization: Token token={APIKEY}:{SECRETKEY}
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
    {
        "id": 1,
        "name": "Admin",
        "description": "Example Description",
        "parent_id": null,
        "default": "false",
        "position": 1
    },
    {
        "id": 5,
        "name": "Full-Time",
        "description": "Example Description",
        "parent_id": 1,
        "default": "true",
        "position": 2
    },
    {
        "id": 10,
        "name": "Part-Time",
        "description": "Another Example Description",
        "parent_id": 1,
        "default": "false",
        "position": 3
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
description | string | user_group description
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
GET /api/v2/user_groups/{user_group_id} HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Response:

``` http
HTTP/1.1 200 OK
Content-Type: Application/json

{
    "id": 10,
    "name": "Part-Time",
    "description": "Another Example Description",
    "parent_id": 1,
    "default": "false",
    "position": 3
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
Authorization: Token token={APIKEY}:{SECRETKEY}

{
    "name": "Contractors",
    "description": "Another Example Description",
    "parent_id": 1,
    "position": 4,
    "image_url": "http://example_website.com/image.png"
}
```


``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "id": "20",
    "name": "Contractors",
    "description": "Another Example Description",
    "programme": "Demo Programme",
    "parent_id": 1,
    "position": 4,
    "image_url": "http://example_website.com/image.png"
}

```
#### HTTP Request

`POST /api/v2/user_groups`

#### Parameters

Parameters | Type | Info
---------- | ---- | ----
name | `string` | Required - name of the user_group to be created
description | `string` | description of the user_group, which is visible in the admin area only
position | `integer` | position of the user_group in the hierachy
parent_id | `integer` | an optional id field, used if this user group should be nested underneath another
image_url | `string` | a url of user group image

### Update a User Group

This endpoint updates a specific user_group associated to an api keys programme. Please note that attempting to change a `user_group`'s `default`, will
result in an error.

> Request:

``` http
PUT /api/v2/user_groups/{user_group_id} HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
    "name": "Sub-Contractors",
    "position": 5
}

```

> Response:

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "id": "20",
    "name": "Sub-Contractors",
    "description": "Another Example Description",
    "programme": "Demo Programme",
    "parent_id": 1,
    "position": 5,
    "image_url": "http://example_website.com/image.png"
}
```

#### HTTP Request

`PUT /api/v2/user_groups/{user_group_id}`

#### Attributes

Attribute | Type | Description
--------- | ---- | -----------
name | `string` |  Name of the user_group
description | `string` | description of the user_group, which is visible in the admin area only
position | `integer` | Position of the user_group in the hierachy
parent_id | `integer` | ID of a user_group that this user_group should be nested underneath. Providing an invalid ID will result in an error.
image_url | `string` | A url of the user_group image

### Delete a User Group

This endpoint deletes a specific user group associated to an api keys programme. You can only delete user groups that have no associated users or user groups, and are not the default user group. Any attempt to do so will result in an error.

#### Path Parameters

Parameter | Type | Description
--------- | ---- | -----------
user_group_id | `integer` | The ID of the user group you want to delete

#### HTTP Request

`DELETE /api/v2/user_groups/{user_group_id}`

> Request:

``` http
DELETE /api/v2/user_groups/{user_group_id} HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Response:

``` http
HTTP/1.1 200 OK
No content
```
