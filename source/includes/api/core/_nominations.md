## Nominations

### Update a Nomination's status

An endpoint to update a status of a nomination for a given campaign. By passing
a status parameter of 'approved' or 'declined'. You will be returned the updated
JSON for the given nomination.

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
status | string | either 'approved' or 'declined'
