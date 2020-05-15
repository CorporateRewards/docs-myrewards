## Registration Questions > List of Values

### GET List of Values associated with a registration question

An endpoint to fetch the list of values associated with a registration question. Returns
an array of values with their name and id.

> Header:

```http
GET /api/v2/registration_questions/:registration_question_id/list_of_values HTTP/1.1
Authorization: Token token=key:secret
```

> Response:

```json
[
  {
    "id": 1,
    "name": "List value 1"
  },
  {
    "id": 2,
    "name": "List value 2"
  }
]
```

#### HTTP Request

`GET /api/v2/registration_questions/:registration_question_id/list_of_values`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | List value id
name | string | List value name
