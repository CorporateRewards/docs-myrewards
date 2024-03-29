## Site Messages

Site message are either plain text or HTML messages that appear in a User's message page. When a user 
logs in they are notified of any unread messages via a pop-up (usually in the bottom right corner)


 
### Create a Site Message

> Header:

```http
GET /api/v2/user/{user_id}/site_messages/{id} HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Body: 

```json
{
    "content": "Hello John. You have <strong>won a prize</strong>. Please visit the points area for more details."
}
```


> Response:

```json
{
  "id": 2,
  "user_id": 123,
  "content": "Hello John. You have <strong>won a prize</strong>. Please visit the points area for more details.",
  "created_at": "2016-03-18T02:20:02.000+00:00"
}
```


This endpoint creates a new site message for a user.

#### HTTP Request

`POST /api/v2/users/{user_id}/site_messages`

#### Request Parameters

##### URL Parameters

Parameter | Type | Description
--------- | ---- | -----------
user\_id | integer | the ID of the user who will receive the message

##### Body Parameters

Parameter | Type | Description
--------- | ---- | -----------
content | string | the content of message 



### Get a Site Message

> Header: 

```http
GET /api/v2/user/{user_id}/site_messages/{id} HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Response:

```json
{
  "id": 2,
  "user_id": 123,
  "content": "Hello John. You have <strong>won a prize</strong>. Please visit the points area for more details.",
  "created_at": "2016-03-18T02:20:02.000+00:00"
}
```

Retrieves a specific site message.

#### HTTP Request

`GET /api/v2/users/{user_id}/site_messages/{id}`

#### Request Parameters

Parameter | Type | Description
--------- | ---- | -----------
user\_id | integer | The ID of the user
id | integer | The ID of the site message to retrieve


 
### Get all Site Messages

> Header: 

```http
GET /api/v2/user/{user_id}/site_messages HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Response:

```json
[
  {
    "id": 1,
    "user_id": 123,
    "content": "Hello John. You have <strong>won a prize</strong>. Please visit the points area for more details.",
    "created_at": "2016-03-18T02:20:02.000+00:00"
  },
  {
    "id": 2,
    "user_id": 123,
    "content": "Your Order is on it's way",
    "created_at": "2017-08-16T07:58:03.000+01:00"
  }
]
```

Retrieves all site messages for a user.

#### HTTP Request

`GET /api/v2/users/{user_id}/site_messages`

#### Request Parameters

Parameter | Type | Description
--------- | ---- | -----------
user\_id | integer | The ID of the user



