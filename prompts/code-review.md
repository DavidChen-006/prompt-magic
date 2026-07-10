---
description: Ask Claude to do a thorough code review of the current changes
---
Please do a thorough code review of the changes on the current branch.

Focus on:
- Correctness: logic errors, edge cases, off-by-one mistakes, error handling.
- Design: is this the simplest approach that solves the problem? Flag any over-engineering or unnecessary abstraction.
- Tests: are the new code paths covered? Point out missing happy-path, edge-case, and error-case tests.
- Security: input validation, injection risks, secrets in code, unsafe defaults.

For each issue, give the file and line, explain why it matters, and suggest a concrete fix. Group findings by severity (blocking / should-fix / nit). Do not rewrite the whole diff — point me to what needs changing.
