#!/bin/bash

# set -eo pipefail

INSTALL_DIR="${INSTALL_DIR:-${HOME}/.local/bin}"

# REF: https://github.com/cargo-bins/cargo-binstall
curl -L --proto '=https' --tlsv1.2 -sSf \
    https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh \
    | bash
# REF: https://github.com/rossmacarthur/sheldon#-installation
cargo binstall -y --disable-telemetry --install-path="${INSTALL_DIR}" sheldon
