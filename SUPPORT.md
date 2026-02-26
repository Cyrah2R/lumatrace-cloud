# LumaTrace API Lifecycle & Support Policy

This document outlines the operational support model for integrators and B2B clients using the LumaTrace Cloud API.

## API Versioning
LumaTrace follows strict [Semantic Versioning](https://semver.org/).
* The API version is defined in the URL path (e.g., `/api/v1/`).
* Backwards-compatible updates (new fields, new endpoints) will not change the major version.

## Deprecation Policy (Breaking Changes)
Enterprise environments require stability. If a breaking change is strictly necessary:
1. **Notification:** All registered tenant administrators will receive an email notification **6 months** prior to deprecation.
2. **Sunset Header:** The deprecated endpoint will return a `Sunset: <Date>` HTTP header during the deprecation window.
3. **Availability:** The old version will remain fully operational in production until the sunset date is reached.

## Rate Limiting & Quotas
To ensure High Availability (HA) across all tenants, the API enforces Token-Bucket rate limiting at the ingress layer:
* **Authentication (`/login`):** 10 requests per minute per IP.
* **Core Protection (`/protect`):** Scaled dynamically based on your Enterprise SLA tier.
* **Verification (`/verify`):** Standard tier allows 100 verifications per minute.

HTTP `429 Too Many Requests` will be returned if limits are exceeded.

## Standardized Error Codes Catalog
To facilitate automated handling by client integrations, the LumaTrace API strictly adheres to standard HTTP status codes.

| HTTP Code   | Error Name          | Description & Action Required                                                                                                                                |
|:------------|:--------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **400**     | `Bad Request`       | The JSON payload is malformed, missing required fields (e.g., `contentHash`), or the SHA-256 format is invalid.                                              |
| **401**     | `Unauthorized`      | The provided JWT is missing, expired, or invalid. Action: Call `/api/v1/auth/login` to obtain a new token.                                                   |
| **403**     | `Forbidden`         | **Tenant Isolation Violation.** The authenticated token lacks the necessary RBAC roles, or the requested `photoId` belongs to a different Enterprise Tenant. |
| **404**     | `Not Found`         | The requested asset metadata does not exist in the registry.                                                                                                 |
| **413**     | `Payload Too Large` | Pre-flight DoS protection triggered. The uploaded image exceeds the 25MB file size or 16 Megapixel limits.                                                   |
| **429**     | `Too Many Requests` | Token-bucket API quota exceeded. Action: Implement exponential backoff.                                                                                      |
| **500**     | `Internal Error`    | Cryptographic engine failure or database timeout. An incident trace is automatically generated for our SRE team.                                             |