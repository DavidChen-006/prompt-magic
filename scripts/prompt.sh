#!/usr/bin/env bash
# prompt.sh — deterministic prompt library backed by files in prompts/.
# Commands: list | get <name> | copy <name>
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/../prompts"

# Print the description from a prompt file's frontmatter.
read_description() {
  sed -n 's/^description:[[:space:]]*//p' "$1" | head -n 1
}

# Print the prompt body (everything after the closing frontmatter ---).
read_body() {
  awk 'BEGIN{fm=0} /^---[[:space:]]*$/{fm++; next} fm>=2{print}' "$1"
}

# Print all prompt names (filenames without .md), sorted.
list_names() {
  for f in "$PROMPTS_DIR"/*.md; do
    [ -e "$f" ] || continue
    basename "$f" .md
  done
}

# Print valid names to stderr, then exit 1.
die_unknown() {
  echo "Unknown prompt: '$1'" >&2
  echo "Valid prompts:" >&2
  list_names | sed 's/^/  /' >&2
  exit 1
}

cmd_list() {
  printf '%-16s %s\n' "NAME" "DESCRIPTION"
  for f in "$PROMPTS_DIR"/*.md; do
    [ -e "$f" ] || continue
    printf '%-16s %s\n' "$(basename "$f" .md)" "$(read_description "$f")"
  done
}

cmd_get() {
  local name="$1"
  local file="$PROMPTS_DIR/$name.md"
  [ -f "$file" ] || die_unknown "$name"
  read_body "$file"
}

cmd_copy() {
  local name="$1"
  local file="$PROMPTS_DIR/$name.md"
  [ -f "$file" ] || die_unknown "$name"
  read_body "$file" | pbcopy
  echo "Copied '$name' to clipboard — press Cmd+V to paste."
}

case "${1:-}" in
  list) cmd_list ;;
  get)  [ $# -ge 2 ] || { echo "usage: prompt.sh get <name>" >&2; exit 1; }; cmd_get "$2" ;;
  copy) [ $# -ge 2 ] || { echo "usage: prompt.sh copy <name>" >&2; exit 1; }; cmd_copy "$2" ;;
  *)    echo "usage: prompt.sh {list|get <name>|copy <name>}" >&2; exit 1 ;;
esac
