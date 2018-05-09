# MyRewards Documentation

## Adding an end-point
- create a file in `/includes/api/{module}`
- use the structure, language and style from `/includes/example/_kittens.md` 
- add the file to `includes:` section of `index.html.md` (alphabetically)

Once the changes have been made, creare a PR to master. When the PR is merged, CircleCI will pickup the changes and deploy.

## Sections

Sections should appear in the following order (think CRUD):

- H1 (#) {Module Name}
- H2 (##) {Model}
- General description of the model
- H3 (###) Create a {Model}
- H3 (###) Get a {Model}
- H3 (###) Get all {Model}s
- H3 (###) Update a {Model}
- H3 (###) Delete a {Model}

Each section should contain the following elements in this order:

- `> Header:`
- `> Body:` (POST only)
- `> Response:` 
- Description of the end point
- H4 (####) HTTP Request
- GET/POST/DELETE
- H4 (####) Request Parameters 
  - _if there are URL and Body params, then create two more sections:_
  - H5 (#####) URL Parameters 
  - H5 (#####) Body Parameters
- H4 (####) Response Parameters
 

