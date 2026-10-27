# Adminer

The official [Adminer](https://www.adminer.org/) database tool image plus Alpine security updates.

```bash
docker pull easydigital/adminer:6.1.2
docker run --rm -p 127.0.0.1:8080:8080 easydigital/adminer:6.1.2
```

- Adminer, PHP and the entrypoint are the official `adminer:6.1.2-standalone` ones, pinned by digest.
- One extra step: `apk upgrade`, so Alpine's fixes are in without waiting for the next official release.
- Runs as the unprivileged `adminer` user on port 8080.
- It has no sign-in restriction of its own: keep port 8080 off the internet and put it behind something that does.

Source and build files: <https://github.com/morsalin1342/adminer-docker>

Licence: Adminer is Apache License 2.0 or GPL 2.0 (at `/licenses/adminer-LICENSE` in the image); the build files are MIT.
