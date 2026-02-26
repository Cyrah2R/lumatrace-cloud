# Enterprise Data Privacy & Processing Policy

LumaTrace follows a Privacy-by-Design and Zero-Trust architecture philosophy.

This document outlines how data is processed and protected within the LumaTrace Cloud boundary.

---

## 1. Zero-Retention Image Processing

When an asset is submitted to `/api/v1/photos/protect` or `/api/v1/photos/verify`:

- Processing occurs in ephemeral memory.
- Image binaries are not written to durable storage.
- Assets are discarded immediately after processing completion.

LumaTrace does not:
- Persist client image binaries
- Replicate image files across storage systems
- Train AI models on submitted assets

---

## 2. Metadata Persistence

To maintain cryptographic chain-of-custody, only minimal metadata is stored:

- `photoId` (UUID v4)
- `tenantId`
- `contentHash` (SHA-256)
- Optional client-provided geographic coordinates
- Optional device metadata

No image binary data is retained.

---

## 3. Encryption & Transport Security

Data in transit:
- Enforced over TLS 1.3

Data at rest:
- Encrypted using industry-standard AES-256 mechanisms

---

## 4. Data Residency

EU tenant metadata is processed and stored within EU-based infrastructure regions by default.

---

## 5. Tenant Isolation

All API requests are bound to a validated tenant context derived from JWT claims.

Data access is programmatically scoped to prevent unauthorized cross-tenant access.