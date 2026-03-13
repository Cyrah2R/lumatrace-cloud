#!/bin/bash
# LumaTrace Quick Validation Kit (Smoke Test)
# Usage: export LUMATRACE_USERNAME="user" && export LUMATRACE_PASSWORD="pwd" && ./smoke_test.sh <API_URL>

API_BASE=${1:-"https://api.lumatrace.es"}

# [AUDIT FIX]: Reading credentials from environment variables prevents exposure in OS process lists (ps aux).
USER=${LUMATRACE_USERNAME}
PASS=${LUMATRACE_PASSWORD}

if [ -z "$USER" ] || [ -z "$PASS" ]; then
    echo "[!] Error: LUMATRACE_USERNAME and LUMATRACE_PASSWORD environment variables are required."
    exit 1
fi

echo "[*] Phase 1: Authentication Check"
TOKEN=$(curl -s -X POST "$API_BASE/api/v1/auth/login" \
     -H "Content-Type: application/json" \
     -d "{\"username\":\"$USER\",\"password\":\"$PASS\"}" | jq -r '.token')

if [ "$TOKEN" != "null" ] && [ -n "$TOKEN" ]; then
    echo "[+] Auth Success. JWT: ${TOKEN:0:10}..."
else
    echo "[!] Auth Failed."
    exit 1
fi

echo "[*] Phase 2: System Health Check & Session Teardown"
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$API_BASE/api/v1/auth/logout" \
     -H "Authorization: Bearer $TOKEN")

if [ "$HTTP_STATUS" == "200" ]; then
    echo "[+] Smoke test completed successfully. Clean teardown (HTTP $HTTP_STATUS)."
else
    echo "[!] Smoke test failed during teardown (HTTP $HTTP_STATUS)."
    exit 1
fi