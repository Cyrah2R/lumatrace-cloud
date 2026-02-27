# LumaTrace Cloud Architecture & Trust Boundary Model

This document defines the structural separation between the public integration boundary and the private proprietary infrastructure of LumaTrace Cloud.

The `lumatrace-cloud` repository serves strictly as the **Public Developer Portal** and integration surface for enterprise clients and partners.

To ensure intellectual property protection and mitigate supply-chain risk, the operational infrastructure is compartmentalized into isolated private repositories.

---

## 1. Public Boundary (This Repository)

**Purpose:**
- OpenAPI specifications
- Postman collections
- SDK examples
- Integration and onboarding documentation

**Scope:**
This repository contains no proprietary watermarking algorithms, backend implementation logic, or cryptographic key material.

It is limited to API contracts and integration guidance only.

---

## 2. Private Core (Air-Gapped Repositories)

The production infrastructure is maintained in private, access-controlled repositories:

**lumatrace-core** A proprietary, framework-independent forensic engine implementing psycho-visual watermarking and detection mechanisms.

**lumatrace-server** A backend orchestration service responsible for:
- Tenant-aware authentication and authorization
- Scoped persistence
- C2PA manifest injection workflows
- Rate limiting enforcement
- Operational audit logging

These components are not publicly accessible.

---

## 3. Multi-Tenant Isolation Model

All API requests are cryptographically bound to an authenticated tenant context derived from JWT claims.

Data isolation is enforced at the persistence layer by programmatically scoping every query and transaction to the authenticated tenant identifier.

Cross-tenant data access is structurally prevented at both:
- Authorization layer
- Data access layer

---

## 4. Fail-Closed Verification Model

C2PA manifest validation operates in strict fail-closed mode.

If metadata is:
- Missing
- Malformed
- Cryptographically invalid
- Ambiguous

The asset is rejected as non-authentic.

---

## 5. Pre-Flight Payload Validation

To mitigate denial-of-service and resource exhaustion vectors:

- Maximum file size enforced before processing
- Maximum image resolution (16 Megapixels)
- Supported formats: JPEG, PNG, and WEBP

Validation occurs prior to loading payloads into memory buffers.