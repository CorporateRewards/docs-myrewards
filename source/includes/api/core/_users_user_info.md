## User Info

An endpoint to fetch user information for every user on the programme.

The fields returned are **fully configurable per programme**. Please choose which fields to expose under _User Info API Settings_ in the admin area,
the response will then contain exactly those fields. The order of the fields in each user object reflects the order the administrator has arranged them
in, so re-ordering the settings changes the order of the keys in the response. The server emits keys in the configured order, but clients should not rely on JSON object key ordering.

Because the field list is programme-specific, the example below is illustrative only — your programme's response
will contain the fields configured for it.

The current fixed fields you can choose from are `id`, `firstname`, `lastname`, `email`, `created_at`, `updated_at`, `last_sign_in_at`, `current_sign_in_at`, `consented_at`, `user_identifier`, `points`, `fullname`, `programme_name`, `last_login`, `user_group_id`, `user_group_name`

You can also then choose from a selection of Static and Dynamic registration question fields.

<aside class="notice">
This endpoint requires the API key to have the <code>UserInfo/Read</code> permission. Without it, the request
returns <code>403 Forbidden</code>.
</aside>

### GET User info

`GET /api/v2/user_info`

``` http
GET /api/v2/user_info HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 12345,
    "firstname": "John",
    "lastname": "Doe",
    "email": "john.doe@email.null",
    "points": 1500,
    "user_group_name": "Sales",
    "created_at": "2026-07-01T09:30:00+01:00",
    "favourite_colour": "Blue",
    "t_shirt_size": "Large"
  },
  {
    "id": 12346,
    "firstname": "Jane",
    "lastname": "Smith",
    "email": "jane.smith@email.null",
    "points": 320,
    "user_group_name": "Marketing",
    "created_at": "2026-06-14T16:05:41+01:00",
    "favourite_colour": "Green",
    "t_shirt_size": "Medium"
  }
]
```

#### HTTP Request

`GET /api/v2/user_info`

#### Parameters

Parameters | Type | Info
---------- | ---- | ----
page | `integer` | Results are paginated 100 users per page. Pass a `page` query parameter to request a specific page; when omitted, the first page is returned.

#### Configurable fields

The keys in each user object depend entirely on the settings configured for the programme. A setting can expose one
of the following, and the key used in the response is derived as shown:

Field type | Example keys | How the key is derived
---------- | ------------ | ----------------------
User attribute | `id`, `firstname`, `lastname`, `email`, `created_at`, `updated_at`, `last_sign_in_at`, `current_sign_in_at`, `consented_at`, `user_identifier`, `points`, `fullname`, `programme_name`, `last_login` | The attribute name
User group | `user_group_id`, `user_group_name` | The user group attribute, prefixed with `user_group_`
Registration question | e.g. `favourite_colour`, `t_shirt_size`, `company`, `job_title` | The registration question's field name

Values are typed to match the underlying data. Timestamps are returned as ISO&nbsp;8601 strings (e.g.
`2026-07-01T09:30:00+01:00`). A field with no value for a given user is returned as `null`.

#### No configured fields

If the programme has no User Info API settings configured, the endpoint returns `204 No Content` with an empty body.

``` http
HTTP/1.1 204 No Content
```
