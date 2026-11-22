# Adminer

The official [Adminer](https://www.adminer.org/) database tool image plus Alpine security updates.

```bash
docker pull morsalin1342/adminer:6.3.0
docker run --rm -p 127.0.0.1:8080:8080 morsalin1342/adminer:6.3.0
```

**Platform:** linux/amd64 only. `morsalin1342/adminer` and `easydigital/adminer` are the same image, pushed by the same build with the same digest; pull whichever you prefer.

- Adminer, PHP and the entrypoint are the official `adminer:6.3.0-standalone` ones, pinned by digest.
- One extra step: `apk upgrade`, so Alpine's fixes are in without waiting for the next official release.
- Runs as the unprivileged `adminer` user on port 8080.
- It has no sign-in restriction of its own: keep port 8080 off the internet and put it behind something that does.
- Each build is scanned with Trivy before it is pushed; a fixable critical or high vulnerability stops the push.

Source and build files: <https://github.com/morsalin1342/adminer-docker>

## Licence

Adminer is Apache License 2.0 or GPL 2.0 (at `/licenses/adminer-LICENSE` in the image), PHP is
the PHP License 3.01, and the Alpine packages keep their own licences; the build files are MIT.
The [Licence section](https://github.com/morsalin1342/adminer-docker#licence) says more.

---

### 🔗 Related Images & Tools

<!-- BEGIN GENERATED: related (from manifest/images.yaml in the morsalin1342/.github repository; do not edit by hand) -->
| Image / Tool | Description |
|--------------|-------------|
| [morsalin1342/caddy](https://hub.docker.com/r/morsalin1342/caddy) | Standalone Caddy with WAF, rate limiting & caching |
| [morsalin1342/frankenphp](https://hub.docker.com/r/morsalin1342/frankenphp) | Caddy + PHP app server in one container |
| [morsalin1342/php](https://hub.docker.com/r/morsalin1342/php) | Traditional PHP-FPM & CLI images |
| [morsalin1342/nginx](https://hub.docker.com/r/morsalin1342/nginx) | nginx with ModSecurity 3, Brotli, zstd & GeoIP2 |
| [morsalin1342/apache](https://hub.docker.com/r/morsalin1342/apache) | Apache as a static server or php-fpm application server, no PHP inside |
| [easydigital/adminer](https://hub.docker.com/r/easydigital/adminer) | Same image, organization namespace |
<!-- END GENERATED: related -->
