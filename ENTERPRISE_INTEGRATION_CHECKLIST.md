# Enterprise Integration Readiness Checklist

This checklist defines the technical requirements for production-grade integration with the LumaTrace Cloud API.

## 1. Identity & Access Management
- [ ] **M2M Credentials:** Service account credentials stored in a secure Vault (not in .env or source).
- [ ] **Token Management:** Client implements automatic JWT renewal before the 15-minute TTL expiry.
- [ ] **Audit Scopes:** Integration uses specific scopes if configured (default: `tenant_access`).

## 2. Resilience & Reliability
- [ ] **Idempotency:** `Idempotency-Key` (UUID v4) generated for every `/register` and `/protect` request.
- [ ] **Retry Strategy:** Exponential backoff implemented for 429 and 5xx errors (as shown in Python example).
- [ ] **Timeouts:** Connection timeouts set to 10s (auth) and 30s (processing).

## 3. Observability
- [ ] **Traceability:** Client logs the `x-request-id` for every response to facilitate support correlation.
- [ ] **Monitoring:** Client tracks 4xx error rates to detect integration drift.

## 4. Security & Hardening
- [ ] **Payload Validation:** Client-side check for < 25MB and < 16MP to reduce unnecessary egress.
- [ ] **TLS:** Connection restricted to TLS 1.3.