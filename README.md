# MyRewards Documentation

## Adding an end-point
- create a file in `/includes/api/`
- use the structure, language and style from `/includes/api/_kittens.md` 
- add the file to `includes:` section of `index.html.md` (alphabetically)

Once the changes have been made, creare a PR to master. When the PR is merged, CircleCI will pickup the changes and deploy.

## Standards

- HTTP Requests should just be the path, not the full URL, and use curly brackets for params, e.g.: `GET /api/v2/users/{user_id}/site_messages`

