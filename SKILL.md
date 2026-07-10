---
name: prompt
description: >-
  Prompt library for Claude Code. Triggers on `/prompt` (list all stored
  prompts as a table of name + description) and `/prompt <name>` (copy that
  prompt's full text to the macOS clipboard so the user can paste and edit it
  before sending). Prompt bodies live in files on disk and are always read via
  the script — never recalled from memory.
---

# prompt

A deterministic prompt library. Prompts are stored as files under this skill's
`prompts/` directory; a shell script reads them. You must never reproduce a
prompt body from memory — always shell out to the script so the text on disk is
the single source of truth.

The script lives at `scripts/prompt.sh` inside this skill's own directory. Use
its absolute path when running it.

## When the user runs `/prompt` (no argument)

Run:

```
scripts/prompt.sh list
```

Show the resulting table to the user verbatim. Do not add, rename, or
paraphrase entries.

## When the user runs `/prompt <name>`

Run:

```
scripts/prompt.sh copy <name>
```

- On success it copies the prompt body to the clipboard and prints a
  confirmation. Relay that confirmation to the user (they press Cmd+V to paste
  it into their input box and edit before sending).
- On an unknown name the script prints an error and the list of valid prompts
  to stderr and exits 1. Show that error to the user, then show the `list`
  output so they can pick a valid name.

Do not print the prompt body yourself — the point is to put it on the clipboard
for the user to paste and edit.

## Adding a new prompt

Drop a new file into `prompts/`:

```
prompts/<name>.md
```

Format — YAML frontmatter with a single `description:` line, then the raw
prompt body:

```
---
description: One-line summary shown in the list table
---
The full prompt text goes here, on as many lines as you need.
```

The prompt's name is the filename without `.md`. No index to update — the files
are the library.
