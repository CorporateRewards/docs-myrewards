# Reward Instant Point Vouchers (IPV)

## Create a Reward IPV code

Generate Reward IPV codes for Programmes with the Rewards Module. 

#### HTTP Request

`POST /api/v2/reward/codes`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
value | integer | Required, must be a positive integer. Points value of the IPV
description | string | Optional, text field
expiry\_date | date | Required, must be in the future and in the format `YYYY-MM-DD`
sendi\_email | string | Optional, valid email address to which the code will be sent. If provided, the 'Send a code' email messages must be configured. Response will have `issued` set to `true`

```http
POST /api/v2/reward/codes HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
    "value": 1000,
    "description": "Competition winner.",
    "expiry_date": "2025-12-31",
    "send_email": "john.doe@noemail.com"
}
```

```http
HTTP/1.1 201 CREATED
Content-Type: application/json

{
    "id" : 1,
    "value" : 1000,
    "description" : "Competition winner.",
    "expiry_date" : "2025-12-31",
    "send_email" : "john.doe@noemail.com",
    "code_value" : "XXXX-YYYY-ZZZZ",
    "batch_reference" : "SSSS",
    "state" : "active",
    "issued": true,
    "programme_id" : 123,
    "user_id" : 25
}
```

## Get a Reward IPV Code

To view the details of an IPV code.

#### HTTP Request

```http
GET /api/v2/reward/codes/{id} HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json
```

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "id" : 1,
    "value" : 1000,
    "description" : "Competition winner.",
    "expiry_date" : "2025-12-31",
    "send_email" : "john.doe@noemail.com",
    "code_value" : "XXXX-YYYY-ZZZZ",
    "batch_reference" : "SSSS",
    "state" : "active",
    "issued": true,
    "programme_id" : 123,
    "user_id" : 25
}
```

