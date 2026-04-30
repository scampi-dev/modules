<!--
  Hi, and thanks for sending this!

  Pre-filling a few sections below to make review faster. Skip any that
  genuinely don't apply — "n/a" is a fine answer.
-->

## Summary

<!-- One or two sentences. What does this PR do, and why? -->

## Linked issue

<!--
  Use Forgejo magic keywords:
    closes #N   — non-bug change that resolves an issue
    fixes  #N   — bug fix that resolves an issue
    refs   #N   — related but doesn't close

  PRs without an issue tend to stall. If there isn't one, open it first
  and we'll talk through the shape before you spend time on code.
-->

## Test plan

<!--
  How did you verify this works?
  "Not sure how to test this" is a valid answer that opens a conversation.
-->

## Checklist

- [ ] `just check` passes (`scampls check` on every `.scampi` file)
- [ ] `just test` passes (`scampi test ./...`)
- [ ] New / changed module has `*_test.scampi` covering the golden path
- [ ] Commit message follows the project convention
      (see [`CONTRIBUTING.md`](../CONTRIBUTING.md))
