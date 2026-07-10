# prompt-magic

A deterministic prompt library for [espanso](https://espanso.org/). Save prompts
as Markdown files, run one script, and then pull any prompt into any text box
(Claude Code terminal, a browser AI chat, an editor — anywhere you can type) via
espanso's search popup. No LLM, no network, no runtime magic: the script just
generates a static espanso match file.

## How the flow works

1. **Add a prompt** — drop a file in `prompts/`, e.g. `prompts/code-review.md`:

   ```markdown
   ---
   description: Review code for bugs, style, and efficiency
   ---
   Review this code for correctness, style, efficiency, and safety.
   Flag high-priority issues first and cite line numbers.
   ```

   The filename (minus `.md`) becomes the trigger; the `description:` becomes the
   label shown in the search popup; everything after the frontmatter is the
   prompt text that gets inserted.

2. **Run the sync script** — regenerates and installs the espanso match file:

   ```sh
   scripts/sync.sh            # generate + install into espanso's match dir
   scripts/sync.sh --stdout   # print the generated YAML without installing
   ```

   The script is idempotent — rerun it any time you add, edit, or remove a
   prompt. It owns the generated file entirely (`prompt-magic.yml`, marked
   "GENERATED — do not edit"); don't hand-edit that file, edit `prompts/`.

3. **Use it anywhere** — type the search trigger `:prompt` in any text box. The
   espanso search popup opens; filter by name or label, arrow-key to the prompt
   you want, and press Enter to insert its full text.

   You can also insert a prompt directly by typing its trigger, e.g.
   `:code-review`.

## Trigger naming

Triggers come straight from filenames: `prompts/<name>.md` → trigger `:<name>`.
So `prompts/explain-regex.md` is inserted with `:explain-regex` (or found by
typing `:prompt` and searching for "regex"). Keep filenames short and
hyphenated.

## Requirements

- macOS (this setup targets macOS; espanso is cross-platform but the paths here
  are macOS)
- [espanso](https://espanso.org/) — `brew install --cask espanso`
- `python3` with PyYAML — only needed if you want to run the round-trip
  validation; not required for normal use

## First-time setup

```sh
brew install --cask espanso     # installs Espanso.app + the espanso CLI
espanso service register         # register the launch agent
scripts/sync.sh                  # install your prompts as matches
espanso start                    # start the background daemon
```

The search trigger is configured in espanso's own config file
(`~/Library/Application Support/espanso/config/default.yml`) via:

```yaml
search_trigger: ":prompt"
```

### Manual step: grant Accessibility permission

espanso needs macOS **Accessibility** permission to read your keystrokes and
inject text. This can only be granted by you, in the GUI:

**System Settings → Privacy & Security → Accessibility** → enable **Espanso**
(and **espanso** if it appears as a separate binary).

You must also start espanso from your own logged-in desktop session
(`espanso start`, or launch Espanso.app) — it won't run from a background/SSH
session. Verify it's running with `espanso service status`.

## Verifying

```sh
espanso match list      # should list every prompt with its trigger and label
scripts/sync.sh --stdout | python3 -c "import yaml,sys; yaml.safe_load(sys.stdin.read()); print('valid')"
```
