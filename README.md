# wy-alpine-image

Minimal Alpine base image with `curl` and `jq`, running as a non-root uid.

Published to `ghcr.io/wywywywy/wy-alpine-image`.

## Usage

```sh
docker run --rm ghcr.io/wywywywy/wy-alpine-image:latest -c 'curl -s https://api.github.com | jq .current_user_url'
```

The entrypoint is `/bin/sh`, so arguments are shell arguments — use `-c` for a
command string, or override with `--entrypoint`.

In a Dockerfile:

```dockerfile
FROM ghcr.io/wywywywy/wy-alpine-image:3.21
```

## Tags

| Tag | Meaning |
| --- | --- |
| `latest` | Tip of `main` |
| `1.2.3`, `1.2` | Release, from a `v1.2.3` git tag |
| `main` | Latest `main` build |
| `sha-<short>` | Exact commit |

## Build locally

```sh
docker build -t wy-alpine-image .
docker run --rm wy-alpine-image -c 'id && curl --version && jq --version'
```

## Notes

- Runs as `USER 1000:1000`. That uid has no `/etc/passwd` entry and no home
  directory, which is fine for most tools but means `$HOME` is unset and
  `whoami` fails. If something downstream needs a real user, add to the
  Dockerfile:
  ```dockerfile
  RUN adduser -D -u 1000 app
  ```
- Multi-arch: `linux/amd64` and `linux/arm64`.
- CI rebuilds weekly so apk security fixes reach the published tags without a
  commit.

## Releasing

```sh
git tag v1.0.0 && git push origin v1.0.0
```
