# LumaTrace — Public Evidence Index

**Version:** 1.0  
**Classification:** Public  
**Audience:** CISO, InfoSec Auditors, Procurement Teams, Legal Counsel  
**Maintained by:** LumaTrace Security & Engineering Team  
**Contact:** enterprise@lumatrace.es

> This document is the single entry point for enterprise due diligence.
> It enumerates all publicly available security controls, compliance artifacts,
> and engineering evidence. Sensitive materials (full pentest reports, internal
> control matrices, SBOM archives) are available under a signed NDA.

---

## 1. Supply Chain Security

| Control                                | Evidence                                                | Status      |
|:---------------------------------------|:--------------------------------------------------------|:------------|
| Automated SAST (CodeQL)                | GitHub Actions CI — every commit                        | ✅ Active    |
| Dependency vulnerability scan (Trivy)  | CI Pipeline — blocks on CRITICAL CVEs                   | ✅ Active    |
| Software Bill of Materials (CycloneDX) | `bom.json` generated per release                        | ✅ Active    |
| License compliance check               | No GPL/AGPL in proprietary modules                      | ✅ Verified  |
| Container supply chain                 | c2patool binary hash validated at startup (`LT-SEC-05`) | ✅ Active    |
| Secret scanning                        | Trivy filesystem scan — no hardcoded secrets            | ✅ Active    |

---

## 2. Identity, Authentication & Multi-Tenant Isolation

| Control                             | Evidence                                                                          | Status   |
|:------------------------------------|:----------------------------------------------------------------------------------|:---------|
| Multi-tenant login isolation        | `tenantId + username` composite lookup — prevents cross-tenant identity collision | ✅ Active |
| JWT Zero-Trust claims               | Strict `iss`, `aud`, `exp`, `nbf`, `jti` validation on every request              | ✅ Active |
| Active session revocation           | Redis-backed JWT blocklist (`LT-SEC-02`)                                          | ✅ Active |
| Tenant data isolation               | `findByIdAndTenantId` — DB-level scoping on all asset queries                     | ✅ Active |
| RBAC enforcement                    | Spring `@EnableMethodSecurity` — `ROLE_USER / ROLE_AUDITOR / ROLE_ADMIN`          | ✅ Active |
| Rate limiting (Fail-Closed)         | Redis distributed token-bucket — fails closed if Redis unavailable                | ✅ Active |
| X-Forwarded-For spoofing protection | CIDR-trusted proxy whitelist in `LoginRateLimitFilter`                            | ✅ Active |

Reference: [Architecture & Trust Boundaries](./ARCHITECTURE.md) · [SOC2 Control Mapping](./SOC2_MAPPING.md)

---

## 3. Cryptographic Integrity

| Control                     | Evidence                                                                     | Status   |
|:----------------------------|:-----------------------------------------------------------------------------|:---------|
| Watermark seed derivation   | RFC 5869 strict HKDF (HmacSHA256) with tenant + user + asset + nonce + keyId | ✅ Active |
| Key rotation support        | `keyId` parameter in HKDF info string — verifiable across key generations    | ✅ Active |
| C2PA hard-binding           | JUMBF manifest signed with X.509 v3 PKI (RSA ps384)                          | ✅ Active |
| Time-stamping authority     | DigiCert TSA over **HTTPS** — temporal non-repudiation                       | ✅ Active |
| PKI fail-closed             | Self-signed certificates prohibited in `prod` profile                        | ✅ Active |
| CSPRNG                      | AES-CTR deterministic PRNG (replaces `java.util.Random`)                     | ✅ Active |
| Payload integrity           | SHA-256 content hash verified before processing                              | ✅ Active |
| Certificate rotation policy | 90-day C2PA signing key rotation                                             | ✅ Active |

Reference: [Security Whitepaper](./SECURITY_WHITEPAPER.md) · [Security Assurance](./ASSURANCE.md)

---

## 4. Data Governance & Zero-Retention

| Control                     | Evidence                                                            | Status   |
|:----------------------------|:--------------------------------------------------------------------|:---------|
| Zero image retention        | Processing on ephemeral `tmpfs` RAM-disk (`LT-SEC-04`)              | ✅ Active |
| No persistent binary assets | Only cryptographic metadata (hash, nonce, tenantId) persisted in DB | ✅ Active |
| GDPR compliance             | Erasure-by-design architecture — no PII in image pipeline           | ✅ Active |
| Data residency              | Processing buffers: Spain/EU                                        | ✅ Active |

Reference: [Data Privacy Policy](./DATA_PRIVACY.md) · [Subprocessors](./SUBPROCESSORS.md)

---

## 5. Infrastructure Hardening

