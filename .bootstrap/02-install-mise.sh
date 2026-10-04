#!/bin/bash

set -euo pipefail

INSTALL_DIR="${INSTALL_DIR:-${HOME}/.local/bin}"

# REF: https://mise.jdx.dev/getting-started.html
curl https://mise.run | MISE_INSTALL_PATH="${INSTALL_DIR}/mise" sh
