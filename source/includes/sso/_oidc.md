## OpenID Connect

MyRewards now supports a limited subset of OpenID Connect for SSO. We currently use the ["implicit flow"](https://openid.net/specs/openid-connect-core-1_0.html#ImplicitFlowAuth), using the [ID token-only response type](https://openid.net/specs/oauth-v2-multiple-response-types-1_0.html#id_token) with the [`form_post` response mode](https://openid.net/specs/oauth-v2-form-post-response-mode-1_0.html). More features from the OpenID Connect specification may be available in the future - please contact your MyRewards representative.

### Process flow

1. User initiates a sign-on request from MyRewards.
2. MyRewards fetches configuration from the discovery URL provided.
3. Using the information from (2), MyRewards redirects the user to the authorization endpoint.
4. User is authenticated by the OpenID Connect provider.
5. JWT ID token is `POST`-ed back to MyRewards as a URL-encoded form body.
6. MyRewards validates the ID token and redirects the user to a holding page whilst profile provisioning is completed via a back channel.
7. Session established on MyRewards and user is granted access.

> Process flow example requests/responses

> (2) Fetch configuration from discovery URL:

```http
GET /.well-known/openid-configuration HTTP/1.1
Host: openid-connect-provider.example.com
```

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "issuer": "https://openid-connect-provider.example.com",
    "authorization_endpoint": "https://openid-connect-provider.example.com/authorize",
    "jwks_uri": "https://openid-connect-provider.example.com/jwks",
    "response_types_supported": ["id_token"],
    "subject_types_supported": ["public"],
    "id_token_signing_alg_values_supported": ["RS256"],
    "scopes_supported": ["openid", "email"],
    "response_modes_supported": ["form_post"]
}
```

> (3) Redirect to authorization endpoint:

```http
HTTP/1.1 303 Found
Location: https://openid-connect-provider.com/authorize?response_type=...
```

```http
GET /authorize?
response_type=id_token
&response_mode=form_post
&client_id=client_id_goes_here
&scope=openid%20email
&redirect_uri=https%3A%2F%2Fmyrewards-programme.example.com%2Fusers%2Fauth%2Fopenid_connect%2Fcallback
&state=random-value-from-myrewards
&nonce=another-random-value-from-myrewards HTTP/1.1
Host: openid-connect-provider.example.com
```

> (5) `POST` ID token back to MyRewards:

```http
POST /users/auth/openid_connect/callback HTTP/1.1
Host: openid-connect-provider.example.com
Content-Type: application/x-www-form-urlencoded

id_token=jwt.appears.here
&state=random-value-from-myrewards
```

> Second part of JWT:

```json
{
    "iss": "http://server.example.com",
    "sub": "1234567890",
    "aud": "client_id_goes_here",
    "nonce": "another-random-value-from-myrewards",
    "exp": 1311281970,
    "iat": 1311280970,
    "email": "user@example.com"
}
```

### Implementation notes

#### Configuration discovery

For ease of configuration, and to aid in dynamic configuration changes from the OpenID Connect provider, MyRewards relies on discovery to find most of the configuration values for the provider. To that end, you will need to configure your programme with a "discovery URL", which should be a [domain (or domain with a path)](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfig) that has the path `/.well-known/openid-configuration`, from which MyRewards will attempt to load the configuration of your OpenID implementation.

This should have the [following fields](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata) as a minimum (these are all marked as "REQUIRED" by the spec so it is likely your implementation will already have them):

- `issuer`
- `authorization_endpoint`
- `jwks_uri`
- `response_types_supported` - should include `id_token`
- `subject_types_supported` - should include `public`
- `id_token_signing_alg_values_supported`

In addition, if the `response_types_supported` field is included, it should include `form_post`.

MyRewards does not currently support using [WebFinger](https://openid.net/specs/openid-connect-discovery-1_0.html#IssuerDiscovery) to obtain the discovery endpoint.

### ID token

MyRewards uses the `sub` field from the ID token as the unique user identifier, and populates the "username" registration question with its value. The `email` field is also extracted and its value used for the "email" registration question. Due to the dynamic nature of user data on MyRewards, other fields will need to be provided via a side channel (e.g. the [update user API](#core-users-update-a-user)).

### Next steps

The following information is required to set up OpenID Connect SSO on the MyRewards system:

- Discovery URL - as described above
- Client ID
- Client secret
- A URL to redirect users on login failure (this is typically a content page on the MyRewards programme itself)

### Further information

For further information on OpenID Connect please refer to the official documentation:

- [https://openid.net/connect](https://openid.net/connect/)
- [https://openid.net/specs/openid-connect-core-1_0.html](https://openid.net/specs/openid-connect-core-1_0.html)
