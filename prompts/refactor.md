---
description: Ask Claude to refactor code without changing behavior
---
Please refactor the code I point you to. The goal is to improve readability and structure without changing observable behavior.

Ground rules:
- Behavior must stay identical. If tests exist, they must pass before and after; if they don't, tell me what characterization tests we'd want first.
- Make surgical changes — touch only what the refactor requires. Don't reformat or "improve" unrelated code.
- Prefer clarity over cleverness. Smaller functions, clearer names, fewer nested branches.
- No new dependencies or abstractions unless they clearly earn their place.

Before you start, briefly describe the refactor you're planning and why. Then make the change and summarize what moved and what stayed the same.
