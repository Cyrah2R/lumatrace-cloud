# Public Security Assurance & Verification

This document provides high-level evidence of the security controls and engineering practices mentioned in our Trust Center.

## 1. Secure SDLC (Software Development Life Cycle)
Every release of the LumaTrace private core undergoes:
* **SAST Scanning:** Automated CodeQL analysis for SQL injection, XSS, and path traversal.
* **Secret Scanning:** Prevention of hardcoded credentials in the supply chain.
* **Dependency Auditing:** CycloneDX SBOM generation and Trivy vulnerability scanning.

## 2. Cryptographic Proofs
* **Isolation:** Tenant isolation is enforced via Hibernate/JPA `@Filter` at the database session level, ensuring that every SQL query is automatically scoped to the `tenant_id` of the authenticated JWT.
* **Signatures:** All C2PA manifests are signed using RSA-PSS with 3072-bit keys, anchored to our private Enterprise CA.

## 3. Supply Chain Integrity
Our release artifacts are cryptographically signed. We maintain a private, redacted SBOM available for security auditors to verify our 3rd-party library footprint.