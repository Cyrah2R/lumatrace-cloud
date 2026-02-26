# LumaTrace Enterprise Due Diligence Index

This document provides metadata for enterprise security and compliance artifacts.
Detailed documents are available under NDA upon request.

---

## 1. Security Governance

| Artifact                        | Owner         | Last Updated  | Review Cadence  | Availability  |
|---------------------------------|---------------|---------------|-----------------|---------------|
| Threat Model                    | Security Lead | Jan 2026      | Annual          | NDA           |
| Secure SDLC Policy              | Engineering   | Dec 2025      | Annual          | NDA           |
| Incident Response Plan          | Security      | Jan 2026      | Annual          | NDA           |
| Vulnerability Management Policy | Security      | Jan 2026      | Quarterly       | NDA           |

---

## 2. Compliance Mapping

| Framework                 | Status                    | Last Review   | Availability   |
|---------------------------|---------------------------|---------------|----------------|
| SOC 2 Control Mapping     | Internal Mapping Complete | Dec 2025      | NDA            |
| ISO 27001 Annex A Mapping | Internal Mapping Complete | Dec 2025      | NDA            |
| GDPR Data Flow Assessment | Completed                 | Jan 2026      | NDA            |

---

## 3. Cryptography & Key Management

- JWT Signing: RS256
- Key Rotation: 90 days
- KMS-backed signing keys
- Algorithm agility supported
- Zero plaintext key exposure outside trust boundary

Public cryptography whitepaper available upon request.

---

## 4. Supply Chain Security

- Dependency scanning (CI enforced)
- Branch protection required for main
- Artifact signing before production release
- SBOM generated per release (internal distribution)

---

## 5. Operational Reliability

- Production SLA: 99.9%
- Status page: `status.lumatrace.es` *(Available upon Enterprise SLA activation)*
- Incident communication within 24h
- Postmortems shared with affected enterprise clients

---

## 6. Data Handling

- Zero retention of binary image content
- Metadata retention: 30 days (configurable)
- EU primary data residency
- SCC mechanisms for international transfers (if applicable)

---

For enterprise security inquiries:
enterprise@lumatrace.es