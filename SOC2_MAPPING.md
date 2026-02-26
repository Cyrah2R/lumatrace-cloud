# Enterprise Control Matrix (SOC2 / ISO27001 Mapping)

As part of our commitment to enterprise security, LumaTrace aligns its engineering and operational practices with the **SOC 2 Trust Services Criteria (TSC)** and **ISO 27001**.

This matrix maps our public documentation to specific compliance controls to accelerate Vendor Risk Assessments.

| TSC Category                   | Objective                              | LumaTrace Control & Public Evidence                                                                                        |
|:-------------------------------|:---------------------------------------|:---------------------------------------------------------------------------------------------------------------------------|
| **Security (CC6)**             | Logical Access & Tenant Isolation      | Enforced via JWT Claims Mapping and Database RLS. Validated via annual pentest. See: [Trust Boundaries](./ARCHITECTURE.md) |
| **Security (CC7)**             | System Operations & Vulnerability Mgmt | CI/CD automated SAST/SCA scanning. See: [Security Policy](./SECURITY.md)                                                   |
| **Availability (A1)**          | System Resilience & Uptime             | Distributed architecture with 99.9% uptime SLA. See: [SLA & Incidents](./SLA_AND_INCIDENTS.md)                             |
| **Confidentiality (C1)**       | Data Encryption                        | TLS 1.3 for data in-transit, AES-256 for metadata at-rest. See: [Data Privacy](./DATA_PRIVACY.md)                          |
| **Privacy (P1)**               | Data Retention & Deletion              | Ephemeral processing pipeline (Zero-Retention for images). See: [Data Privacy](./DATA_PRIVACY.md)                          |
| **Processing Integrity (PI1)** | Accuracy & Completeness                | C2PA JUMBF Manifest signatures anchored to strict PKI. See: [Security Assurance](./ASSURANCE.md)                           |

---
*For the complete SOC2 Type II report and mapping matrix (including physical security, HR controls, and internal risk assessments), please contact `enterprise@lumatrace.es` with an active NDA.*