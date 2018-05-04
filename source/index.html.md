---
title: MyRewards - API Reference

language_tabs:

includes:
- api/kittens
- api/performance_categories
- api/performance_module
- api/performance_products
- api/registration_questions
- api/reward_ipv
- api/site_messages
- api/transactions
- api/user_groups
- api/users

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
RESTful json endpoints that will accept eithey r HTML/HTTP form data or json data,
HTML/HTTP is preferred.

# Authentication

In order to use our API endpoints, you will need to have an API key created and
for this key to be granted the relevant permissions. To authenticate requests we
require you to pass us this key in the form of an HTTP header called
`Authorization` with the value set as `Token token=APIKEY` or `TOKEN
token=APIKEY:SECRETKEY`.

<aside class="warning">You must set the <strong>Authorization</strong> as detailed above</aside>
