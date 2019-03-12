## Transactions

### Get all Transactions

This endpoint is designed to list all of a user’s transactions in json format.
The points transactions will be debits and credits with a description field.

All transactions listed in the response will be ordered so as to have the most
recent transaction last in the list.

Please remember that if a user transaction is performed on the MyRewards 2.0
platform since a request is made over the api – this balance will be out of date.

On the server side a check will be made that the user_id you are requesting is

- a valid user
- it is a user for the programme that your api key is scoped to.

That is to say that you can only retrieve transactions for users of your
MyRewards Programme.

The remote_transaction_id is documented in the POST endpoint for creating
transactions, this value is optional, therefore can be `null`

``` http
GET /api/v2/users/123/transactions HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 123,
    "user_id" : 123,
    "description" : "transactions",
    "value" : 100,
    "balance" : 100,
    "transaction_type" : "programme points",
    "remote_transaction_id": "your_id_here",
    "created_at" : "date_time"
  }
]
```

#### HTTP Request

`GET /api/v2/users/{user_id}/transactions`

#### Attributes

Parameters | Type | Info
---------- | ---- | ----
id | `integer` | id of this transaction
user_id | `integer` | user id of the user this transaction belongs
description | `string` | transaction description
value | `integer` | can be positive or negative. value of points on the transaction. Credit to the balance will be shown as a positive integer and debits will be negative
balance | `integer` | users running balance, at the time of the transaction
transaction_type | `string` | indicates the event which caused the transaction
remote_transaction_id | `integer` | optional - indicates a remote systems unique identifier for this transaction
created_at | `string` |

### Get last Transaction

This endpoint is designed to show the latest transaction for the given user in
json format. You can use this endpoint to find the user's current balance.

Please remember that if a user transaction is performed on the MyRewards 2.0
platform since a request is made over the api – this balance will be out of date.

On the server side a check will be made that the user\_id you are requesting is

- a valid user
- it is a user for the programme that your api key is scoped to.

That is to say that you can only retrieve the last transaction for users of your
MyRewards Programme.

The remote_transaction_id is documented in the POST endpoint for creating
transactions, this value is optional, therefore can be `null`

``` http
GET /api/v2/users/123/transactions/last HTTP/1.1
Authorization: Token token=xxx
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 123,
  "user_id" : 123,
  "description" : "transactions",
  "value" : 100,
  "balance" : 100,
  "transaction_type" : "programme points",
  "remote_transaction_id": "your_id_here",
  "created_at" : "date_time"
}
```

#### HTTP Request

`GET /api/v2/users/{user_id}/transactions/last`

#### Attributes

Parameters | Type | Info
---------- | ---- | ----
id | `integer` | id of this transaction
user_id | `integer` | user id of the user this transaction belongs
description | `string` | transaction description
value | `integer` | can be positive or negative. value of points on the transaction
balance | `integer` | users running balance, at the time of the transaction
transaction_type | `string` | indicates the event which caused the transaction
remote_transaction_id | `integer` | optional - indicates a remote systems unique identifier for this transaction  |   |
created_at | `string` | datetime indicating when this points transaction was created

### Create a Transaction

**Note this is 'v1' endpoint.** This endpoint is for either crediting or debiting points for a user.
This endpoint will respond with the MyRewards transaction id.
Points transactions have a type of either 'Credit' or 'Debit'.
A points transaction will also have a variety which will be one of:

Variety | Programme Points affecting? | Permitted Type
------- | --------------------------- | --------------
Programme points | Yes | either
Points Error | Yes | either
Redemption | No | Debit only
Person 2 Person Transfer | No | either (credit and debit must both be carried out for each user)
Order Cancellation | No | Credit only
Order Adjustment | No | either
Adjustment | Yes | either
Account Closure | Programme config dependant | Debit only

Example below shows a transaction that will credit 100 points to a user debited from the programme balance. On the user's points statement a reason of 'Employee of the month' will be shown.

``` http
POST /api/v1/users/123/transactions HTTP/1.1
Authorization: Token token=xxx
Content-Type: application/json

{
  "transaction":  {
    "transaction_type": "Credit",
    "variety": "Programme points",
    "points": 100,
    "reason": "Employee of the month",
    "remote_transaction_id": "YOUR_REMOTE_TRANSACTION_ID"
  }
}
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 123
}
```
#### HTTP Request

`POST /api/v1/users/123/transactions`

#### Parameters

Parameters | Type | Info
---------- | ---- | ----
transaction_type | `string` | one of 'Credit' or 'Debit'
variety | `string` | Required - see above table and ensure validity with transaction_type
points | `integer` | Required - always greater than 0
reason | `string` | Required - free text up to 250 characters to describe transaction - appears on user points statement
remote_transaction_id | `string` | Optional - a value that can be used to identify this transaction by the client *Caution - there is no validation or constraints for data supplied under this key/field. This is left to the client system to enforce*

#### Error responses

Anything other than a 200 will mean that the transaction has failed to go through. It may or may not be appropriate to show only a generic message to indicate failure depending on the use case or level of automation. In either case it is recommended to log the error code and any body/message

-  204 User not found
-  401 invalid key
-  402 User does not have enough points
-  406 Invalid Transaction
-  412 Programme does not have enough points
-  500 Server Error


