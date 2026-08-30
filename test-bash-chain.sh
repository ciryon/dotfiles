#!/usr/bin/env bash
# Smoke-test the bash chain the way a server sees it: a HOME with no Omarchy rc
# and no PulsSolutions checkout, which is the case the chain kept getting wrong.
# Usage: ./test-bash-chain.sh [dir-holding-the-*.sh-files]
# Defaults to this repo's dot_config/bash, so it tests the source, not what is
# currently applied.
set -u
src="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/dot_config/bash}"
fake=$(mktemp -d); trap 'rm -rf "$fake"' EXIT
export HOME="$fake" SSH_CONNECTION="" PS1_SHOWN=1
export PATH=/usr/local/bin:/usr/bin:/bin   # baseline, so PATH checks see only what the chain adds
# Point mise at the fake home too, or it warns about the real config being
# untrusted under a HOME it does not recognise — noise that reads like a failure.
export MISE_CONFIG_DIR="$fake/.config/mise" MISE_DATA_DIR="$fake/.local/share/mise"
unset DOTFILES_OMARCHY

# `type` only sees aliases when expansion is on, which it is not in a
# non-interactive shell — and the chain's own `type ll` guard relies on it.
shopt -s expand_aliases
shopt -s nullglob
for f in "$src"/*.sh; do . "$f"; done

fail=0
chk() { if eval "$2"; then echo "ok   $1"; else echo "FAIL $1"; fail=1; fi; }

chk "prompt set without Omarchy"    '[[ -n ${PS1:-} && $PS1 == *path_display* ]]'
chk "path_display defined"          'type -t path_display >/dev/null'
chk "say defined"                   'type -t say >/dev/null'
chk "no Puls awsnpm without tree"   '! type -t awsnpm >/dev/null'
chk "no Puls dirs on PATH"          '[[ $PATH != *PulsSolutions* ]]'
chk "ll defined"                    'type ll >/dev/null 2>&1'
chk "LANG is a real locale"         'locale -a 2>/dev/null | grep -qix "${LANG//UTF-8/utf8}"'
bad_aliases() {
  local a target
  for a in $(alias -p | sed 's/^alias \([^=]*\)=.*/\1/'); do
    target=$(alias "$a" | sed 's/^alias [^=]*=.//;s/.$//' | awk '{print $1}')
    # skip aliases that wrap the command they are named after, e.g. grep
    [ "$target" = "$a" ] && continue
    command -v "$target" >/dev/null || echo "  $a -> $target"
  done
}
chk "no alias to missing binary"    '[ -z "$(bad_aliases)" ] || { bad_aliases; false; }'
exit $fail
