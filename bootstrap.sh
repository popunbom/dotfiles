#!/bin/bash

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

FILES="$( \
  find "${SCRIPT_DIR}/.bootstrap" -type f -name "*.sh" \
  | sort
)"
for FILE in ${FILES}; do
  echo "> Running: $FILE"
  "$FILE"
done
