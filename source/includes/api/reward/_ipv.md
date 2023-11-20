## Instant Point Vouchers (IPV)

### Create an IPV 

> Header:

```http
POST /api/v2/reward/codes HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Body:

```json
{
    "value": 1000,
    "description": "Competition winner.",
    "expiry_date": "2025-12-31",
    "send_email": "john.doe@noemail.com"
}
```

> Response: 

```json
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

Generate Reward IPV codes for Programmes with the Rewards Module. 

#### HTTP Request

`POST /api/v2/reward/codes`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
value | integer | Required, must be a positive integer. Points value of the IPV
description | string | Optional, text field
expiry\_date | date | Required, must be in the future and in the format `YYYY-MM-DD`
send\_email | string | Optional, valid email address to which the code will be sent. If provided, the 'Send a code' email messages must be configured. Response will have `issued` set to `true`



### Get an IPV 

> Header: 

```http
GET /api/v2/reward/codes/{id} HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Response: 

```json
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

To view the details of an IPV code.

#### HTTP Request

`GET /api/v2/reward/codes/{id}`