| Control                        | Evidence                                                      | Status   |
|:-------------------------------|:--------------------------------------------------------------|:---------|
| Read-only container filesystem | `read_only: true` in docker-compose (`LT-SEC-05`)             | ✅ Active |
| Capability dropping            | `cap_drop: ALL` + `no-new-privileges:true`                    | ✅ Active |
| Non-root execution             | Dockerfile runs as user `luma`                                | ✅ Active |
| PostgreSQL SSL                 | `sslmode=require` on JDBC connection                          | ✅ Active |
| Redis AUTH                     | `requirepass` enforced — no unauthenticated connections       | ✅ Active |
| Secret management              | `MASTER_KEY` + `JWT_SECRET` via Docker Secrets (not env vars) | ✅ Active |
| CORS policy                    | Explicit origin whitelist — wildcard `*` rejected at startup  | ✅ Active |
| TLS 1.3                        | Enforced at API Gateway / Load Balancer                       | ✅ Active |
| Certificate pinning (mobile)   | `network_security_config.xml` — production domain pinned      | ✅ Active |

Reference: STRIDE Threat Model *(WIP)* · Compliance Matrix *(WIP)*

---

## 6. Observability & Resilience

| Control             | Evidence                                                              | Status |
|:--------------------|:----------------------------------------------------------------------|:-------|
| Distributed tracing | `x-request-id` + MDC `trace_id` / `tenant_id` on all responses        | Active |
| SLA commitments     | 99.9% availability, P95 latency < 800ms (`/verify`)                   | Active |
| Prometheus metrics  | `/actuator/prometheus` — protection latency, success/failure counters | Active |
| Anti-DoS pre-flight | Pixel count (16MP) + payload size (25MB) checked before memory load   | Active |

Reference: [SLA & Incident Response](./SLA_AND_INCIDENTS.md) · Operations Runbook *(WIP)*

---

## 7. Penetration Testing & Audit

| Engagement                            | Scope                                            | Result                                               | Availability                                                                                                           |
|:--------------------------------------|:-------------------------------------------------|:-----------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------|
| Grey-Box API Pentest                  | Cloud API, Auth flows, Tenant Isolation          | [PENDING — Scheduled Q2 2026]                        | Redacted summary: [PENTEST_SUMMARY_TEMPLATE.md](./PENTEST_SUMMARY_TEMPLATE.md) · Full report under NDA upon completion |
| External Architecture Audit (2026-03) | All 4 repositories — server, core, mobile, cloud | All P0 blockers resolved (H-01, H-02, H-03, B1, B2)  | Available under NDA                                                                                                    |

---

## 8. Publicly Available Artifacts

All documents below are published at **[https://cyrah2r.github.io/lumatrace-cloud/](https://cyrah2r.github.io/lumatrace-cloud/)**

| Document                                                                    | Purpose                                  |
|:----------------------------------------------------------------------------|:-----------------------------------------|
| [Trust Center](./TRUST_CENTER.md)                                           | Master index of all governance documents |
| [Security Policy](./SECURITY.md)                                            | Vulnerability disclosure & SLAs          |
| [Security Whitepaper](./SECURITY_WHITEPAPER.md)                             | Architecture & cryptographic controls    |
| [SOC2 / ISO27001 Mapping](./SOC2_MAPPING.md)                                | Control-to-implementation matrix         |
| [Data Privacy Policy](./DATA_PRIVACY.md)                                    | GDPR · Zero-Retention · Data residency   |
| [SLA & Incident Response](./SLA_AND_INCIDENTS.md)                           | Uptime SLA · RTO/RPO · Severity matrix   |
| [Evidence Pack Summary](./EVIDENCE_PACK_SUMMARY.md)                         | Pentest status · SBOM · Key management   |
| [Pentest Summary (Redacted)](./PENTEST_SUMMARY_TEMPLATE.md)                 | Methodology · Findings summary           |
| [OpenAPI Specification](./api/openapi.yaml)                                 | Full API contract v1.1.0                 |
| [Postman Collection](./postman/LumaTrace_Cloud_API.postman_collection.json) | Enterprise integration test suite        |

---

## 9. NDA Data Room

Available to qualified enterprise prospects under a signed Mutual NDA:

- Full unredacted Penetration Test report with CVSS scores and remediation evidence
- Complete SOC2 Type II audit report
- ISO 27001 internal control matrix with implementation owners
- SBOM archive (CycloneDX JSON) for all production releases
- Full C2PA cryptographic profile and PKI hierarchy documentation
- Internal STRIDE threat model with risk scoring

**Request access:** enterprise@lumatrace.es

---

*© 2026 LumaTrace. This document may be shared with prospective enterprise customers for due diligence purposes.*