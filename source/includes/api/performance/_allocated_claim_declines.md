## Allocated Claim Declines

### Declining a Claim Request

Endpoint to decline a given allocated claim.

``` http
POST /api/v2/performance/promotions/1/allocated_claims/1/decline HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "reason_for_decline_id": "An id for a decline reason",
  "reason_for_decline_text": "Some reason text string"
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
reason\_for\_decline\_id | `string` | The ID of a reason belonging to the promotion. Mandatory if decline reasons enabled on programme.
reason\_for\_decline\_text | `string` | A text string for a decline reason, can only be provided if the promotion allows free text decline reasons. Optional.
