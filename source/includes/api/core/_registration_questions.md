## Registration Questions

### Get all Registration Questions

> Header:

```http
GET /api/v2/registration_questions HTTP/1.1
Authorization: Token token=xxx
```

> Response:

```json
[
  {
    "id": 1234,
    "label": "text",
    "mandatory": "false",
    "field_type": "radio",
    "options": "text_1 text_2 text_3",
    "field_name" : "field_lavel",
    "free_text": "false"
  }
]
```

A simple endpoint will be created to fetch registration_questions for this
programme (Again scoped by API key). This is potentially optional as a list of
registration_question_ids could be provided, although this list will have to be
managed and maintained carefully. Should any new mandatory fields be added to this list,
it would require development on the client side of the API unless this list can
be dynamically consulted via the api.

#### HTTP Request

`GET /api/v2/registration_questions`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | registration question identifier
label | string | label displayed on the form to the end user
manadatory | boolean | boolean if this question is manadatory for registration
field_type | string | options: [check_box, date_select, radio, select, text, user_group, linked_user]
options | string | options set for a choice question for check_box, select, or radio
field_name | string | the actual field name
free_text | boolean |

