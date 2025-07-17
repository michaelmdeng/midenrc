#!/bin/bash

# File: apply-model-options.sh
# Usage: ./apply-model-options.sh model-options.json

set -euo pipefail

JSON_FILE="${1:-model-options.json}"

if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed. Install it and try again."
    exit 1
fi

if ! command -v llm &> /dev/null; then
    echo "Error: llm CLI is not installed or not in PATH."
    exit 1
fi

if [[ ! -f "$JSON_FILE" ]]; then
    echo "Error: File '$JSON_FILE' not found."
    exit 1
fi

# Iterate through each model and its associated options
jq -r 'to_entries[] | .key as $model | .value | to_entries[] | "\($model) \(.key) \(.value)"' "$JSON_FILE" | while read -r MODEL KEY VALUE; do
    echo "Setting option for model '$MODEL': $KEY = $VALUE"
    llm models options set "$MODEL" "$KEY" "$VALUE"
done
