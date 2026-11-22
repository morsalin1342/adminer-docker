# Adminer

The official [Adminer](https://www.adminer.org/) database tool image plus Alpine security updates.

```bash
docker pull easydigital/adminer:6.3.0
docker run --rm -p 127.0.0.1:8080:8080 easydigital/adminer:6.3.0
```

**Platform:** linux/amd64 only. `morsalin1342/adminer` and `easydigital/adminer` are the same image, pushed by the same build with the same digest; pull whichever you prefer.

- Adminer, PHP and the entrypoint are the official `adminer:6.3.0-standalone` ones, pinned by digest.
- One extra step: `apk upgrade`, so Alpine's fixes are in without waiting for the next official release.
- Runs as the unprivileged `adminer` user on port 8080.
- It has no sign-in restriction of its own: keep port 8080 off the internet and put it behind something that does.
- Each build is scanned with Trivy before it is pushed; a fixable critical vulnerability stops the push.

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
| [easydigital/caddy](https://hub.docker.com/r/easydigital/caddy) | Standalone Caddy with WAF, rate limiting & caching |
| [easydigital/frankenphp](https://hub.docker.com/r/easydigital/frankenphp) | Caddy + PHP app server in one container |
| [easydigital/php](https://hub.docker.com/r/easydigital/php) | Traditional PHP-FPM & CLI images |
| [easydigital/nginx](https://hub.docker.com/r/easydigital/nginx) | nginx with ModSecurity 3, Brotli, zstd & GeoIP2 |
| [easydigital/apache](https://hub.docker.com/r/easydigital/apache) | Apache as a static server or php-fpm application server, no PHP inside |
| [morsalin1342/adminer](https://hub.docker.com/r/morsalin1342/adminer) | Same image, personal namespace |
<!-- END GENERATED: related -->
