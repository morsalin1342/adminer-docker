# Adminer, the official image plus Alpine's security updates.
#
# The official image is pinned by tag and digest, so a rebuild never changes what it is built
# on. To move forward: bump ADMINER_VERSION and the digest together
# (docker buildx imagetools inspect adminer:<version>-standalone).
ARG ADMINER_VERSION=6.3.0

FROM adminer:${ADMINER_VERSION}-standalone@sha256:037125c2bc4836b4917d4fd08a16f817eac2848778c4e9aab87a8340aef08dfd

ARG ADMINER_VERSION

# The official image runs as the `adminer` user, so the upgrade needs root for one layer only.
USER root

# Alpine has fixed the findings the official image still carries; take them now rather than
# wait for the next official release. `apk upgrade` changes nothing else: Adminer itself,
# PHP and the entrypoint stay as the official image ships them.
RUN apk upgrade --no-cache

# Adminer is "Apache License 2.0 or GPL 2.0" (its LICENSE file, v6.3.0). The image carries it.
COPY ADMINER-LICENSE /licenses/adminer-LICENSE

# licenses is empty on purpose. The repository's own files are MIT, but the image
# combines software under many licences (the README's Licence section names the main
# ones; the SBOM each build keeps lists every package), and no single SPDX expression
# has been derived for all of it. The base image sets no licences label today; the
# empty value keeps it that way if one is added.
LABEL org.opencontainers.image.title="adminer" \
      org.opencontainers.image.description="Adminer database tool, the official image with Alpine security updates" \
      org.opencontainers.image.version="${ADMINER_VERSION}" \
      org.opencontainers.image.licenses="" \
      org.opencontainers.image.source="https://github.com/morsalin1342/adminer-docker" \
      org.opencontainers.image.base.name="docker.io/library/adminer:${ADMINER_VERSION}-standalone"

USER adminer
