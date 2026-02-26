# LumaTrace API Lifecycle & Governance Policy

This document defines versioning, deprecation, and operational stability guarantees for enterprise integrators.

---

## API Versioning

LumaTrace follows Semantic Versioning principles.

- The API version is defined in the URL path (e.g., `/api/v1/`).
- Backwards-compatible changes do not increment the major version.
- Breaking changes require a new major version.

---

## Deprecation Policy

If a breaking change becomes necessary:

1. Tenant administrators will be notified at least 6 months in advance.
2. Deprecated endpoints will return a `Sunset` HTTP header during the transition period.
3. The previous version will remain operational until the sunset date.

---

## Rate Limiting

Token-bucket rate limiting is enforced at the API ingress layer to ensure service stability.

Authentication:
- 10 requests per minute per IP

Verification:
- 100 requests per minute (standard tier)

Protection endpoints:
- Rate limits aligned with tenant SLA tier

HTTP `429 Too Many Requests` is returned when limits are exceeded.

---

## Standardized Error Codes

The API adheres to standard HTTP status codes:

| HTTP Code   | Description                                         |
|-------------|-----------------------------------------------------|
| 400         | Malformed or invalid request payload                |
| 401         | Missing, expired, or invalid authentication token   |
| 403         | Authorization failure or tenant isolation violation |
| 404         | Requested resource not found                        |
| 413         | Payload exceeds size or resolution limits           |
| 429         | Rate limit exceeded                                 |
| 500         | Unexpected internal processing error                |

Internal error details are not exposed in API responses.