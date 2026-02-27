# API Lifecycle & Compatibility Policy

To ensure operational stability for our Enterprise tenants, LumaTrace enforces a strict API lifecycle and versioning governance model.

## 1. Versioning Strategy
We use semantic versioning globally at the API path level (e.g., `/api/v1/`).
* **Non-Breaking Changes:** Additions of new endpoints, optional parameters, or new response properties will be applied to the current version without notice.
* **Breaking Changes:** Any removal of endpoints, required parameters, or changes in response schema will trigger a major version bump (e.g., `/api/v2/`).

## 2. Deprecation & Sunset Windows
When an API version or specific endpoint is scheduled for deprecation, we commit to the following timeline:
* **Announcement:** 12 months prior to the final sunset date. Communication is sent via the Enterprise Status channel and email to registered technical contacts.
* **Deprecation Headers:** Deprecated endpoints will include standard IETF HTTP response headers:
  * `Deprecation: @<timestamp>`
  * `Link: <https://api.lumatrace.es/docs/changelog>; rel="deprecation"`
* **Sunset Phase:** Following the 12-month window, the endpoint will return a `410 Gone` status code.

## 3. Client Requirements
Integration clients MUST ignore unrecognized fields in JSON responses to ensure forward compatibility with non-breaking additions.

## 4. IAM Compatibility Roadmap (Enterprise M2M)
To align with evolving enterprise standards and facilitate frictionless integration with corporate Identity Providers (IdP), LumaTrace is actively developing the following Identity and Access Management features:
* **OAuth2 Client Credentials Flow:** Transitioning from custom login endpoints to standardized B2B OAuth2 token exchanges.
* **JWKS Endpoint:** Publishing a public JSON Web Key Set (`/.well-known/jwks.json`) for external, offline validation of C2PA manifest signatures and tokens.
* **mTLS (Mutual TLS):** Optional client certificate authentication for highly regulated sectors (Banking, GovTech).
* **Granular Scopes:** Fine-grained permissions (e.g., `watermark:verify_only`) to strictly enforce the Principle of Least Privilege.