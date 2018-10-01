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
  "transition" : "approve_l1",
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
id | integer | nomination id
approver | string | the approver's identifier (email or username)
campaign_id | integer | campaign id
reason | string | an optional string which can be provided when declining a nomination
transition | string | a valid transition to be performed on the award (see valid transition types below)

### State Transition Information

Nominations can only transition to status that are allowed by their current
status. For example an award with status 'Pending level 1' can transition to
'Approved level 1' but not to 'Approved level 2'. Below is a list of transitions
the api can make, depending on current nomination status.

#### approve_l1
`pending_l1 => approved_l1`

#### decline_l1
`pending_l1 => declined_l1`

#### override_pending_l2
`pending_l1 => pending_l2`

#### approve_l2
`pending_l2 => approved_l2`

#### decline_l2
`pending_l2 => declined_l2`
