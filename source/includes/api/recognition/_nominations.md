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
  "status" : "approved_l1",
  "approver" : "approver@approver-myrewards.co.uk"
}
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id" : "1",
  "status" : "approved_l1",
  "approver" : "approver@approver-myrewards.co.uk"
}
```

#### HTTP Request

`PATCH /api/v2/campaigns/:campaign_id/nominations/:id`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | nomination id
campaign_id | integer | campaign id
status | string | a valid status that the nomination can transition to
approver | string | the approver's identifier (email or username)
reason | string | an optional string which can be provided when declining a nomination

### State Transition Information

Nominations can only transition to status that are allowed by their current
status. For example an award with status 'Pending level 1' can transition to
'Approved level 1' but not to 'Approved level 2'. Below is a list of transitions
the api can make, depending on current nomination status.

####Programme with level 1 approval

`pending_l1 => approved_l1`

`pending_l1 => declined_l1`

####Programme with level 2 approval

`pending_l1 => pending_l2`

`pending_l1 => declined_l1`

`pending_l2 => approved_l2`

`pending_l2 => declined_l2`
