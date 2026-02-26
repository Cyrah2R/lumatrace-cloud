# Enterprise Onboarding Guide

This guide walks you through the standard integration flow for the LumaTrace Cloud API.

---

## Step 1 — Authenticate and Retrieve JWT

All API interactions require a valid tenant-scoped JWT.

### Request

```bash
curl -X POST https://api.lumatrace.es/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username": "your_service_account", "password": "your_password"}'
```

### Response

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

Store the token value. It must be included in the Authorization header of subsequent requests.

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

