## Nominations

### Update a Nomination's status

An endpoint to update a status of a nomination for a given campaign. By passing
a status parameter. An approver for the nomination must also be provided. 
You will be returned the updated JSON for the given nomination.

``` http
PATCH /api/v2/campaigns/:campaign_id/nominations/:id HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "transition" : "approve",
  "approver" : "approver@approver-myrewards.co.uk"
}
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id" : "1",
  "state" : "approved_l1",
  "approver" : "approver@approver-myrewards.co.uk"
}
```

#### HTTP Request

`PATCH /api/v2/campaigns/:campaign_id/nominations/:id`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | (required) nomination id
approver | string | (required) the approver's identifier (email or username)
campaign_id | integer | (required) campaign id
reason | string | (optional) string which can be provided when declining a nomination
transition | string | (required) a valid transition to be performed on the award (see valid transition types below)

### Approver Information

The Approver passed into the Api needs to be a valid approver for the
nomination.

### Reason Information

When declining a nomination an optional string can be provided. This is saved to
the nomination when it is declined.

### State Transition Information

Nominations can only transition to a state that is allowed by it's current
state. For example an award with state 'pending_l1' can transition to
'approved_l1' but not to 'approved_l2'. Below is a list of transitions
the api can make, depending on current nomination state.

#### approve
`pending_l1 => approved_l1`

#### decline
`pending_l1 => declined_l1`

#### approve
`pending_l2 => approved_l2`

#### decline
`pending_l2 => declined_l2`
