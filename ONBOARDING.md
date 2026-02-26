# Enterprise Onboarding: "Zero to Protection in 15 Minutes"

This "Golden Path" guide will walk you through your first successful C2PA Soft-Binding injection using the LumaTrace Cloud API.

## Step 1: Authentication & Token Retrieval
All interactions require a Tenant-Aware JWT.

**Request:**
```bash
curl -X POST "[https://api.lumatrace.es/api/v1/auth/login](https://api.lumatrace.es/api/v1/auth/login)" \
  -H "Content-Type: application/json" \
  -d '{"username": "your_service_account", "password": "your_password"}'
```

**Expected Output:**
Save the token string from the JSON response.

## Step 2: Prepare your Asset

Ensure your image meets the pre-flight requirements:

Format: JPEG or PNG

Size: < 25MB

Resolution: < 16 Megapixels

Generate the SHA-256 hash of your image. (e.g., shasum -a 256 input.jpg on macOS/Linux).

## Step 3: Inject the Forensic Signal & C2PA Manifest

Send the multipart payload. Pass your JWT in the Authorization header.

**Request:**
```bash
curl -X POST "[https://api.lumatrace.es/api/v1/photos/protect](https://api.lumatrace.es/api/v1/photos/protect)" \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "x-request-id: req-test-001" \
-F "image=@/path/to/your/input.jpg" \
-F "request={\"contentHash\":\"YOUR_SHA256_HASH\",\"deviceModel\":\"Server_Node_A\",\"latitude\":40.41,\"longitude\":-3.70};type=application/json" \
--output protected_asset.jpg
```

**Expected Output:**
A binary file (protected_asset.jpg) downloaded to your disk. This file now contains the invisible LumaTrace spread-spectrum watermark and the cryptographically 
signed C2PA JUMBF manifest.

## Step 4: Verify the Asset (Tamper Test)

Upload the protected asset to verify its integrity.

**Request:**
```bash
curl -X POST "[https://api.lumatrace.es/api/v1/photos/verify](https://api.lumatrace.es/api/v1/photos/verify)" \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-F "image=@protected_asset.jpg" \
-F "photoId=THE_UUID_RETURNED_IN_YOUR_DASHBOARD"
```

**Expected Output:**
```bash
{
"authentic": true,
"confidenceScore": 97.48,
"tenantId": "org_enterprise_001",
"message": "Status: [C2PA Manifest: PRESENT] [Forensic Watermark: DETECTED]"
}
```

Congratulations! You have successfully completed the LumaTrace enterprise workflow. For automated scripts, check the /examples folder.