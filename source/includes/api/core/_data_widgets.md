## Data Widgets

### Get all a Programme's Data Widgets

To list all data_widgets that belong to a programme (scoped by api key)

> Header:

``` http
GET /api/v2/data_widgets HTTP/1.1
Authorization: Token token=xxx
```

```json
[
  {
    "id" => 1234,
    "name" => "text"
  }
]
```
