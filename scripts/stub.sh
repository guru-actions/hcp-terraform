#!/bin/sh
set -e

# Read inputs from environment variables
ENVIRONMENT="${ENVIRONMENT}"
OPERATION="${OPERATION}"
WORKSPACE="${WORKSPACE}"

# Generate realistic run ID (timestamp-based UUID style)
RAND="$(hexdump -n 8 -e '8/1 "%02x"' /dev/urandom 2>/dev/null || date +%N)"
RUN_ID="run-$(date +%s)-${RAND}"

# Generate HCP Terraform-style URL
RUN_URL="https://app.terraform.io/app/demo-org/workspaces/${WORKSPACE}/runs/${RUN_ID}"

# Determine status based on operation
case "${OPERATION}" in
  plan)
    STATUS="planned"
    ;;
  apply)
    STATUS="applied"
    ;;
  drift)
    STATUS="drifted"
    ;;
  *)
    echo "Unknown operation: ${OPERATION}"
    exit 1
    ;;
esac

# Generate realistic Terraform plan summary JSON
SUMMARY_JSON="{\"add\": 1, \"change\": 0, \"destroy\": 0, \"operation\": \"${OPERATION}\", \"environment\": \"${ENVIRONMENT}\"}"

# Write outputs using CloudBees Unify format
printf '%s' "${RUN_ID}" > "$CLOUDBEES_OUTPUTS/run_id"
printf '%s' "${RUN_URL}" > "$CLOUDBEES_OUTPUTS/run_url"
printf '%s' "${STATUS}" > "$CLOUDBEES_OUTPUTS/status"
printf '%s' "${SUMMARY_JSON}" > "$CLOUDBEES_OUTPUTS/summary_json"

# Log for visibility
echo "✓ Stub mode executed successfully"
echo "  Run ID: ${RUN_ID}"
echo "  Status: ${STATUS}"
echo "  URL: ${RUN_URL}"
echo "  Summary: ${SUMMARY_JSON}"
