# prompt-magic

A prompt library for Claude Code. Store reusable prompts as files, then pull
any of them onto your clipboard with a single command so you can paste and edit
before sending.

Prompt bodies live in `prompts/*.md` and are only ever read by
`scripts/prompt.sh` — Claude never recalls them from memory, so what you get is
exactly what's on disk.

## Usage

Inside Claude Code:

- `/prompt` — list all stored prompts as a table (name + description).
- `/prompt <name>` — copy that prompt's full text to the macOS clipboard, then
  press Cmd+V to paste it into your input box and edit before sending.

Directly from a shell:

```sh
scripts/prompt.sh list          # aligned NAME / DESCRIPTION table
scripts/prompt.sh get <name>    # print the prompt body to stdout
scripts/prompt.sh copy <name>   # copy the prompt body to the clipboard (pbcopy)
```

An unknown name prints an error and the list of valid prompts to stderr and
exits 1.

## Install

Symlink the repo into your Claude Code skills directory so `/prompt` is
available globally:

```sh
ln -sfn /Users/davidchen/prompt-magic /Users/davidchen/.claude/skills/prompt
```

(Adjust the paths if you cloned the repo elsewhere.)

## Adding a prompt

Create `prompts/<name>.md` with YAML frontmatter holding a single
`description:` line, followed by the raw prompt body:

```markdown
---
description: One-line summary shown in the list table
---
The full prompt text goes here, on as many lines as you need.
```

The prompt's name is the filename without `.md`. There's no index to update —
the files are the library.

## Requirements

macOS (uses `pbcopy`). No other dependencies.
