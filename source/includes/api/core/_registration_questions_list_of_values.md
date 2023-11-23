## Registration Questions > List of Values

### GET List of Values associated with a registration question

An endpoint to fetch the list of values associated with a registration question. Returns
an array of values with their name and id.

> Header:

```http
GET /api/v2/registration_questions/{registration_question_id}/list_of_values HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
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

`GET /api/v2/registration_questions/{registration_question_id}/list_of_values`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | List value id
name | string | List value name


### POST Create a new value on a list of values associated with a registration question

An endpoint to create a new list value for a registration question. On completion, returns
an array of all values with their name and id.

> Header:

```http
POST /api/v2/registration_questions/{registration_question_id}/list_of_values HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Body:

```json
{
    "name": "My new list value"
}
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
  },
  {
    "id": 3,
    "name": "My new list value"
  }
]
```

#### HTTP Request

`POST /api/v2/registration_questions/{registration_question_id}/list_of_values`

##### Body Parameters

Parameter | Type | Description
--------- | ---- | -----------
name | string | the name of the new list value
