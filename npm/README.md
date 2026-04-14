# npm — Nginx Proxy Manager

Scampi module for managing [Nginx Proxy Manager](https://nginxproxymanager.com)
proxy hosts via the NPM REST API.

## API spec source

The generated `api.scampi` file is produced from the official NPM
Swagger 2.0 spec, pinned to a specific release:

```
https://raw.githubusercontent.com/NginxProxyManager/nginx-proxy-manager/v2.14.0/backend/schema/swagger.json
```

To regenerate for a different version:

```bash
just gen v2.14.0
```

## Target setup

NPM uses bearer-token auth. The token is acquired automatically via
the `/api/tokens` endpoint:

```scampi
import "std"
import "std/rest"

let npm = rest.target {
  name     = "npm"
  base_url = "http://192.168.1.1:81"
  auth     = rest.bearer {
    token_endpoint = "/api/tokens"
    identity       = std.secret("npm.email")
    secret         = std.secret("npm.password")
  }
}
```

## Usage

```scampi
import "scampi.dev/modules/npm"

std.deploy(name = "proxy", targets = [npm]) {
  npm.proxy_host {
    domain         = "grafana.example.com"
    forward_scheme = "http"
    forward_host   = "192.168.1.50"
    forward_port   = 3000
  }

  npm.proxy_host {
    domain         = "nextcloud.example.com"
    forward_scheme = "https"
    forward_host   = "192.168.1.60"
    forward_port   = 443
    hsts_enabled   = true
  }
}
```

## What it does

Each `proxy_host` declaration:

1. Queries `GET /api/nginx/proxy-hosts` for an existing host matching the domain
2. If missing, creates it via `POST /api/nginx/proxy-hosts`
3. If present, compares declared state against the existing host and updates if needed

All operations are idempotent — running `scampi apply` twice produces no changes
on the second run.

## Parameters

| Parameter                  | Type   | Default | Description                          |
| -------------------------- | ------ | ------- | ------------------------------------ |
| `domain`                   | string | —       | Domain name for the proxy host       |
| `forward_scheme`           | string | `http`  | Scheme to forward to (`http`/`https`)|
| `forward_host`             | string | —       | Backend host IP or hostname          |
| `forward_port`             | int    | —       | Backend port                         |
| `ssl_forced`               | bool   | `true`  | Force HTTPS                          |
| `http2_support`            | bool   | `true`  | Enable HTTP/2                        |
| `block_exploits`           | bool   | `true`  | Block common exploits                |
| `allow_websocket_upgrade`  | bool   | `false` | Allow WebSocket connections          |
| `caching_enabled`          | bool   | `false` | Enable caching                       |
| `hsts_enabled`             | bool   | `false` | Enable HSTS                          |
| `hsts_subdomains`          | bool   | `false` | Include subdomains in HSTS           |
| `advanced_config`          | string | `""`    | Custom nginx config block            |
| `certificate_id`           | int    | `0`     | NPM certificate ID (0 = none)        |
