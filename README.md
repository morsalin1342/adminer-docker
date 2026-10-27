# Adminer Docker Image

[![License](https://img.shields.io/github/license/morsalin1342/adminer-docker?style=for-the-badge)](https://github.com/morsalin1342/adminer-docker/blob/master/LICENSE)

[Adminer](https://www.adminer.org/), the single-file database tool, as the official `adminer`
image plus Alpine's security updates.

```bash
docker pull easydigital/adminer:6.1.2
docker run --rm -p 127.0.0.1:8080:8080 easydigital/adminer:6.1.2
```

## What this is, and what it is not

The published image **is** the official `adminer:<version>-standalone` image, pinned by tag and
digest in the [Dockerfile](Dockerfile), with one extra step: `apk upgrade`, so Alpine's fixes
for the base packages are in the image without waiting for the next official release.

- Adminer itself, PHP and the entrypoint are the official ones. Nothing is patched or rebuilt.
- It runs as the unprivileged `adminer` user and listens on port 8080.
- It does not sign anyone in or restrict who can reach it. Put it behind something that does,
  and never publish port 8080 to the internet.

It exists because the phpMyAdmin image ships a bundled copy of Twig with critical findings and
no fixed release, and SitesPanel needs a database tool whose image passes its vulnerability scan.

## Versions

| Tag | Adminer | Base |
|---|---|---|
| `6.1.2`, `latest` | 6.1.2 | `adminer:6.1.2-standalone` |

## Licence

The build files in this repository are MIT ([LICENSE](LICENSE)). Adminer is
"Apache License 2.0 or GPL 2.0" ([ADMINER-LICENSE](ADMINER-LICENSE), also in the image at
`/licenses/adminer-LICENSE`).

## Publishing

A push to `master` that changes the Dockerfile builds the image, pushes it to
`morsalin1342/adminer` and `easydigital/adminer`, fails on a fixable critical vulnerability and
keeps an SBOM. See [SECURITY.md](SECURITY.md) for reporting a vulnerability.
