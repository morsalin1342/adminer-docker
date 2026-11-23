# Adminer Docker Image

[![License](https://img.shields.io/github/license/morsalin1342/adminer-docker?style=for-the-badge)](https://github.com/morsalin1342/adminer-docker/blob/main/LICENSE)
[![Docker Publish](https://github.com/morsalin1342/adminer-docker/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/morsalin1342/adminer-docker/actions/workflows/docker-publish.yml)

[Adminer](https://www.adminer.org/), the single-file database tool, as the official `adminer`
image plus Alpine's security updates.

```bash
docker pull morsalin1342/adminer:6.3.0
docker run --rm -p 127.0.0.1:8080:8080 morsalin1342/adminer:6.3.0
```

**Platform:** linux/amd64 only. `morsalin1342/adminer` on Docker Hub and `ghcr.io/morsalin1342/adminer` on GitHub Container Registry are the same image, pushed by the same build with the same digest; pull whichever you prefer.

## What this is, and what it is not

The published image **is** the official `adminer:<version>-standalone` image, pinned by tag and
digest in the [Dockerfile](Dockerfile), with one extra step: `apk upgrade`, so Alpine's fixes
for the base packages are in the image without waiting for the next official release.

- Adminer itself, PHP and the entrypoint are the official ones. Nothing is patched or rebuilt.
- It runs as the unprivileged `adminer` user and listens on port 8080.
- It does not sign anyone in or restrict who can reach it. Put it behind something that does,
  and never publish port 8080 to the internet.

Each build is scanned with Trivy before it is pushed, and a fixable critical or high finding
stops the push (see [Publishing](#publishing)).

## Versions

| Tag | Adminer | Base |
|---|---|---|
| `6.3.0`, `latest` | 6.3.0 | `adminer:6.3.0-standalone` |

## Publishing

A push to `main` that changes the `Dockerfile`, `.trivyignore`, `ADMINER-LICENSE`, `LICENSE`
or one of the two READMEs, a weekly scheduled run and a manual run all build the image and
scan it with Trivy. A fixable critical or high vulnerability stops the run before anything is
pushed (a waiver, with its reason and expiry date, goes in [.trivyignore](.trivyignore));
otherwise the image is pushed to `morsalin1342/adminer` on Docker Hub and
`ghcr.io/morsalin1342/adminer`, and the Docker Hub description is updated from `README.dockerhub.md`.
Every build that completes keeps an SPDX SBOM as a workflow artifact, whether or not its scan
passed. A pull request that changes the `Dockerfile`, `.trivyignore`, `ADMINER-LICENSE` or the
publish workflow builds and scans but never pushes. See [SECURITY.md](SECURITY.md) for
reporting a vulnerability.

## Licence

The files in this repository are MIT ([LICENSE](LICENSE)). That licence covers the build files,
not the software in the image, which keeps its own licences:

| Component | Licence |
|---|---|
| Adminer | "Apache License 2.0 or GPL 2.0" ([ADMINER-LICENSE](ADMINER-LICENSE), also in the image at `/licenses/adminer-LICENSE`) |
| PHP, from the official image | PHP-3.01 (the PHP License) |
| Alpine packages from the base image | their own licences |

The SPDX SBOM each build writes, kept as an artifact of its workflow run, lists every package
with the licence it declares.

## Related Images & Tools

<!-- BEGIN GENERATED: related (from catalog.yaml in the morsalin1342/docker-images repository; do not edit by hand) -->
Every image is published to Docker Hub as `morsalin1342/<image>` and to GitHub Container Registry as `ghcr.io/morsalin1342/<image>`, from the same build.

| Repository | Images | Description |
|---|---|---|
| [caddy-docker](https://github.com/morsalin1342/caddy-docker) | `morsalin1342/caddy` · `ghcr.io/morsalin1342/caddy` | Standalone Caddy with WAF, rate limiting & caching |
| [frankenphp-docker](https://github.com/morsalin1342/frankenphp-docker) | `morsalin1342/frankenphp` · `ghcr.io/morsalin1342/frankenphp` | Caddy + PHP app server in one container |
| [php-docker](https://github.com/morsalin1342/php-docker) | `morsalin1342/php` · `ghcr.io/morsalin1342/php` | Traditional PHP-FPM & CLI images |
| [nginx-docker](https://github.com/morsalin1342/nginx-docker) | `morsalin1342/nginx` · `ghcr.io/morsalin1342/nginx` | nginx with ModSecurity 3, Brotli, zstd & GeoIP2 |
| [apache-docker](https://github.com/morsalin1342/apache-docker) | `morsalin1342/apache` · `ghcr.io/morsalin1342/apache` | Apache httpd as a static server or php-fpm application server, no PHP inside |
<!-- END GENERATED: related -->
