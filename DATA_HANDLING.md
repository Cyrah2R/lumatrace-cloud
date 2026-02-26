# Enterprise Data Handling & Privacy Policy

LumaTrace is designed with a **Privacy-by-Design** and **Zero-Trust** philosophy. This document outlines how data is processed, stored, and protected within the LumaTrace Cloud boundary to ensure compliance with GDPR, CCPA, and enterprise SOC2 requirements.

## 1. Zero-Retention Image Policy (Ephemeral Processing)
When an asset (image) is sent to the `/api/v1/photos/protect` or `/verify` endpoints:
* **In-Memory Processing:** The asset is processed entirely in ephemeral memory (RAM) or highly restricted `tmpfs` mounts.
* **Immediate Deletion:** Once the C2PA manifest is injected or the watermark is verified, the binary file is **immediately and permanently destroyed** from our systems.
* **No Replicas:** LumaTrace does NOT store, cache, backup, or train AI models on client images.

## 2. Metadata Persistence (What we store)
To maintain the cryptographic chain of custody, LumaTrace only persists the following metadata in our isolated PostgreSQL databases:
* `photoId` (UUID v4)
* `tenantId` (For strict B2B boundary isolation)
* `contentHash` (SHA-256 fingerprint of the asset)
* Geographic coordinates (If explicitly provided by the client)
* Device / Hardware signatures

## 3. Data Residency & Encryption
* **Data in Transit:** All API traffic is strictly enforced over TLS 1.3 (HTTPS).
* **Data at Rest:** All persistent metadata is encrypted at rest using AES-256 standard encryption.
* **Residency:** By default, EU client metadata is processed and stored exclusively within European Union (EU) data centers to ensure strict GDPR compliance.

## 4. Multi-Tenant Data Isolation
LumaTrace employs a strict logical separation model. Every API request is contextually bound to a `tenantId` derived cryptographically from the JWT signature. Multi-tenant boundaries are strictly enforced at the database level and JWT context, preventing unauthorized cross-tenant data access.