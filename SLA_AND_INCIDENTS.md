# Service Level Agreement (SLA) & Incident Response

LumaTrace Enterprise is committed to providing a highly available and resilient provenance infrastructure.

## 1. Uptime Commitment (SLA)
We guarantee a **99.9% monthly uptime** for the Core API endpoints (`/protect`, `/verify`).
* **SLA Credits:** If availability drops below 99.9% in a billing cycle, Enterprise Tier customers are eligible for a 10% service credit, scaling up to 50% for < 99.0% availability.
* **Maintenance Window:** Scheduled maintenance is communicated 14 days in advance and occurs strictly on weekends between 02:00 - 04:00 UTC.

## 2. Performance Envelope & Operational Limits (SLO)
To ensure stable multi-tenant architecture, the following performance targets and volume limits apply per endpoint and tier:

| Metric / Endpoint            | Sandbox Tier   | Enterprise Tier   |
|:-----------------------------|:---------------|:------------------|
| **P50 Latency (`/verify`)**  | < 800ms        | < 400ms           |
| **P95 Latency (`/verify`)**  | < 1200ms       | < 800ms           |
| **P50 Latency (`/protect`)** | < 600ms        | < 300ms           |
| **P95 Latency (`/protect`)** | < 1000ms       | < 450ms           |
| **QPS (Sustained)**          | 5 req/sec      | 50 req/sec        |
| **QPS (Burst)**              | 10 req/sec     | 100 req/sec       |
| **Volume Limit**             | 1,000 req/hour | 50,000 req/hour   |
| **Max Payload Size**         | 25 MB          | 25 MB             |

*Note: Throttling semantics return HTTP `429 Too Many Requests` with `X-RateLimit-Reset` headers. Exceeding payload limits returns HTTP `413 Payload Too Large`.*

## 3. Disaster Recovery (RTO & RPO)
* **Recovery Time Objective (RTO):** < 4 Hours (Time to restore API services in a different availability zone).
* **Recovery Point Objective (RPO):** < 5 Minutes (Maximum potential metadata loss in a catastrophic regional failure).

## 4. Incident Severity & Response Times
Our Site Reliability Engineering (SRE) team classifies incidents as follows:

| Severity  | Description                                         | Response Time (Enterprise)   | Communication Channel        |
|:----------|:----------------------------------------------------|:-----------------------------|:-----------------------------|
| **SEV-1** | Core API is completely down. Total loss of service. | < 15 Minutes                 | Direct Phone / Slack Connect |
| **SEV-2** | Degraded performance or high error rates.           | < 1 Hour                     | Email / Status Page          |
| **SEV-3** | Minor bug, non-critical endpoint issue.             | < 24 Hours                   | Support Ticket               |


**Postmortem Policy:** For any SEV-1 or SEV-2 incident, a detailed root-cause analysis (RCA) report will be published and sent to all affected tenants within 72 hours of incident resolution.