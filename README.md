# LumaTrace Cloud

**Enterprise C2PA & Analog-Hole Mitigation Hub**

[![Enterprise Ready](https://img.shields.io/badge/Enterprise-Ready-success.svg)](#) [![Architecture](https://img.shields.io/badge/Architecture-Air_Gapped_Microservices-blue.svg)](#) [![Security](https://img.shields.io/badge/Security-SOC2_Ready-purple.svg)](#)

LumaTrace is an enterprise-grade forensic provenance ecosystem designed to bridge the critical gap in the **C2PA (Coalition for Content Provenance and Authenticity)** standard: the **Analog Hole**.

While standard C2PA provides cryptographic "hard-binding", metadata manifests are stripped during screenshots, optical recapture, or social media uploads. LumaTrace acts as the **"Soft-Binding Bridge"**. It embeds a deterministic, HVS-optimized invisible spatial watermark directly into the image pixels, ensuring that the cryptographic seed tying the asset to its original C2PA manifest survives any non-destructive transformation.

This repository serves as the **Public Developer Portal and Trust Center** for the LumaTrace B2B platform.

*(Note: The core mathematical engine and backend microservices are maintained in private, air-gapped enterprise repositories to ensure strict IP protection and supply chain security. See [ARCHITECTURE.md](./ARCHITECTURE.md) for details).*

---

## Enterprise Use Cases
* **Copyright Enforcement:** Cryptographically bind photographer/creator identities to physical asset pixels.
* **Generative AI Provenance:** Tag AI-generated or manipulated content to comply with global AI regulations.
* **Legal & Forensic Evidence:** Ensure chain-of-custody for digital evidence using timestamped C2PA manifests.

---

## Ecosystem Architecture (The 4 Pillars)

To enforce strict Separation of Concerns (SoC) and supply-chain security, the LumaTrace platform is decoupled into four independent modules:

1. **`lumatrace-core` (Private):** Pure Java 21 DSP Engine. Generates deterministic PRNG signatures and Z-Score detection without external dependencies.
2. **`lumatrace-server` (Private):** Spring Boot 3.2 Governance Cloud. Handles PKI for C2PA signing, multi-tenant isolation, and stateless API contracts.
3. **`lumatrace-mobile` (Private):** Native Android Capture Sensor. Provides point-of-capture forensic signing via CameraX and Keystore hardware integration.
4. **`lumatrace-cloud` (This Repo):** The Public Data Room and API Gateway documentation for Enterprise integration.

---

## Visual Fidelity Analysis (JND Validation)

To ensure high-quality content provenance, LumaTrace uses adaptive spread-spectrum injection. This ensures the watermark is invisible to the human eye while remaining statistically robust for forensic detection.

|   Original Asset (`input.jpg`)      |    Protected Asset (`protected_final.jpg`)     |    Signal Map (Enhanced Difference)      |
|:-----------------------------------:|:----------------------------------------------:|:----------------------------------------:|
| ![Original Asset](assets/input.jpg) | ![Protected Asset](assets/protected_final.jpg) | ![Signal Map](assets/difference_map.png) |
|      *No watermark signature*       |          *Encoded with Seed 8049...*           |      *Spatial signal distribution*       |

### Psychovisual Insights
* **Luma Masking:** The signal is heavily masked in high-texture areas (buildings, cars).
* **Sky Protection:** Using `MIN_GAIN = 1.2`, grain is eliminated in low-entropy regions (e.g., clear skies).
* **Color Constancy:** Injection is balanced across RGB channels to prevent color shifting.

---

## Technical Validation & Provenance Flow

The following end-to-end test demonstrates the binding between Cloud Metadata and the physical asset.

### 1 Cloud Registration (C2PA Manifest)
We registered the asset metadata (Device, GPS, User) via the Cloud API to obtain a unique cryptographic seed.

![Cloud Registration](assets/01-cloud-registration.png)

### 2 Forensic Signal Injection
Using the generated seed `8049473336066145901`, we injected the watermark into `input.jpg`.
* **Latency:** 227 ms
* **Z-Score (σ):** 97 (Extreme high confidence)

![Forensic Injection](assets/02-cli-protection.png)

### 3 Robustness Audit (Original State)
Validation of the signal immediately after injection to establish the high-entropy baseline.
* **Z-Score (σ):** 97.48 (Extreme high confidence)
* **Status:** VALIDATED

![Robustness Audit](assets/03-robustness-audit.png)

### 4 Tamper Verification (Stress Test)
The asset was subjected to aggressive degradation (Heavy resizing and JPEG compression).
* **Survival:** The signal remains verified even after structural tampering.
* **Resulting Z-Score (σ):** 44.34 (Remains 11x above the detection threshold)
* **Analysis Latency:** 136 ms

![Tamper Verification](assets/04-tamper-verification.png)

---

## API Integration Example

Authentication via Tenant-Aware JWT is strictly required.

> **Quick Start:** Download our [Postman Collection](./postman/LumaTrace_Cloud_API.postman_collection.json) to test the integration instantly. See the `/examples` folder for Python and Node.js SDK snippets.

### Request (cURL)

```bash
curl -X POST "https://api.lumatrace.es/api/v1/photos/register" \
-H "Authorization: Bearer YOUR_VALID_JWT_TOKEN" \
-H "Content-Type: application/json" \
-H "x-request-id: req-example-123" \
-d '{
"deviceModel": "Enterprise_Capture_Node_A1",
"latitude": 40.41,
"longitude": -3.70,
"contentHash": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
}'
```
(Note: userId and tenantId are securely derived from the backend JWT context to prevent IDOR vulnerabilities and do not need to be passed in the payload).

## Full API Reference

Explore the complete API contract, payload schemas, and response types in our interactive Developer Portal:

**[Launch Interactive API Documentation](https://cyrah2r.github.io/lumatrace-cloud/)**

---

## Compliance, Licensing & Procurement (Data Room)
To ensure enterprise-grade reliability, LumaTrace operates under a B2B SaaS licensing model guaranteeing SLA-backed performance and strict Supply Chain Security.

We provide full transparency on our security posture for Due Diligence processes:
* **[Trust Center](./TRUST_CENTER.md):** Centralized index of all security and compliance artifacts.
* **[Security Policy](./SECURITY.md):** Vulnerability disclosure process and security SLAs.
* **[Data Handling](DATA_PRIVACY.md):** GDPR compliance and Zero-Retention image policy.
* **[Public Assurance](./ASSURANCE.md):** High-level evidence of our Secure SDLC and cryptographic controls.

NDA Data Room Pack: For deep-dive procurement, SOC2/ISO27001 mapping requests, Penetration Test Summaries, or full C2PA Cryptographic Profiles, please request our NDA Data Room Pack at: contact@lumatrace.es

© 2026 LumaTrace Project.
