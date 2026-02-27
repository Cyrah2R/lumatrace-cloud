# Authorized Subprocessors & Data Residency

To comply with the General Data Protection Regulation (GDPR) and Enterprise Data Processing Addendums (DPA), LumaTrace uses the following authorized infrastructure subprocessors.

**Strict EU Data Residency:** By default, all Enterprise Tenant data is processed and stored exclusively within the European Union.

| Subprocessor                  | Service Provided                              | Location / Region                            | Certifications       |
|:------------------------------|:----------------------------------------------|:---------------------------------------------|:---------------------|
| **Amazon Web Services (AWS)** | Cloud Infrastructure & Ephemeral Compute      | EU-West-3 (Paris) / EU-Central-1 (Frankfurt) | SOC2, ISO27001, GDPR |
| **Redis Enterprise**          | Distributed Session Blocklist & Rate Limiting | EU-West-3 (Paris)                            | SOC2, ISO27001       |
| **PostgreSQL (Managed)**      | Encrypted Metadata Persistence                | EU-West-3 (Paris)                            | SOC2, ISO27001       |

*Note: As per our [Enterprise Data Privacy Policy](./DATA_PRIVACY.md), image binaries are strictly processed in-memory and are never written to disk or sent to third-party sub-processors.*