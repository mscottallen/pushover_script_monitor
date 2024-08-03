#!/bin/bash

JOB_NAME="script_name" # The command or script name to monitor
API_TOKEN="your_pushover_api_token"
USER_KEY="your_pushover_user_token"
MESSAGE="Your job (${JOB_NAME}) has completed."

# Monitor the job
while pgrep -f "$JOB_NAME" > /dev/null; do
  sleep 60 # Check every 60 seconds
done

# Send Pushover notification
curl -s \
  --form-string "token=${API_TOKEN}" \
  --form-string "user=${USER_KEY}" \
  --form-string "message=${MESSAGE}" \
  https://api.pushover.net/1/messages.json
