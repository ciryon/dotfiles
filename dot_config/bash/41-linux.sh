# Linux-only fallbacks.
#
# On Arch + Omarchy (telchar) this file does almost nothing: Omarchy's rc has
# already defined ll/la/ls, and we do not clobber it. On plain Ubuntu nothing
# else defines them, and you get a bare shell with no ll.
[[ "$(uname -s)" != "Linux" ]] && return 0

# Only define what is not already defined — respects Omarchy and anything else.
if ! type ll >/dev/null 2>&1; then
  if command -v eza >/dev/null 2>&1; then
    alias ls='eza -al --group --header --time-style=long-iso'
    alias ll='eza -l  --group --header --git --time-style=long-iso'
    alias la='eza -la --group --header --git --time-style=long-iso'
  else
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    alias ll='ls -lh  --color=auto --group-directories-first'
    alias la='ls -lAh --color=auto --group-directories-first'
  fi
fi

# Do NOT force en_US.UTF-8: a server may only have C.utf8 generated, and
# forcing a missing locale is what produces the `setlocale` warning on every
# SSH in. Pick a UTF-8 locale that actually exists.
if [[ -z "${LANG:-}" || "$LANG" == "C" || "$LANG" == "POSIX" ]]; then
  if locale -a 2>/dev/null | grep -qi '^en_US\.utf-\?8$'; then
    export LANG=en_US.UTF-8
  elif locale -a 2>/dev/null | grep -qi '^C\.utf-\?8$'; then
    export LANG=C.UTF-8
  fi
fi
