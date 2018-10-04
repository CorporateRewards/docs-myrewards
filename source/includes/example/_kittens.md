# Kittens

Explain what a Kitten is and why you would want to create / delete them.

## Create a Kitten

> Header:

```http
POST /api/v2/kittens/ HTTP/1.1
Authorization: Token token=key:secret
Content-Type: application/json
```

> Body:

```json
{
  "name": "Mr Fluffles",
  "breed": "unknown",
  "fluffiness": 5,
  "cuteness": 10
}
```

> Response:

```json
{
  "id": 3,
  "name": "Mr Fluffles",
  "breed": "unknown",
  "fluffiness": 5,
  "cuteness": 10
}
```

Create a new Kitten.

#### HTTP Request

`POST /api/v2/kittens`

#### Body Parameters

Parameter | Type | Description
--------- | ---- | -----------
name | integer | the ID of the user who will receive the message
breed | string | content of message
fluffiness | integer | how fluffy? (1-10)
cuteness | integer | how cute? (1-10)

## Get a Kitten

> Header:

```http
GET /api/v2/kittens/:id HTTP/1.1
Authorization: Token token=key:secret
Content-Type: application/json
```

> Response:

```json
{
  "id": 2,
  "name": "Max",
  "breed": "unknown",
  "fluffiness": 5,
  "cuteness": 10
}
```

Returns the specific kitten from the :id

#### HTTP Request

`GET api/v2/kittens/:id`

#### URL Parameters

Parameter | Type | Description
--------- | ---- | -----------
id | integer | The ID of the kitten to retrieve


## Get all Kittens


> Header:

```http
GET /api/v2/kittens HTTP/1.1
Authorization: Token token=key:secret
Content-Type: application/json
```

> Response:

```json
[
  {
    "id": 1,
    "name": "Fluffums",
    "breed": "calico",
    "fluffiness": 6,
    "cuteness": 7
  },
  {
    "id": 2,
    "name": "Max",
    "breed": "unknown",
    "fluffiness": 5,
    "cuteness": 10
  }
]
```

This endpoint retrieves all kittens.

#### HTTP Request

`GET /api/v2/kittens`

#### Body Parameters

Parameter | Type | Description
--------- | ------- | -----------
include\_cats | boolean | If set to true, the result will also include cats.
available | boolean | If set to false, the result will include kittens that have already been adopted.

<aside class="success">
Remember — a happy kitten is an authenticated kitten!
</aside>



## Delete a Kitten

> Header

```http
GET /api/v2/kittens/:id HTTP/1.1
Authorization: Token token=key:secret
Content-Type: application/json
```

> Response:

```json
{
  "id": 2,
  "deleted" : ":("
}
```

Deletes the kitten with the given :id

#### HTTP Request

`DELETE /api/v2/kittens/:id`

#### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the kitten to delete
