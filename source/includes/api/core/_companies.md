## Companies

### Get all companies

This endpoint returns all companies associated to an api keys programme. Results are paginated and return 100 records per page and can be paged through by passing a page query parameter. If no page parameter is passed, then page 1 with the first 100 records will be returned.

#### HTTP Request

`GET /api/v3/companies`

#### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
page | integer | The page number that you wish to view

> Request:

``` http
GET /api/v3/companies?page=1 HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Response:

``` http
HTTP/1.1 200 OK
Content-Type: Application/json

[
  {
    "id": 1423,
    "name" : "Company A",
    "identifier" : "company-a-identifier",
    "disabled" : false,
    "earning_type" : "individual",
    "created_at" : "2021-03-18T02:20:02.000+00:00",
    "updated_at" : "2021-03-19T03:20:09.000+00:00",
  },
  {
    "id": 1477,
    "name" : "Company B",
    "identifier" : "company-b-identifier",
    "disabled" : true,
    "earning_type" : "company",
    "created_at" : "2021-03-18T02:20:06.000+00:00",
    "updated_at" : "2021-03-20T13:42:17.000+00:00",
  }
]
```

### Get a specific company

This endpoint returns a specific company associated to an api keys programme.

#### Path Parameters

Parameter | Type | Description
--------- | ---- | -----------
company_identifier | string | The identifier of the company you want to return

#### HTTP Request

`GET /api/v3/companies/{company_identifier}`

> Request:

``` http
GET /api/v3/companies/company-b-identifier HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json
```

> Response:

``` http
HTTP/1.1 200 OK
Content-Type: Application/json

{
  "id": 1477,
  "name" : "Company B",
  "identifier" : "company-b-identifier",
  "disabled" : true,
  "earning_type" : "company",
  "created_at" : "2021-03-18T02:20:06.000+00:00",
  "updated_at" : "2021-03-20T13:42:17.000+00:00",
}
```

### Create a company

This endpoint creates a new company associated to an api keys programme.

#### HTTP Request

`POST /api/v3/companies`

> Request:

``` http
POST /api/v3/companies HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
    "name": "Company name",
    "identifier": "company-identifier",
    "disabled": "N",
    "earning_type": "company"
}
```

> Response:

``` http
HTTP/1.1 200 OK
Content-Type: Application/json

{
  "id": 123,
  "name": "Company name",
  "identifier": "company-identifier",
  "disabled": false,
  "earning_type": "company",
  "created_at": "2021-03-18T02:20:06.000+00:00",
  "updated_at": "2021-03-18T02:20:06.000+00:00"
}
```

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
name | `string` | Mandatory. The name of the company.
identifier | `string` | Mandatory. The unique identifier for the company.
disabled | `string` | Mandatory. The disabled status of the company. One of 'Y' for disabled or 'N' for not disabled.
earning_type | `string` | Optional. The earning type of the company. Must be one of 'individual' or 'company'. If not provided, company will be set with the 'individual' earning type.


### Update a company

This endpoint updates an existing company associated to an api keys programme.
#### HTTP Request

`PATCH /api/v3/companies/{company_id}`

> Request:

``` http
PATCH /api/v3/companies/{company_id} HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

{
    "name": "New company name",
    "identifier": "new-company-identifier",
    "disabled": "Y",
    "earning_type": "individual"
}

```

> Response:

``` http
HTTP/1.1 200 OK
Content-Type: Application/json

{
  "id": 123,
  "name": "New company name",
  "identifier": "new-company-identifier",
  "disabled": true,
  "earning_type": "individual",
  "created_at": "2021-03-18T02:20:06.000+00:00",
  "updated_at": "2021-03-20T13:42:17.000+00:00",
}
```

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
name | `string` | The name of the company.
identifier | `string` | The unique identifier for the company.
disabled | `string` | The disabled status of the company. One of 'Y' for disabled or 'N' for not disabled.
earning_type | `string` | The earning type of the company. Must be one of 'individual' or 'company'.


### Delete a company

This endpoint deletes an existing company associated to an api keys programme. You can only delete companies that have no associated users, and any attempt to do so will return an error.
#### HTTP Request

`DELETE /api/v3/companies/{company_id}`

> Request:

``` http
DELETE /api/v3/companies/{company_id} HTTP/1.1
Authorization: Token token={APIKEY}:{SECRETKEY}
Content-Type: application/json

```

> Response:

``` http
HTTP/1.1 204 No Content
Content-Type: Application/json
```
#### URL Parameters

Parameter | Description
--------- | -----------
company_id | The ID of the company to delete
