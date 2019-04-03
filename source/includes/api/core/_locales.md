## Locales

### Get all available locales

> Header:

```http
GET /api/v2/locales HTTP/1.1
Authorization: Token token=xxx
```

> Response:

```json
[
  {
    "internal_code": "ar",
    "iso_code": "ar_SA",
    "name": "Arabic",
    "native_name": "عربى"
  },
  {
    "internal_code": "de",
    "iso_code": "de_DE",
    "name": "German",
    "native_name": "Deutsch"
  },
  {
    "internal_code": "en",
    "iso_code": "en_GB",
    "name": "English",
    "native_name": "English (UK)"
  },
  {
    "internal_code": "en-US",
    "iso_code": "en_US",
    "name": "English (US)",
    "native_name": "English (US)"
  },
  {
    "internal_code": "es",
    "iso_code": "es_ES",
    "name": "Spanish",
    "native_name": "Español"
  },
  {
    "internal_code": "fr",
    "iso_code": "fr_FR",
    "name": "French",
    "native_name": "Français"
  },
  {
    "internal_code": "fr-BE",
    "iso_code": "fr_BE",
    "name": "French (Belgium)",
    "native_name": "Français (Belgique)"
  },
  {
    "internal_code": "it",
    "iso_code": "it_IT",
    "name": "Italian",
    "native_name": "Italiano"
  },
  {
    "internal_code": "nl",
    "iso_code": "nl_NL",
    "name": "Dutch",
    "native_name": "Nederlands"
  },
  {
    "internal_code": "nl-BE",
    "iso_code": "nl_BE",
    "name": "Dutch (Belgium)",
    "native_name": "Nederlands (België)"
  },
  {
    "internal_code": "pl",
    "iso_code": "pl_PL",
    "name": "Polish",
    "native_name": "Polski"
  },
  {
    "internal_code": "tr",
    "iso_code": "tr_TR",
    "name": "Turkish",
    "native_name": "Türkçe"
  }
]
```

This endpoint lists all the supported locales available in MyRewards.

#### HTTP Request

`GET /api/v2/locales`

#### Attributes

Attribute | Type | Info
--------- | ---- | ----
internal_code | string | code used internally by MyRewards to refer to this locale
iso_code | string | The [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) language code and [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2) country code for this locale, joined with an underscore
name | string | The name of this locale in English (optionally with country name in brackets)
native_name | string | The name of this locale in its own language (optionally with country name in brackets)
