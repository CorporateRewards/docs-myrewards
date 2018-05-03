# Site Messages

## Get All Site Messages

> Returns JSON structured like this:

```json
[
  {
    "id": 1,
    "user_id": 68,
    "content": "Hello Fred. You have <strong>won a prize</string>. Please visit the points area for more details.",
    "created_at": "2016-03-18T02:20:02.000+00:00"
  },
  {
    "id": 2,
    "user_id": 69,
    "content": "Your Order is on it's way",
    "created_at": "2017-08-16T07:58:03.000+01:00"
  }
]
```

This endpoint retrieves all site messages for a user.

### HTTP Request

`GET /api/v2/users/{user_id}/site_messages`

## Get a Specific Site Message

> Returns JSON structured like this:

```json
{
  "id": 2,
  "user_id": 68,
  "content": "Hello Fred. You have <strong>won a prize</string>. Please visit the points area for more details.",
  "created_at": "2016-03-18T02:20:02.000+00:00"
}
```

This endpoint retrieves a specific site message.

### HTTP Request

`GET /api/v2/users/{user_id}/site_messages/{id}`

### URL Parameters

Parameter | Description
--------- | -----------
user\_id | The ID of the user
id | The ID of the site message to retrieve

## Create a Site Message

> Returns JSON structured like this:

```json
{
  "id": 2,
  "user_id": 68,
  "content": "Hello Fred. You have <strong>won a prize</string>. Please visit the points area for more details.",
  "created_at": "2016-03-18T02:20:02.000+00:00"
}
```

This endpoint creates a new site message for a user.

### HTTP Request

`POST /api/v2/users/{user_id}/site_messages`

### URL Parameters

Parameter | Description
--------- | -----------
user\_id | the ID of the user who will receive the message
content | the content of message 
 
