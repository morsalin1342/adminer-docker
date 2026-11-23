#!/bin/bash
# Compare the Adminer pin in the Dockerfile with upstream.
#
#   1. the latest Adminer release on GitHub (vrana/adminer) against ADMINER_VERSION;
#   2. the official image's <version>-standalone tag on Docker Hub: whether it exists for
#      the latest release, and whether the pinned tag still has the pinned digest.
#
# Prints one line per check and exits 1 if anything is behind, 2 if a lookup failed.
# Needs bash, curl and jq. GITHUB_TOKEN, when set, is sent to the GitHub API to avoid
# its anonymous rate limit.
set -euo pipefail

cd "$(dirname "$0")/.."

gh_api() {
    local auth=()
    if [ -n "${GITHUB_TOKEN:-}" ]; then auth=(-H "Authorization: Bearer ${GITHUB_TOKEN}"); fi
    curl -fsSL "${auth[@]}" -H 'Accept: application/vnd.github+json' "https://api.github.com/$1"
}

# Succeeds when $1 sorts before $2 as a version.
older() { [ "$1" != "$2" ] && [ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | head -n1)" = "$1" ]; }

pinned=$(sed -n 's/^ARG ADMINER_VERSION=\([0-9.]*\)$/\1/p' Dockerfile)
pinned_digest=$(sed -n 's/^FROM adminer:[^@]*@\(sha256:[0-9a-f]*\)$/\1/p' Dockerfile)
if [ -z "$pinned" ] || [ -z "$pinned_digest" ]; then
    echo "error: could not read ADMINER_VERSION or the FROM digest from the Dockerfile" >&2
    exit 2
fi

behind=0

latest=$(gh_api repos/vrana/adminer/releases/latest | jq -r '.tag_name | ltrimstr("v")') \
    || { echo "error: could not read the latest Adminer release" >&2; exit 2; }

# Docker Hub returns 404 for a tag that does not exist.
hub_digest() {
    curl -fsSL "https://hub.docker.com/v2/repositories/library/adminer/tags/$1" 2>/dev/null \
        | jq -r '.digest // empty' || true
}

if older "$pinned" "$latest"; then
    behind=1
    latest_digest=$(hub_digest "${latest}-standalone")
    if [ -n "$latest_digest" ]; then
        echo "BEHIND  Adminer ${pinned} is pinned; ${latest} is released and adminer:${latest}-standalone is ${latest_digest}"
    else
        echo "BEHIND  Adminer ${pinned} is pinned; ${latest} is released, but the official image has no ${latest}-standalone tag yet"
    fi
else
    echo "OK      Adminer ${pinned} is the latest release"
fi

current_digest=$(hub_digest "${pinned}-standalone")
if [ -z "$current_digest" ]; then
    echo "error: could not read the digest of adminer:${pinned}-standalone" >&2
    exit 2
elif [ "$current_digest" != "$pinned_digest" ]; then
    behind=1
    echo "BEHIND  adminer:${pinned}-standalone is now ${current_digest}; the Dockerfile pins ${pinned_digest}"
else
    echo "OK      adminer:${pinned}-standalone still has the pinned digest"
fi

exit "$behind"
