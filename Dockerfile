# Adminer, the official image plus Alpine's security updates.
#
# The official image is pinned by tag and digest, so a rebuild never changes what it is built
# on. To move forward: bump ADMINER_VERSION and the digest together
# (docker buildx imagetools inspect adminer:<version>-standalone).
ARG ADMINER_VERSION=6.1.2

FROM adminer:${ADMINER_VERSION}-standalone@sha256:251295c1cd51d3889f1c42ffa4864b24eeab51f0caf395cfe5bf4726c5ec9a2a

ARG ADMINER_VERSION

# The official image runs as the `adminer` user, so the upgrade needs root for one layer only.
USER root

# Alpine has fixed the findings the official image still carries; take them now rather than
# wait for the next official release. `apk upgrade` changes nothing else: Adminer itself,
# PHP and the entrypoint stay as the official image ships them.
RUN apk upgrade --no-cache

# Adminer is "Apache License 2.0 or GPL 2.0" (its LICENSE file, v6.1.2). The image carries it.
COPY ADMINER-LICENSE /licenses/adminer-LICENSE

LABEL org.opencontainers.image.title="Adminer" \
      org.opencontainers.image.description="Adminer database tool, the official image with Alpine security updates" \
      org.opencontainers.image.version="${ADMINER_VERSION}" \
      org.opencontainers.image.licenses="Apache-2.0 OR GPL-2.0-only" \
      org.opencontainers.image.source="https://github.com/morsalin1342/adminer-docker" \
      org.opencontainers.image.base.name="docker.io/library/adminer:${ADMINER_VERSION}-standalone"

USER adminer
