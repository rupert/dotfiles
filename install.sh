#!/bin/bash

set -euo pipefail

GIT_DELTA_VERSION=0.11.3
GITHUB_CLI_VERSION=2.4.0

tmp=$(mktemp -d)

function cleanup() {
    rm -rf "$tmp"
}

function download() {
    local url="$1"
    local path="$2"

    curl -fsSL -o "$path" "$url"
}

trap cleanup EXIT

download "https://github.com/dandavison/delta/releases/download/${GIT_DELTA_VERSION}/git-delta_${GIT_DELTA_VERSION}_amd64.deb" "$tmp/git-delta.deb"
dpkg -i "$tmp/git-delta.deb"

download "https://github.com/cli/cli/releases/download/v${GITHUB_CLI_VERSION}/gh_${GITHUB_CLI_VERSION}_linux_amd64.deb" "$tmp/gh.deb"
dpkg -i "$tmp/gh.deb"
