# Security Policy

At LumaTrace, security is our foundational pillar. This document outlines our vulnerability disclosure process and security SLA for enterprise clients.

## Supported Versions

Only the current major version of the LumaTrace Cloud API is actively supported for security updates.

| Version | Supported          | SLA for Critical CVEs |
| ------- | ------------------ | --------------------- |
| v1.x    | :white_check_mark: | < 24 Hours            |
| < v1.0  | :x:                | N/A                   |

## Reporting a Vulnerability

We deeply value the work of the security community and our enterprise red teams. If you discover a security vulnerability in our API, algorithms, or 
infrastructure, please report it immediately.

**Do not publicly disclose the vulnerability until we have had a chance to remediate it.**

1. Email your findings to: **security@lumatrace.es**
2. Include a PoC (Proof of Concept) and detailed steps to reproduce.

### Response Target (SLA)

- **Acknowledgment:** Within 12 hours.
- **Triage & Classification:** Within 48 hours.
- **Remediation (Critical/High):** Within 24-72 hours.

## Enterprise Security Artifacts (Due Diligence)

For our B2B clients undergoing procurement and risk assessment, the following artifacts are available under NDA:

* **STRIDE Threat Model & Data Flow Diagrams (DFD)**
* **Cryptographic Baseline & Key Rotation Policy**
* **CycloneDX SBOMs (Software Bill of Materials)**
* **Multi-Tenant Architecture Isolation Proofs**

Please contact `contact@lumatrace.es` to request the Enterprise Due Diligence Pack.