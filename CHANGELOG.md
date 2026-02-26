# Changelog

All notable changes to the LumaTrace Cloud API and Developer Portal are documented in this file.

The format follows Keep a Changelog principles.
This project adheres to Semantic Versioning.

---

## [1.0.0] - 2026-02-26

### Added

- Public Developer Portal initial release
- Interactive OpenAPI specification (`openapi.yaml`)
- Defined API contracts for:
    - `/api/v1/auth/login`
    - `/api/v1/auth/logout`
    - `/api/v1/auth/register`
    - `/api/v1/photos/protect`
    - `/api/v1/photos/verify`
- Python and Node.js integration examples
- Official Postman collection for enterprise testing
- Publication of governance documentation:
    - `ARCHITECTURE.md`
    - `SECURITY.md`
    - `DATA_PRIVACY.md`
    - `API_LIFECYCLE.md`
    - `ASSURANCE.md`

### Security

- Defined strict multi-tenant isolation requirements for JWT-scoped interactions
- Introduced pre-flight validation rules:
    - Maximum upload size: 25MB
    - Maximum resolution: 16 Megapixels