#!/usr/bin/env bash

# Exit immediately if a command fails
set -euo pipefail

scriptdir=$(dirname $(realpath $0))

SYSTEM_FILE=$scriptdir/system.md
USER_FILE=$scriptdir/user.md

# Read file contents
SYSTEM_PROMPT=$(jq -Rs '@json' < "$SYSTEM_FILE")
USER_PROMPT=$(jq -Rs '@json' < "$USER_FILE")

source $HOME/.env # to the the environment variables

# Ensure API key is set
if [[ -z "${POE_API_KEY:-}" ]]; then
  echo "Error: POE_API_KEY environment variable not set."
  exit 1
fi

## Make API call
#curl https://api.poe.com/v1/chat/completions \
  #-s \
  #-H "Content-Type: application/json" \
  #-H "Authorization: Bearer $POE_API_KEY" \
  #-d "{
    #\"model\": \"gpt-5\",
    #\"tools\": [{\"type\": \"web_search_preview\"}],
    #\"messages\": [
      #{\"role\": \"system\", \"content\": \"$SYSTEM_PROMPT\"},
      #{\"role\": \"user\", \"content\": \"$USER_PROMPT\"}
    #]
  #}" | jq -r '.choices[0].message.content'
#echo "{
    #\"model\": \"GPT-4o-Search\",
    #\"messages\": [
      #{\"role\": \"system\", \"content\": \"${SYSTEM_PROMPT:3:-3}\"},
      #{\"role\": \"user\", \"content\": \"Tell me today's date and fetch me the top headline for today. \"}
    #]
  #}" && exit

# Make API call
curl https://api.poe.com/v1/chat/completions \
  -s \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $POE_API_KEY" \
  -d "{
    \"model\": \"GPT-4o-Search\",
    \"messages\": [
      {\"role\": \"system\", \"content\": \"${SYSTEM_PROMPT:3:-3}\"},
      {\"role\": \"user\", \"content\": \"${USER_PROMPT:3:-3}\"}
    ]
  }" | jq -r '.choices[0].message.content'

