#!/usr/bin/env bash

target_pane="$1"

#dir="$(zoxide query -l | tv --height=100% --layout=reverse --prompt='zoxide> ')"

dir="$(
  zoxide query -l \
  | while IFS= read -r d; do
      git -C "$d" rev-parse --show-toplevel 2>/dev/null || printf '%s\n' "$d"
    done \
  | awk '!seen[$0]++' \
  | tv \
      --source-command='cat' \
      --source-display='{}' \
      --source-output='{}' \
      --no-remote \
      --no-help-panel \
      --input-header='Jump to directory' \
      --input-prompt='zoxide> ' \
      --preview-command='eza --color=always --icons=always -la {}' \
      --preview-header='{}' \
      --preview-border=rounded \
      --results-border=rounded \
      --input-border=rounded
)"

[ -z "$dir" ] && exit 0

if [ -n "$TMUX" ]; then
  tmux send-keys -t "$target_pane" "cd \"$dir\"" Enter
else
  tuios send-text -w "$target_pane" "cd \"$dir\""$'\n'
fi
