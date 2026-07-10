---
description: Write a conventional-commit message from a diff
---
Write a Conventional Commits message for the staged changes.

Rules:
- Format: `<type>(<scope>): <subject>` — type is one of feat, fix, docs, refactor, test, chore.
- Subject in imperative mood, no trailing period, under 72 chars.
- Add a body only if the "why" isn't obvious from the subject.

Output the commit message and nothing else.
