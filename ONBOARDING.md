# Enterprise Onboarding Guide

This guide walks you through the standard integration flow for the LumaTrace Cloud API.

---

## Step 1 — Authenticate and Retrieve JWT

All API interactions require a valid tenant-scoped JWT.

### Request

```bash
curl -X POST [https://api.lumatrace.es/api/v1/auth/login](https://api.lumatrace.es/api/v1/auth/login) \
  -H "Content-Type: application/json" \
  -d '{"tenantId": "your_tenant_id", "username": "your_service_account", "password": "your_password"}'
```

### Response

```json
{
  "token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

Store the token value. It must be included in the Authorization header of subsequent requests.

### Decoded JWT Payload (For Debugging):

The returned token is an RS256-signed JWT. If you decode the payload (e.g., via jwt.io during development), you will find strict authorization claims enforcing your tenant boundary:

```json
{
"sub": "your_service_account",
"auth": "ROLE_USER",
"tenant_id": "your_tenant_id",
"iss": "LumaTrace-Enterprise-CA",
"aud": ["LumaTrace-Cloud-API"],
"jti": "a1b2c3d4-..."
}
```

Note: jti is a unique token identifier used by LumaTrace for active session revocation (blocklisting) upon logout. Cross-tenant access is structurally prevented if the tenant_id claim does not match the requested resource.

## Step 2 — Validate Asset Requirements

Before uploading, ensure the image meets:

Format: JPEG or PNG

Maximum size: 25MB

Maximum resolution: 16 Megapixels

Optional but recommended:
Generate a SHA-256 hash of the asset locally before submission.

Example (macOS/Linux):

```bash
shasum -a 256 input.jpg
```

## Step 3 — Protect Asset (C2PA Injection)

Submit a multipart request with the image and metadata payload.

```bash
curl -X POST https://api.lumatrace.es/api/v1/photos/protect \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "x-request-id: req-test-001" \
  -F "image=@/path/to/input.jpg" \
  -F "request={\"contentHash\":\"YOUR_SHA256_HASH\"};type=application/json" \
  --output protected_asset.jpg
```

## Result

The response is a processed binary file returned as a stream.
Save it locally (e.g., protected_asset.jpg).

## Step 4 — Verify Asset Integrity

Upload the processed asset for integrity verification.

```bash
curl -X POST https://api.lumatrace.es/api/v1/photos/verify \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -F "image=@protected_asset.jpg" \
  -F "photoId=YOUR_UUID_HERE"
```

## Example Response

```json
{
  "authentic": true,
  "confidenceScore": 97.48
}
```

For automation workflows, refer to the /examples directory and the official Postman collection.

## Common Integration Errors & Troubleshooting

To accelerate your integration, here are the most common errors encountered during onboarding and how to resolve them:

| HTTP Status               | Error Code / Context            | Common Cause & Resolution                                                                                                                                                                |
|:--------------------------|:--------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **400 Bad Request**       | Login fails                     | **Cause:** Missing `tenantId`, `username`, or `password` in the JSON payload.<br>**Fix:** Ensure all three fields are provided exactly as shown in Step 1.                               |
| **401 Unauthorized**      | `AUTH_EXPIRED` or Missing Token | **Cause:** The JWT has expired (TTL is 60 minutes) or the `Authorization: Bearer` header is missing/malformed.<br>**Fix:** Request a new token via `/api/v1/auth/login`.                 |
| **400 Bad Request**       | Invalid `contentHash`           | **Cause:** The provided hash is not a valid 64-character lowercase hex string.<br>**Fix:** Ensure you are calculating a strict SHA-256 hash of the binary file before submission.        |
| **413 Payload Too Large** | `PAYLOAD_TOO_LARGE`             | **Cause:** The submitted image exceeds the 25MB file size limit or the 16 Megapixel resolution limit.<br>**Fix:** Compress or downscale the asset client-side before calling `/protect`. |
| **400 Bad Request**       | Unsupported Media Type          | **Cause:** The image format is not supported by the forensic engine.<br>**Fix:** Ensure the uploaded file is a valid `image/jpeg`, `image/png`, or `image/webp`.                         |
