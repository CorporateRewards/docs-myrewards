## User Data Widgets

### Show a specific User Data Widget belonging to a User 

To list all user_data_widgets that belong to a user (scoped by api key)

> Header:

``` http
GET /api/v2/users/123/user_data_widgets/456 HTTP/1.1
Authorization: Token token=xxx
```

```json
{
  "user_id" => 123,
  "id" => "456",
  "data" => "text"
}
```

### Update a specific User Data Widget belonging to a User 

To update the data of a user_data_widget that belongs to a user (scoped by api key)

> Header:

``` http
PUT /api/v2/users/123/user_data_widgets/456 HTTP/1.1
Authorization: Token token=xxx
```

```json
{
  "user_id" => 123,
  "id" => "456",
  "data" => "some new text"
}
```

> Response:

``` http
HTTP/1.1 200 OK
Content-Type: Application/json
{
  "user_id" => 123,
  "id" => "456",
  "data" => "some new text"
}
```
