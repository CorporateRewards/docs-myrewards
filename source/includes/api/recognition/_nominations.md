## Nominations

### Update a Nomination's status

An endpoint to update a status of a nomination for a given campaign, by passing
a status parameter. A valid approver for the nomination must also be provided.
You will be returned the updated JSON for the given nomination.

``` http
PATCH /api/v2/campaigns/:campaign_id/nominations/:id HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "transition" : "approve",
  "approver" : 123
}
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id" : "1",
  "state" : "approved_l1",
}
```

``` http
PATCH /api/v2/campaigns/:campaign_id/nominations/:id HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "transition" : "decline",
  "approver" : 123,
  "declined_reason" : "Already nominated"
}
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id" : "1",
  "state" : "declined_l1",
  "declined_reason" : "Already nominated"
}
```

#### HTTP Request

`PATCH /api/v2/campaigns/:campaign_id/nominations/:id`

#### URL Parameters

Attribute | Type | Info
--------- | ---- | ----
id | `integer` | (required) nomination id
campaign_id | `integer` | (required) campaign id

#### Body Parameters

Attribute | Type | Info
--------- | ---- | ----
approver | `integer` | (required) the approver's user id
reason | `string` | (optional) string which can be provided when declining a nomination
transition | `string` | (required) a valid transition to be performed on the award (`approve` or `decline` only)

#### Approver Information

The approver should be a valid approver for the nomination, and for the approver level.

#### Reason Information

When declining a nomination an optional string can be provided. This is saved to
the nomination when it is declined.

#### State Transition Information

Nominations can only transition to a state allowed by its current
state. For example an award with state 'pending_l1' can transition to
'approved_l1' but not to 'approved_l2'. Only "approve" or "decline" can be provided to the API.
