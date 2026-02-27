# Operational SLO Metrics (Public Baseline)

LumaTrace Cloud API commits to the following Service Level Objectives (SLO) for enterprise tenants:

| Metric                       | Target       | Measurement Window   |
|------------------------------|--------------|----------------------|
| **Availability**             | 99.9%        | Monthly              |
| **P95 Latency (`/verify`)**  | < 800ms      | Daily                |
| **P95 Latency (`/protect`)** | < 450ms      | Daily                |
| **Error Budget**             | 0.1%         | Monthly              |
| **Rate Limit Reset**         | Fixed Window | 60 minutes           |

### Measurement Methodology
- Latency is measured from the moment the payload is fully received at the LumaTrace Gateway until the first byte of the response is dispatched.
- Availability is calculated based on the ratio of successful responses (2xx, 4xx) vs server-side failures (5xx).