# Changelog

All notable changes to the LumaTrace Cloud API and Developer Portal will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-26
### Added
- **Public Developer Portal:** Initial release of the interactive OpenAPI documentation (`openapi.yaml`).
- **Core Endpoints:** Defined contracts for `/login`, `/logout`, `/register`, `/protect`, and `/verify`.
- **Integration SDKs:** Added ready-to-use Python and Node.js examples for multipart payload injection.
- **Postman Collection:** Released official B2B testing environment variables and scripts.
- **Enterprise Trust Center:** Published `SECURITY.md`, `SUPPORT.md`, and `ARCHITECTURE.md` policies.
- **Data Handling Policy:** Formalized Zero-Retention Image Policy for GDPR compliance.

### Security
- Defined strict Multi-Tenant isolation requirements for all JWT interactions.
- Added pre-flight validation rules (Max 25MB upload, Max 16 Megapixels) for DoS protection.