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

echo "[*] Phase 2: System Health Check & Session Teardown"
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$API_BASE/v1/auth/logout" \
     -H "Authorization: Bearer $TOKEN")

if [ "$HTTP_STATUS" == "200" ]; then
    echo "[+] Smoke test completed successfully. Clean teardown (HTTP $HTTP_STATUS)."
else
    echo "[!] Smoke test failed during teardown (HTTP $HTTP_STATUS)."
    exit 1
fi
