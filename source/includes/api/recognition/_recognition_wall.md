## Recognition Wall

### Get Recognition Wall

This endpoint returns wall posts from the recognition wall on your programme (if activated). Results are paginated at 100 wall posts per page and can be filtered down by the specified query parameters. Results will be returned from newest to oldest.

> Request:

``` http
GET /api/v2/recognition/recognition_wall HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
  "campaign_ids" : "1,2,3",
  "award_id" : 123,
  "receiver_id": 508,
  "sender_id": 510,
  "created_at_date": 2022-01-31,
  "created_at_end_date": 2022-02-28,
  "page": 1,
  "locale": "fr"
}
```


> Response:

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
    {
        "id": 11914,
        "award_id": 4723,
        "campaign_id": 194,
        "sender_id": 508,
        "receiver_id": 508,
        "user_group_id": 351,
        "image": null,
        "content": "<p>Joe<br />\r\Bloggs<br />\r\njoe@bloggs.com<br />\r\n27/04/2022<br />\r\n<br />\r\n0<br />\r\n27/04/2022<br />\r\n-<br />\r\n-<br />\r\n-<br />\r\n-<br />\r\n-<br />\r\n-<br />\r\n<a href='https://yourdomainname.com/liquid/recognition/4723/view_submission' target='_blank'>View Submission</a><br />\r\n<a href='https:/yourdomainname.com/pdf/awards/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NDcyMywic3ViIjoiQXdhcmQifQ.uMTNhhnGCOJMwNDuOXDyFqdxKJvrf2B0jogdWYZfFQg/export_pdf.pdf' target='_blank'>Click here</a><br />\r\n</p>\r\n",
        "created_at": "2022-04-27T10:02:59.000+01:00",
        "updated_at": "2022-04-27T10:02:59.000+01:00",
        "likes": 3,
        "comments": []
    },
    {
        "id": 11913,
        "award_id": 4722,
        "campaign_id": 136,
        "sender_id": 511,
        "receiver_id": 508,
        "user_group_id": 351,
        "image": "https:/yourdomainname.com/s3/W1siZiIsIjIwMjIvMDQvMjcvMDgvNTQvNDkvYzNmMDNlMGItYzU1Ni00YmMxLWI4MzgtODQwYWZmODljOWIyL3N0b2NrLXZlY3Rvci12ZWN0b3ItZGFyay1ibHVlLXNlYW1sZXNzLXBhdHRlcm4td2l0aC1nb2xkLWZvaWwtY29uc3RlbGxhdGlvbnMtc3RhcnMtYW5kLWNsb3Vkcy13YXRlcmNvbG9yLW5pZ2h0LTEzMzE1Njc3OTIuanBnIl1d?sha=809982617de31702",
        "content": "<p>Thanks</p>\r\n",
        "created_at": "2022-04-27T09:58:42.000+01:00",
        "updated_at": "2022-04-27T09:58:42.000+01:00",
        "likes": 0,
        "comments": [
            {
                "user_id": 511,
                "comment": "Smashing work"
            },
            {
                "user_id": 505,
                "comment": "Wow, nice"
            }
        ]
    }
]
```


#### HTTP Request

`GET /api/v2/recognition/recognition_wall`

#### Query Parameters

Attribute | Type | Info
--------- | ---- | ----
campaign_ids | `string` |  Optional. ID or ID's of programme campaigns to restrict wall post activity to.
award_id | `integer` |  Optional. ID of the award the wall post activity relates to.
receiver_id | `integer` |  Optional. ID of the user the wall post activity relates to.
sender_id | `integer` |  Optional. ID of the sender the wall post activity relates to.
created_at_date | `date` |  Optional. A parameter for scoping content that was created from that date onwards. Must be provided in ISO 8601 date format `YYYY-MM-DD`.
created_at_end_date | `date` |  Optional. A parameter for scoping content that was created on or before the given date. Must be provided in ISO 8601 date format `YYYY-MM-DD`.
page | `integer` |  Optional. The requested page number. Defaults to page 1 if not supplied.
locale | `string` |  Optional. Will return the wall post content in the locale provided. If no locale is provided, the default programme locale will be used

