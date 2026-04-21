[default]
[doc("Show available recipes")]
@help:
  just --unsorted --list

mod npm
mod unifi

[doc("Check all module files (scampls check)")]
check:
  #!/usr/bin/env bash
  set -euo pipefail
  failed=0
  for f in $(find . -name '*.scampi' ! -name '*_test.scampi' -not -path '*/.*/*'); do
    echo "check $f"
    scampls check "$f" || failed=1
  done
  exit $failed

[doc("Run all module tests")]
test:
  scampi test ./...
