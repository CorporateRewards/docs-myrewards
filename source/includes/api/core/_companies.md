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
Authorization: Token token=xxx
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

`GET /api/v3/companies/:company_identifier`

> Request:

``` http
GET /api/v3/companies/company-b-identifier HTTP/1.1
Authorization: Token token=xxx
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