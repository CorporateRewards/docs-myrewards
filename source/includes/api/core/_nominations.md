## Nominations

### Update a Nomination's status

An endpoint to update a status of a nomination for a given campaign. By passing
a status parameter. An approver for the nomination must also be provided. 
You will be returned the updated JSON for the given nomination.

``` http
PATCH /api/v2/campaigns/:campaign_id/nominations HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "campaign_id" : 1,
  "id" : 1,
  "status" : "approved"
}
```

#### HTTP Request

`PATCH /api/v2/campaigns/:campaign_id/nominations`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
id | integer | nomination id
campaign_id | integer | campaign id
status | string | a valid status that the nomination can transition to
approver | string | the approver's identifier (email or username)
reason | string | an optional string which can be provided when declining a nomination
