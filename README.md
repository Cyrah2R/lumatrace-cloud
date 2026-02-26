# LumaTrace Cloud - Enterprise C2PA & Soft-Binding Integration Hub

LumaTrace is an invisible and resilient digital watermarking solution designed for intellectual property protection in enterprise environments. It implements proprietary Spread-Spectrum algorithms with psycho-visual optimization and seamlessly integrates C2PA manifest orchestration for end-to-end provenance integrity.

This repository serves as the **Public Developer Portal and Trust Center** for the LumaTrace B2B platform.

*(Note: The core mathematical engine and backend microservices are maintained in private, air-gapped enterprise repositories to ensure strict IP protection and supply chain security. See [ARCHITECTURE.md](./ARCHITECTURE.md) for details).*

## Enterprise Use Cases
* **Copyright Enforcement:** Cryptographically bind photographer/creator identities to physical asset pixels.
* **Generative AI Provenance:** Tag AI-generated or manipulated content to comply with global AI regulations.
* **Legal & Forensic Evidence:** Ensure chain-of-custody for digital evidence using timestamped C2PA manifests.

---

## Trust, Security & Assurance
To ensure enterprise-grade reliability, we provide full transparency on our security posture:
* **[Trust Center](./TRUST_CENTER.md):** Centralized index of all security and compliance artifacts.
* **[Security Policy](./SECURITY.md):** Vulnerability disclosure process and security SLAs.
* **[Data Handling](./DATA_HANDLING.md):** GDPR compliance and Zero-Retention image policy.
* **[Public Assurance](./ASSURANCE.md):** High-level evidence of our Secure SDLC and cryptographic controls.

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

> 🚀 **Quick Start:** Download our [Postman Collection](./postman/LumaTrace_Cloud_API.postman_collection.json) to test the integration instantly. See the `/examples` folder for Python and Node.js SDK snippets.

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
(Note: userId and tenantId are securely derived from the JWT context and do not need to be passed in the payload).

## Full API Reference

Explore the complete API contract, payload schemas, and response types in our interactive Developer Portal:

**[Launch Interactive API Documentation](https://cyrah2r.github.io/lumatrace-cloud/)**

## Licensing & Commercial Terms

LumaTrace operates under a B2B SaaS licensing model to guarantee enterprise-grade protection, SLA-backed performance, and strict Supply Chain Security.

For commercial inquiries, SOC2/ISO27001 mapping requests, or Sandbox access:

contact@lumatrace.es

© 2026 LumaTrace Project.