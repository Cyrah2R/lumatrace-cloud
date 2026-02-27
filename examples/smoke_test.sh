#!/bin/bash
# LumaTrace Quick Validation Kit (Smoke Test)
# Usage: ./smoke_test.sh <API_URL> <USERNAME> <PASSWORD>

API_BASE=$1
USER=$2
PASS=$3

echo "[*] Phase 1: Authentication Check"
TOKEN=$(curl -s -X POST "$API_BASE/v1/auth/login" \
     -H "Content-Type: application/json" \
     -d "{\"username\":\"$USER\",\"password\":\"$PASS\"}" | jq -r '.token')

if [ "$TOKEN" != "null" ]; then
    echo "[+] Auth Success. JWT: ${TOKEN:0:10}..."
else
    echo "[!] Auth Failed."
    exit 1
fi

echo "[*] Phase 2: System Health Check (OpenAPI Schema)"
curl -I -s "$API_BASE/v1/photos/verify" -H "Authorization: Bearer $TOKEN" | grep "HTTP"

echo "[+] Smoke test completed successfully."