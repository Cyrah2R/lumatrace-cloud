# LumaTrace Shared Responsibility & Architecture Model

This repository (`lumatrace-cloud`) serves strictly as the **Public Developer Portal** and integration hub.

To maintain strict intellectual property protection and mitigate supply chain attacks, the actual LumaTrace infrastructure is compartmentalized:

## 1. The Public Boundary (This Repository)

* **Purpose:** OpenAPI definitions, Postman collections, SDK examples, and developer onboarding.
* **Code:** Contains zero proprietary algorithmic logic or backend code.

## 2. The Private Core (Air-Gapped Repositories)

* **`lumatrace-core`:** A pure, framework-less mathematical brain containing the spread-spectrum injection, blind detection, and JND (Just Noticeable Difference) psycho-visual algorithms.
* **`lumatrace-server`:** The Spring Boot microservice orchestrating PostgreSQL multi-tenant persistence, Redis-backed active JWT blocklists, and C2PA JUMBF binary injection.

## Security & Compliance Architecture

* **Tenant Isolation:** Enforced strictly at the SQL row-level via `tenant_id` injection from the authenticated JWT context.
* **Fail-Closed Verification:** C2PA manifests are evaluated strictly. Missing or ambiguous metadata results in immediate forensic rejection.
* **Pre-Flight DoS Protection:** Image payloads are validated for pixel dimensions (Max 16MP) and byte size before being loaded into memory buffers.