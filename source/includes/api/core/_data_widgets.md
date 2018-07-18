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
