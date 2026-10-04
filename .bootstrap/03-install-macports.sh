#!/bin/bash

set -euo pipefail

# If you want to install a specific version, please specify Git tag like "tags/v1.2.3"
# REF: https://github.com/macports/macports-base/releases
GIT_RELEASE="${GIT_RELEASE:-latest}"

# REF: https://www.macports.org/install.php
[[ "$(xcode-select --print-path 2>/dev/null)" == "" ]] && xcode-select --install

MACOS_VERSION=""
if [[ "$(sw_vers -productVersion)" =~ ^([0-9]+)(\.[0-9]+)? ]]; then
  MAJOR="${BASH_REMATCH[1]}"
  MINOR="${BASH_REMATCH[2]#.}"
  if [[ "${MAJOR}" -le 10 ]]; then
    MACOS_VERSION="${MAJOR}.${MINOR}"
  else
    MACOS_VERSION="${MAJOR}"
  fi
fi

echo "[+] Determining MacPorts version to download"
API_RESULT="$(mktemp -u)"
curl -L "https://api.github.com/repos/macports/macports-base/releases/${GIT_RELEASE}" -o "$API_RESULT"
MACPORTS_VERSION="$( \
  jq -r '.tag_name' "$API_RESULT" \
  | grep -o '[0-9.]\+' \
)"
DOWNLOAD_URL="$( \
  jq -r ".assets[] | select(.name | test(\".*${MACPORTS_VERSION}-${MACOS_VERSION}-.*.pkg$\")) | .browser_download_url" \
  "$API_RESULT" \
)"

cd "$(mktemp -d)"

echo "[+] Downloading MacPorts pkg: ${DOWNLOAD_URL}"
SAVE_NAME="$(basename "${DOWNLOAD_URL}")"
curl -L "${DOWNLOAD_URL}" -o "${SAVE_NAME}"

echo "[+] Installing package: ${SAVE_NAME}"
sudo installer -pkg "${SAVE_NAME}" -target /

echo "[+] Check installation"
(set -x; /opt/local/bin/port version)

echo "[+] MacPorts installation completed successfully"
