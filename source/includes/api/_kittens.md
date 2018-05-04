# Kittens

Explain what a Kitten is and why you would want to create / delete them.

## Get All Kittens

This endpoint retrieves all kittens.

### HTTP Request

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

`GET /api/v2/kittens`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
include\_cats | false | If set to true, the result will also include cats.
available | true | If set to false, the result will include kittens that have already been adopted.

<aside class="success">
Remember — a happy kitten is an authenticated kitten!
</aside>

## Create a Kitten

Create a new Kitten.

### HTTP Request

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

`POST /api/v2/kittens`

### Attributes

Attribute | Type | Description
--------- | ---- | -----------
name | integer | the ID of the user who will receive the message
breed | string | content of message 
fluffiness | integer | how fluffy? (1-10)
cuteness | integer | how cute? (1-10)
 

## Get a Specific Kitten

Returns the specific kitten from the {id}

### HTTP Request

> Header:

```http
GET /api/v2/kittens/{id} HTTP/1.1
Authorization: Token token=key:secret
Content-Type: application/json
```

> Returns JSON structured like this:

```json
{
  "id": 2,
  "name": "Max",
  "breed": "unknown",
  "fluffiness": 5,
  "cuteness": 10
}
```

`GET api/v2/kittens/{id}`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the kitten to retrieve


## Delete a Specific Kitten

Deletes the kitten with the given ID

### HTTP Request

> Header 
```http
GET /api/v2/kittens/{id} HTTP/1.1
Authorization: Token token=key:secret
Content-Type: application/json
```
```json
{
  "id": 2,
  "deleted" : ":("
}
```

This endpoint deletes a specific kitten.

### HTTP Request

`DELETE /api/v2/kittens/{ID}`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the kitten to delete

