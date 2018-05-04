# MyRewards Documentation

## Adding an end-point
- create a file in `/includes/api/{module}`
- use the structure, language and style from `/includes/example/_kittens.md` 
- add the file to `includes:` section of `index.html.md` (alphabetically)

Once the changes have been made, creare a PR to master. When the PR is merged, CircleCI will pickup the changes and deploy.

## Sections

Sections should appear in the following order (think CRUD):

- H1 (#) {Model}
- General description of the model
- H2 (##) Create a {Model}
- H2 (##) Get a {Model}
- H2 (##) Get all {Model}s
- H2 (##) Update a {Model}
- H2 (##) Delete a {Model}
* the H1s and H2s above would need to be H2s and H3s if the model is nested
in a module such a `# Performance Module`


Each section should contain the following elements in this order:

- `> Header:`
- `> Body:` (POST only)
- `> Response:` 
- Description of the end point
- H4 (####) HTTP Request
- GET/POST/DELETE
- Parameters
 

