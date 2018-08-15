---
title: MyRewards - API Reference

language_tabs:

includes:
# - example/kittens
- api/core/0_core
- api/core/registration_questions
- api/core/permissions
- api/core/user_group_permissions
- api/core/user_permissions
- api/core/site_messages
- api/core/transactions
- api/core/user_groups
- api/core/users
- api/extra_features/0_extra_features
- api/extra_features/data_widgets
- api/performance/0_performance
- api/performance/data_fields
- api/performance/performance_categories
- api/performance/performance_products
- api/performance/sales_data
- api/reward/0_reward_module
- api/reward/ipv

search: true
---

# Introduction
Welcome to the MyRewards API documentation.

The first thing you will have to find out is the correct API endpoint to use for
the right environment.

- **Staging:** [https://staging.my-rewards.co.uk](https://staging.my-rewards.co.uk)
- For production access please ask your Corporate Rewards contact

A programme can have one or more API keys, each of which will be granted
permission to access different functionality from the API. As a standard, we use
RESTful json endpoints that will accept either HTML/HTTP form data or json data,
HTML/HTTP is preferred.

# Authentication

In order to use our API endpoints, you will need to have an API key created and
for this key to be granted the relevant permissions. To authenticate requests we
require you to pass us this key in the form of an HTTP header called
`Authorization` with the value set as `Token token=APIKEY` or `Token token=APIKEY:SECRETKEY`.

<aside class="warning">You must set the <strong>Authorization</strong> as detailed above</aside>
