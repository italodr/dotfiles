#!/bin/bash

personio() {
  PERSON_ID="9126282"
  URL="https://api.personio.de/v2/attendance-periods?skip_approval=false"
  DATE="${1:-$(date +%Y-%m-%d)}"
  HEADERS=(-H "Beta: true" -H "accept: application/json" -H "content-type: application/json")

  PERIODS_WORKFLOW=(
    "WORK|09:00|13:00"
    "BREAK|13:00|14:00"
    "WORK|14:00|18:00"
  )

  generate_timestamp() {
    local INPUT="$1"
    if date -d "$INPUT" +"%Y" >/dev/null 2>&1; then
      # GNU date (Linux)
      date -u -d "$INPUT" +"%Y-%m-%dT%H:%M:%S.000Z"
    else
      # BSD date (macOS)
      date -u -j -f "%Y-%m-%dT%H:%M" "$INPUT" +"%Y-%m-%dT%H:%M:%S.000Z"
    fi
  }

  for ENTRY in "${PERIODS_WORKFLOW[@]}"; do
    IFS='|' read -r TYPE START END <<< "$ENTRY"
    START_TIMESTAMP=$(generate_timestamp "${DATE}T${START}")
    END_TIMESTAMP=$(generate_timestamp "${DATE}T${END}")

    PAYLOAD=$(cat <<EOF
{
  "person": {
    "id": "$PERSON_ID"
  },
  "type": "$TYPE",
  "start": {
    "date_time": "$START_TIMESTAMP"
  },
  "end": {
    "date_time": "$END_TIMESTAMP"
  }
}
EOF
)

    echo "Enviando $TYPE de $START a $END para $DATE..."
    curl --request POST "${HEADERS[@]}" --url "$URL" --data "$PAYLOAD"
    echo ""
  done
}
personio "$@"
