## Allocated Claim Declines

### Declining a Claim Request

Endpoint to decline a given allocated claim.

``` http
POST /api/v2/performance/promotions/1/allocated_claims/1/decline HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "reason_for_decline": 'An id or a free text reason'
}
```

``` http
HTTP/1.1 201 Created
Content-Type: application/json
```
#### HTTP Request

`POST /api/v2/performance/promotions/1/allocated_claims/1/decline`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
reason\_for\_decline | `string` | The ID of a reason belonging to the promotion or a string containing a custom reason for decline.
