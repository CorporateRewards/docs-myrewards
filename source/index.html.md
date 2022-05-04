---
title: MyRewards - API Reference

language_tabs:

includes:
# - example/kittens
- api/core/0_core
- api/core/permissions
- api/core/registration_questions
- api/core/registration_questions_list_of_values
- api/core/site_messages
- api/core/transactions
- api/core/user_groups
- api/core/user_groups_permissions
- api/core/users
- api/core/users_permissions
- api/core/companies
- api/extra_features/0_extra_features
- api/extra_features/data_widgets
- api/extra_features/target_trackers
- api/performance/0_performance
- api/performance/allocated_claims
- api/performance/self_claims
- api/performance/data_fields
- api/performance/performance_categories
- api/performance/performance_products
- api/performance/reward_points
- api/performance/sales_data
- api/recognition/0_recognition
- api/recognition/recognition_wall
- api/recognition/nominations
- api/recognition/submissions
- api/reward/0_reward_module
- api/reward/ipv
- api/reward/points_overrides
- sso/0_sso
- sso/saml
- sso/oidc
- api/deprecated/0_deprecated
- api/deprecated/users_v2


search: true
---

# Introduction
Welcome to the MyRewards API documentation.

The first thing you will have to find out is the correct API endpoint to use for
the right environment.

- **Staging:** [https://staging.my-rewards.co.uk](https://staging.my-rewards.co.uk)
- For production access please ask your MyRewards contact

A programme can have one or more API keys, each of which will be granted
permission to access different functionality from the API. As a standard, we use
RESTful json endpoints that will accept either HTML/HTTP form data or json data,
HTML/HTTP is preferred.

# Authentication

## Token
In order to use our API endpoints, you will need to have an API key created and
for this key to be granted the relevant permissions. To authenticate requests we
require you to pass us this key in the form of an HTTP header called
`Authorization` with the value set as `Token token=APIKEY` or `Token token=APIKEY:SECRETKEY`.


## Authentication
An API key now requires permissions to be assigned in order make any requests to the API. The issuer of your key will set permissions for endpoints you expect to access. If you need to access more of the API or you believe your permissions are not correct (unexpected 403 responses) then contact your key issuer.

Getting read access (GET) to an API endpoint does not mean that you will also have any kind of write access (PUT, PATCH, POST) and vice versa - these are separate permissions.

Permissions are granted on a 'least privilege' basis in order to restrict access to the API functionality to just what is needed for a given use case i.e. user account provisioning or sales data integration etc.

<aside class="warning">You must set the <strong>Authorization</strong> as detailed above</aside>
