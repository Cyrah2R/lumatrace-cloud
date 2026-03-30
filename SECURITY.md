# LumaTrace Security Policy

Security is a foundational principle at LumaTrace.  
This document defines our vulnerability disclosure program, response SLAs, and enterprise security governance posture for the LumaTrace Cloud API.

---

# 1. Supported Versions

Only the current major version of the LumaTrace Cloud API is eligible for security updates.

| Version   | Supported   | Security Patch SLA (Critical CVEs)  |
|-----------|-------------|-------------------------------------|
| v1.x      | Yes         | < 24 Hours                          |
| < v1.0    | No          | N/A                                 |

Security patches are applied immediately to production infrastructure once validated.

---

# 2. Responsible Disclosure Program

We value collaboration with security researchers, red teams, and enterprise partners.

If you discover a vulnerability in:

- Public APIs
- Authentication flows
- Multi-tenant isolation controls
- Cryptographic implementations
- Infrastructure components
- CI/CD or supply chain artifacts

Please report it responsibly.

### Reporting Process

1. Email: **security@lumatrace.es**
2. Include:
    - Detailed description
    - Impact assessment
    - Proof of Concept (PoC)
    - Reproduction steps
    - Suggested remediation (optional)

Do not publicly disclose vulnerabilities until coordinated remediation is completed.

---

# 3. Vulnerability Response SLA

| Phase                  | Target            |
|------------------------|-------------------|
| Acknowledgment         | < 12 Hours        |
| Initial Triage         | < 48 Hours        |
| Remediation (Critical) | 24–72 Hours       |
| Remediation (High)     | < 5 Business Days |

Severity classification follows CVSS v3.1 scoring guidelines.

Enterprise customers receive coordinated disclosure updates during remediation.

---

# 4. Security Governance Framework

LumaTrace operates under internally documented policies aligned with:

- SOC 2 Security & Availability Principles
- ISO/IEC 27001 Annex A control categories
- OWASP ASVS guidelines
- NIST Secure Software Development Framework (SSDF)

Control mappings are available under NDA via the Enterprise Due Diligence Pack.

---

# 5. Secure Development Lifecycle (SDLC)

Our SDLC enforces:

- Mandatory peer code review
- Static Application Security Testing (SAST)
- Dependency vulnerability scanning (CI-enforced)
- Container image scanning before release
- Branch protection on mainline
- Signed production artifacts

All releases are built via isolated CI pipelines.

---

# 6. Supply Chain Security

- CycloneDX SBOM generated per release
- Dependency scanning with automated CVE alerts
- No unsigned production deployment permitted
- Secrets stored in managed KMS
- No hard-coded credentials in source repositories

Supply chain documentation available under NDA.

---

### 7. Cryptographic Standards

* **Data in Transit:** TLS 1.3
* **Data at Rest:** AES-256-GCM
* **JWT Signing:** RS256 (RSA 2048-bit, asymmetric signature)
* *Integration note:* External clients and microservices can verify token authenticity without sharing secrets by fetching our public keys at the standard endpoint: `/.well-known/jwks.json`

---

# 8. Enterprise Security Artifacts (Under NDA)

The following artifacts are available for enterprise due diligence:

- STRIDE Threat Model
- Data Flow Diagrams (DFD)
- Cryptographic Key Management Policy
- Incident Response Plan
- Penetration Test Executive Summary
- SBOM Inventory
- Multi-Tenant Isolation Architecture Proofs

Contact: **contact@lumatrace.es**

---

# 9. Incident Communication

In the event of a confirmed security incident:

- Enterprise customers are notified within 24 hours.
- Affected parties receive impact assessment.
- Post-incident review is shared under NDA when applicable.

---

### Documentation Synchronization Policy
Security documentation (including cryptographic standards and endpoints) is reviewed and synchronized with the codebase during the pre-release phase of every major semantic version (vX.Y.0) to prevent configuration drift.

Security inquiries:  
contact@lumatrace.es