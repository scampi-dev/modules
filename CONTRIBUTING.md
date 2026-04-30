# Contributing to scampi modules

Hi, and thanks for considering a contribution!

This is the **official module library** for
[scampi](https://codeberg.org/scampi-dev/scampi) — a collection of
reusable converge configs for common infrastructure (web servers,
containers, APIs, monitoring, ...).

## Where things live

This repo is on
**[Codeberg](https://codeberg.org/scampi-dev/modules)**. The GitHub
repository is a read-only mirror — issues and pull requests filed
there will be auto-closed with a redirect.

[Codeberg sign-up](https://codeberg.org/user/sign_up) is free, no
email confirmation needed.

## Filing issues

Issue templates pre-fill the right labels and prompts:

- **Bug** — a module behaves wrong or fails on a target
- **Feature** — you want a new module, or a new capability for an
  existing one

Security issues affecting scampi or any module go through
[scampi's `SECURITY.md`](https://codeberg.org/scampi-dev/scampi/src/branch/main/SECURITY.md) —
**don't file a public issue**.

## Pull requests

Module PRs must:

- **Include tests.** Every module needs `*_test.scampi` covering the
  golden path. `just test` runs the suite (`scampi test ./...`).
- **Pass `just check`.** Runs `scampls check` against every
  `.scampi` file.
- **Declare a clear scampi-version constraint** so consumers know
  which engine versions the module supports.
- **Link an issue.** New modules and large changes need a discussion
  first — module scope is opinionated.

## Building and testing

```bash
just check       # scampls check on all .scampi files
just test        # scampi test ./...
```

You'll need `scampi` and `scampls` on your `PATH`. Either:

- **Released binaries** — see [get.scampi.dev](https://get.scampi.dev).
- **Auto-rebuild dev wrappers** (recommended if you also have a scampi
  clone): symlink the wrappers from your scampi checkout into your
  `PATH`. They rebuild on source change and exec the fresh binary.

  ```bash
  ln -sf /path/to/scampi/scripts/scampi-dev.sh  ~/.local/bin/scampi
  ln -sf /path/to/scampi/scripts/scampls-dev.sh ~/.local/bin/scampls
  ```

  This way module changes you test always run against your latest
  scampi engine, with no manual rebuild step.

## Project-wide conventions

Commit message format, code style philosophy, and broader contributor
expectations live in
[scampi's `CONTRIBUTING.md`](https://codeberg.org/scampi-dev/scampi/src/branch/main/CONTRIBUTING.md).
This repo follows them.

## A note on module scope

Modules in this library should:

- **Solve a common, concrete need.** Niche / one-off configs belong
  in your own module repo, not here.
- **Be parametrised.** A module that only works for one specific
  setup is just a script.
- **Have narrow scope.** "Manage nginx" is one module; "manage nginx
  + provision certs + monitor uptime" is three.
- **Be tested.** No exceptions.

If you're not sure whether your idea fits, **file the issue first.**
A short discussion is the cheapest possible alignment.

## Thank you

File the issue, send the PR, ask the question. Even a "this idea
doesn't fit, here's why" is useful information for both of us.
