## User Data Widgets

A User Data Widget is used to show user specific information or data uploaded into
the data widgets area. 

### Get a User Data Widget

> Header:

``` http
GET /api/v2/users/123/user_data_widgets/456 HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```

> Response

```json
{
  "user_id": 123,
  "id": 456,
  "data": "text"
}
```

Returns the specific user_data_widget for the user specified { user_id } and the
{ id } specified.

#### HTTP Request

`GET api/v2/users/{user_id}/user_data_widgets/{id}`

#### Parameters

Parameter | Type | Description
--------- | ---- | -----------
user_id | integer | The ID of the user the user_data_widget belongs to
id | integer | The ID of the user_data_widget to retrieve


### Update a User Data Widget

> Header:

``` http
PUT /api/v2/users/123/user_data_widgets/456 HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```

> Body: 

```json
{
  "user_id": 123,
  "id": 456,
  "data": "some new text"
}
```

> Response:

``` json
{
  "user_id": 123,
  "id": 456,
  "data": "some new text"
}
```

Update the data of the specific user_data_widget for the user specified { user_id } 
and the { id } specified.

#### HTTP Request

`PUT api/v2/users/{user_id}/user_data_widgets/{id}`

#### Parameters

Parameter | Type | Description
--------- | ---- | -----------
user_id | integer | The ID of the user the user_data_widget belongs to
id | integer | The ID of the user_data_widget to retrieve
data | string | The desired string for the user_data_widget data column
