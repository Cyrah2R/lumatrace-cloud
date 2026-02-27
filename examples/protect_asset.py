"""
LumaTrace Enterprise C2PA Integration Example (Python)
------------------------------------------------------
This script demonstrates how to authenticate a tenant and upload
a raw image for spatial watermarking and C2PA JUMBF injection.

Requirements: pip install requests urllib3
"""

import requests
import json
import hashlib
import uuid
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

# --- Configuration ---
API_BASE_URL = "https://api.lumatrace.es/api/v1"
USERNAME = "your_service_account"
PASSWORD = "your_secure_password"
IMAGE_PATH = "./sample_input.jpg"

# --- Enterprise Resiliency Setup ---
session = requests.Session()
retries = Retry(
    total=3,
    backoff_factor=1,
    status_forcelist=[429, 500, 502, 503, 504],
    allowed_methods=["POST"]
)
session.mount('https://', HTTPAdapter(max_retries=retries))

def get_sha256_hash(file_path):
    """Calculates the strict SHA-256 hash required by the LumaTrace API."""
    sha256_hash = hashlib.sha256()
    with open(file_path, "rb") as f:
        for byte_block in iter(lambda: f.read(4096), b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()

def protect_asset():
    print(f"[*] Starting LumaTrace Protection Workflow...")

    # 1. Authenticate and retrieve Tenant JWT
    try:
        auth_response = session.post(
            f"{API_BASE_URL}/auth/login",
            json={"username": USERNAME, "password": PASSWORD},
            timeout=10
        )
    except requests.exceptions.RequestException as e:
        print(f"[!] Network error during authentication: {e}")
        return

    if auth_response.status_code != 200:
        print(f"[!] Authentication Failed: {auth_response.text}")
        return

    jwt_token = auth_response.json().get("token")
    print(f"[+] Authentication Successful. Token acquired.")

    # 2. Prepare the Payload
    content_hash = get_sha256_hash(IMAGE_PATH)

    metadata = {
        "contentHash": content_hash,
        "deviceModel": "Python_Integration_Script_V1",
        "latitude": 40.4168,
        "longitude": -3.7038
    }

    # Generate Idempotency-Key for safe retries
    idempotency_key = str(uuid.uuid4())

    headers = {
        "Authorization": f"Bearer {jwt_token}",
        "Idempotency-Key": idempotency_key
    }

    print(f"[*] Uploading asset with Idempotency-Key: {idempotency_key}...")

    # 3. Execute Multipart Upload (Image + JSON Request)
    try:
        with open(IMAGE_PATH, 'rb') as img_file:
            files = {
                'image': ('upload.jpg', img_file, 'image/jpeg')
            }
            # The API expects the JSON part to be named 'request' and have application/json content type
            data = {
                'request': (None, json.dumps(metadata), 'application/json')
            }

            response = session.post(
                f"{API_BASE_URL}/photos/protect",
                headers=headers,
                files=files,
                data=data,
                timeout=30
            )

        # 4. Handle Response
        if response.status_code == 200:
            output_path = "lumatrace_protected_output.jpg"
            with open(output_path, 'wb') as f:
                f.write(response.content)
            print(f"[+] Success! Protected asset saved to: {output_path}")
            print(f"    Trace ID: {response.headers.get('x-request-id')}")
        else:
            print(f"[!] Protection Failed (HTTP {response.status_code}): {response.text}")

    except requests.exceptions.RetryError:
        print("[!] Max retries exceeded. The server is currently unavailable or enforcing strict rate limits.")
    except Exception as e:
        print(f"[!] Unexpected error during upload: {e}")

if __name__ == "__main__":
    protect_asset()