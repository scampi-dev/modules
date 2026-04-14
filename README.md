# scampi modules

[![License](https://img.shields.io/badge/license-Apache--2.0-blue)](https://codeberg.org/scampi-dev/modules/src/branch/main/LICENSE)

> [!NOTE]
> Part of the [scampi](https://scampi.dev) project. Development happens on [Codeberg](https://codeberg.org/scampi-dev/modules) — please file issues and pull requests there. The GitHub mirror exists for discoverability.

Official module library for [scampi](https://scampi.dev) — reusable
convergence configs for common infrastructure APIs.

## Using a module

Add the modules repo to your `scampi.mod`:

```
module example.com/myinfra

require (
  scampi.dev/modules/npm npm-v0.1.0
)
```

Then import in your config:

```scampi
import "scampi.dev/modules/npm"

npm.proxy_host {
  domain       = "grafana.example.com"
  forward_host = "192.168.1.50"
  forward_port = 3000
}
```

## Repo structure

Each module lives in its own directory:

```
npm/
  _index.scampi           convergence wrappers (the user-facing API)
  api.scampi              generated request functions (from OpenAPI/Swagger)
  scampi.mod              module declaration
  justfile                gen + test recipes
  proxy_host_test.scampi  smoke tests against rest_mock
  README.md               docs, target setup, usage examples
```

**Two layers per module:**

| File            | Role                                                              |
| --------------- | ----------------------------------------------------------------- |
| `api.scampi`    | Generated typed request wrappers (`get_*`, `post_*`, `delete_*`). |
|                 | Regenerated from upstream API specs via `just <mod> gen`.         |
| `_index.scampi` | Hand-authored convergence functions that compose the generated    |
|                 | wrappers into idempotent `rest.resource` steps.                   |

All files in a module directory share the same `module` declaration
(e.g. `module npm`). They form a single package — functions defined
in `api.scampi` are directly callable from `_index.scampi` without
import, like Go packages.

## just recipes

The root justfile delegates to per-module justfiles via `just` modules.

**From the repo root:**

```bash
just              # list available modules
just npm help     # list npm module recipes
just npm gen      # regenerate api.scampi from upstream spec (latest pinned version)
just npm gen v2.13.7   # regenerate from a specific version
just npm test     # run module smoke tests
```

**From inside a module directory:**

```bash
cd npm
just              # list this module's recipes
just gen          # regenerate
just test         # run tests
```

## Versioning

Modules are versioned independently via per-module git tags:

```
npm-v0.1.0        tag for the npm module at version 0.1.0
adguard-v1.0.0    tag for a future adguard module
```

Module paths follow Go conventions — any domain-based path works
(`codeberg.org/...`, `github.com/...`, your own domain). Users pin
to a specific tag in their `scampi.mod`. When an upstream
API changes, the module gets a new commit + tag. Other modules in the
repo are unaffected.

## Contributing a module

1. Create a directory: `mkdir myservice`
2. If the service has an OpenAPI/Swagger spec, generate the API layer:
   ```bash
   scampi gen api --module myservice --prefix=/api -o myservice/api.scampi spec.json
   ```
3. Write convergence wrappers in `_index.scampi` that compose from
   the generated functions using `rest.resource`
4. Add a `scampi.mod` with the module declaration
5. Write a smoke test using `test.target_rest_mock`
6. Add a `justfile` with `gen` and `test` recipes
7. Add a `README.md` with target setup + usage examples

See the `npm/` module for a complete reference implementation.

## License

Apache-2.0 — see [LICENSE](LICENSE).
