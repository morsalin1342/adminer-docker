# Contributing

Thanks for your interest in improving this Adminer Docker image.

This image is deliberately small: it is the official `adminer:<version>-standalone` image plus
Alpine's security updates, and nothing else. A change that patches or rebuilds Adminer, PHP or
the entrypoint is out of scope; a plugin or theme belongs in your own image built `FROM` this one.

## How to Contribute

### Report a Bug
1. Open an issue with the image tag, the error message and the steps to reproduce
2. If it is a problem in Adminer itself, it belongs to the [Adminer project](https://github.com/vrana/adminer)
3. For a security problem, do not open an issue: see [SECURITY.md](SECURITY.md)

### Submit a Pull Request
1. Fork the repo and create a branch
2. Make the change in the `Dockerfile`
3. Test locally:
   ```bash
   docker build -t test-adminer .
   docker run --rm -p 127.0.0.1:8080:8080 test-adminer
   ```
   then open <http://127.0.0.1:8080> and sign in to a test database
4. Open a PR against `master` with a clear description

Every pull request that touches the `Dockerfile`, `.trivyignore`, `ADMINER-LICENSE` or the
publish workflow builds the image and scans it with Trivy; nothing is pushed from a pull request.

## Project Structure

```
.
├── Dockerfile                 # The official image plus apk upgrade
├── ADMINER-LICENSE            # Adminer's licence, copied into the image
├── .github/workflows/         # Build, scan and publish; docs consistency check
├── README.md                  # GitHub README
├── README.dockerhub.md        # Personal Docker Hub description
└── README.dockerhub-org.md    # Org Docker Hub description
```

## Version Upgrades

To move to a new Adminer release:
1. Update `ADMINER_VERSION` and the digest in the `FROM` line of the `Dockerfile` together
   (`docker buildx imagetools inspect adminer:<version>-standalone` prints the digest)
2. Check that Adminer's licence has not changed, and update `ADMINER-LICENSE` if it has
3. Update the version in the READMEs and in [SECURITY.md](SECURITY.md)
4. Test the build locally; the workflow reads the version from the `ARG` for tagging

## Code of Conduct

This project follows the [Contributor Covenant](CODE_OF_CONDUCT.md).
