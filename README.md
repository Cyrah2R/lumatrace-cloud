# LumaTrace Cloud - Enterprise C2PA & Soft-Binding Integration Hub

LumaTrace is an invisible and resilient digital watermarking solution designed for intellectual property protection in enterprise environments. It implements proprietary Spread-Spectrum algorithms with psycho-visual optimization and seamlessly integrates C2PA manifest orchestration for end-to-end provenance integrity.

This repository serves as the official integration endpoint, Developer Portal, and documentation hub for the `api.lumatrace.es` B2B platform.



## Core Technology & Architecture

LumaTrace follows a secure, zero-trust cloud-native architecture:

* **The Core (Mathematical Brain):** A proprietary, air-gapped engine containing watermark embedding, blind detection, and cryptographic seed derivation algorithms.
* **The Cloud (RESTful API):** A scalable, multi-tenant microservice managing high-throughput persistence, RBAC, and C2PA JUMBF orchestration.

## Enterprise Use Cases

* **Copyright Enforcement:** Cryptographically bind photographer/creator identities to the physical asset pixels.
* **Generative AI Provenance:** Tag AI-generated or manipulated content to comply with upcoming global AI regulations.
* **Legal & Forensic Evidence:** Ensure chain-of-custody for digital evidence using timestamped, Digicert-backed C2PA manifests.

---

## Security & Trust Center

LumaTrace is built for regulated B2B environments. Our architecture guarantees:
* **Strict Multi-Tenant Isolation:** Cryptographically isolated data boundaries using Tenant-Aware JWTs.
* **Defense in Depth:** Token-bucket rate limiting, pre-flight DoS protection (Pixel-bomb rejection), and active session blocklists via Redis.
* **Fail-Closed PKI:** C2PA verification strictly rejects ambiguous or tampered manifests, ensuring zero false positives in forensic analysis.

---

## Visual Fidelity Analysis (JND Validation)

To ensure high-quality content provenance, LumaTrace uses adaptive spread-spectrum injection. This ensures the watermark is invisible to the human eye while remaining statistically robust for forensic detection.

|    Original Asset (`input.jpg`)     |   Protected Asset (`protected_final.jpg`)      |    Signal Map (Enhanced Difference)      |
|:-----------------------------------:|:----------------------------------------------:|:----------------------------------------:|
| ![Original Asset](assets/input.jpg) | ![Protected Asset](assets/protected_final.jpg) | ![Signal Map](assets/difference_map.png) |
|      *No watermark signature*       |          *Encoded with Seed 8049...*           |      *Spatial signal distribution*       |


### Psychovisual Insights
* **Luma Masking:** The signal is heavily masked in high-texture areas (buildings, cars).
* **Sky Protection:** Using `MIN_GAIN = 1.2`, grain was eliminated in low-entropy regions (sky).
* **Color Constancy:** Injection is balanced across RGB channels to prevent color shifting.

---

## Technical Validation & Provenance Flow

The following end-to-end test demonstrates the binding between Cloud Metadata and the physical asset.

### 1 Cloud Registration (C2PA Manifest)
We registered the asset metadata (Device, GPS, User) via the Cloud API to obtain a unique cryptographic seed.

![Cloud Registration](assets/01-cloud-registration.png)

### 2️ Forensic Signal Injection
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

### Psychovisual Insights
* **Luma Masking:** The signal is heavily masked in high-texture areas.
* **Sky Protection:** Using `MIN_GAIN = 1.2`, grain is eliminated in low-entropy regions (e.g., clear skies).
* **Color Constancy:** Injection is balanced across RGB channels to prevent color shifting.

---

## Technical Validation & Provenance Flow

The following end-to-end test demonstrates the binding between Cloud Metadata and the physical asset.

### 1️ Cloud Registration (C2PA Manifest)
We register the asset metadata (Device, GPS, User) via the LumaTrace Cloud API to obtain a unique cryptographic seed.

### 2 Forensic Signal Injection
Using the generated seed (`8049473336066145901`), the watermark is injected into the asset.
* **Latency:** 227 ms
* **Z-Score (σ):** 97 (Extreme high confidence)

### 3️ Tamper Verification (Stress Test)
The asset is subjected to aggressive degradation (Heavy resizing and JPEG compression).
* **Survival:** The signal remains verified even after structural tampering.
* **Resulting Z-Score (σ):** 44.34 (Remains 11x above the detection threshold)

---

## API Integration Example

Integration with LumaTrace Cloud is straightforward via our RESTful API. Authentication via JWT is required.

>  **Quick Start:** Download our [Postman Collection](./postman/LumaTrace_Cloud_API.postman_collection.json) to test the integration instantly. It automatically handles JWT extraction and multi-part form uploads.

### Request (cURL)

```bash
curl -X POST "[https://api.lumatrace.es/api/v1/photos/register](https://api.lumatrace.es/api/v1/photos/register)" \
  -H "Authorization: Bearer YOUR_VALID_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "engineer_test",
    "deviceModel": "Cloud_Server_Node_1",
    "latitude": 40.41,
    "longitude": -3.70,
    "contentHash": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  }'
```

### Response Example

```JSON
{
  "photoId": "a1b2c3d4-e5f6-7890-1234-56789abcdef0",
  "tenantId": "org_enterprise_001",
  "createdAt": "2026-02-25T14:30:00Z",
  "canonicalHash": "8f434346648f6b96df89dda901c5176b10a6d83961dd3c1ac88b59b2dc327aa4",
  "signature": "MIIB...[TRUNCATED_RSA_PSS_SIGNATURE]...AB="
}
```
## Full API Reference

Explore the complete API contract, payload schemas, and response types in our interactive Developer Portal:

**[Launch Interactive API Documentation](https://cyrah2r.github.io/lumatrace-cloud/)**

## Licensing & Commercial Terms

LumaTrace is a Proprietary and Commercial Enterprise Solution.

We operate under a B2B SaaS and SDK licensing model to guarantee enterprise-grade protection, SLA-backed performance, and strict Supply Chain Security for our clients.

For commercial inquiries, API Sandbox access, or Enterprise Edition licensing, please contact:

contact@lumatrace.es | cyrahrr@gmail.com

© 2026 LumaTrace Project.