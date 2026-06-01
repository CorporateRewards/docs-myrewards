# MyRewards Documentation

## Adding an end-point
- create a file in `source/includes/api/{module}`
- use the structure, language and style from `/includes/example/_kittens.md`
- add the file to `includes:` section of `index.html.md` (alphabetically)

Once the changes have been made, create a PR to master. When the PR is merged, GitHub Actions will pickup the changes and deploy.

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

## Testing Locally

### Requirements
- Git
- Docker with compose

### Steps
1. Clone the repo.
2. Run `docker compose build` at least once to build the images.
3. Run `docker compose up` to start the slate instance container.
4. Visit `http://localhost/` in your browser.
5. Make changes to the markdown files in the `source` folder.
6. Refresh the browser to see the changes.
7. When done, run `docker compose down` to stop the container.
