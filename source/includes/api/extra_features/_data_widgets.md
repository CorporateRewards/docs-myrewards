## Data Widgets

A Data Widget is used to show user specific information or data uploaded into
the data widgets area. 

### Get all Data Widgets

> Header:

``` http
GET /api/v2/data_widgets HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```
> Response:

```json
[
  {
    "id": 1234,
    "name": "text"
  },
  {
    "id": 4567,
    "name": "some other text"
  }
]
```

This endpoint retrieves all data_widgets that belong to a programme (scoped by api key)

#### HTTP Request

`GET /api/v2/data_widgets`


### Get a Data Widget belonging to a User

> Header:

``` http
GET /api/v2/users/{user_id}/data_widgets/{id} HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```

> Response

```json
{
    "id": 456,
    "name": "Data widget name",
    "user_data_widget": {
        "user_id": 123,
        "data": "this is some text"
    }
}
```

Returns the specific data_widget & user_data_widget data for the user specified { user_id } and the
{ id } specified.

#### HTTP Request

`GET api/v2/users/{user_id}/data_widgets/{id}`

#### Parameters

Parameter | Type | Description
--------- | ---- | -----------
user_id | integer | The ID of the user you want to retrieve data for
id | integer | The ID of the data_widget to retrieve

### Update a Data Widget belonging to a User

> Header:

``` http
PUT /api/v2/users/{user_id}/data_widgets/{id} HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```

> Body: 

```json
{
  "data": "this is some new text"
}
```

> Response:

``` json
{
    "id": 456,
    "name": "Data widget name",
    "user_data_widget": {
        "user_id": 123,
        "data": "this is some new text"
    }
}
```

Update the data of the specific user_data_widget for the user specified { user_id } 
and the { id } specified.

#### HTTP Request

`PUT api/v2/users/{user_id}/data_widgets/{id}`

#### Parameters

Parameter | Type | Description
--------- | ---- | -----------
user_id | integer | The ID of the user you want to update data for
id | integer | The ID of the data_widget to retrieve
data | string | Your desired data string
