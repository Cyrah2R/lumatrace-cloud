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