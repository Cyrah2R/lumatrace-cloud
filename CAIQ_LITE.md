# Enterprise Security Questionnaire (CAIQ-Lite Starter Pack)

This document provides standardized answers to the most common Vendor Risk Management (VRM) inquiries to accelerate your due diligence process.

| Domain                   | Question                                                            | LumaTrace Policy / Control                                                                                                                                  |
|:-------------------------|:--------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Application Security** | Do you perform automated static and dynamic code analysis?          | Yes. SAST and SCA tools are embedded in our CI/CD pipeline.                                                                                                 |
| **Data Security**        | How is customer data segmented and protected?                       | We enforce Tenant Isolation via database Row-Level Security (RLS) and strict JWT claims. Binary payloads are processed entirely in memory (Zero-Retention). |
| **Encryption**           | What encryption standards are used for data at rest and in transit? | TLS 1.3 is enforced for all external transit. At-rest metadata is encrypted using AES-256.                                                                  |
| **Vulnerability Mgmt**   | Do you conduct independent third-party penetration tests?           | Yes, bi-annually. A redacted Executive Summary is available in our Trust Center.                                                                            |
| **Incident Response**    | Is there a documented Incident Response plan?                       | Yes. We maintain a 99.9% uptime SLA and commit to SEV-1 response times < 15 minutes.                                                                        |
| **Compliance**           | Are your infrastructure providers certified?                        | Yes. Our primary subprocessor (AWS) maintains SOC2 Type II, ISO27001, and GDPR compliance.                                                                  |

*For the complete Cloud Security Alliance (CSA) CAIQ document, please contact your account executive.*