# LumaTrace Security & Architecture Whitepaper (Redacted)

## 1. Zero-Retention Architecture
Images processed by the LumaTrace Cloud API are subject to an **ephemeral processing lifecycle**:
* **Buffer Isolation:** Images are loaded into encrypted RAM segments.
* **Atomic Processing:** Watermark injection and JUMBF signing happen in a single execution thread.
* **Purge-on-Finish:** Buffers are zero-filled (wiped) immediately after the binary stream is returned to the client.

## 2. Cryptographic Trust Boundaries
* **Tenant Isolation:** Enforced via `Row-Level Security (RLS)` and `JWT Claims Mapping`. It is architecturally enforced that a session cannot cross-reference a `photoId` from a different `tenantId`.
* **Manifest Integrity:** C2PA assertions are signed using a Fail-Closed PKI infrastructure.

## 3. Operational Reliability (SLO)
Target performance metrics for Enterprise Tier:
* **API Availability:** 99.9% monthly uptime.
* **Latency (p95):** < 400ms for `/protect` (Assets < 10MB).
* **Rate Limit:** 5,000 requests/hour (Scalable on request).