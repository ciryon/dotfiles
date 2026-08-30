# Prompt. Previously this lived inside 40-mac.sh behind a Darwin guard, which
# is why every Linux box without Omarchy fell back to the bare `\u@\h:\w\$`.

path_display() {
  local p="$PWD" home="$HOME" ell="…"

  [[ "$p" == "$home" ]] && { printf '~'; return; }

  local top
  if top=$(git rev-parse --show-toplevel 2>/dev/null); then
    if [[ "$p" == "$top" ]]; then
      printf '%s' "${top##*/}"
    else
      printf '%s:%s' "${top##*/}" "${p#"$top"/}"
    fi
    return
  fi

  local disp="${p/#$home/~}"
  IFS='/' read -r -a parts <<<"$disp"
  local n=${#parts[@]}
  if ((n <= 2)); then
    printf '%s' "$disp"
  else
    printf '%s/%s/%s' "$ell" "${parts[n - 2]}" "${parts[n - 1]}"
  fi
}

c_reset='\[\e[0m\]'
c_lblue='\[\e[36m\]'
c_yellow='\[\e[33m\]'

# Omarchy ships its own prompt; don't fight it on telchar. Set
# DOTFILES_FORCE_PROMPT=1 to use this one everywhere instead.
if [[ "${DOTFILES_OMARCHY:-0}" == "1" && "${DOTFILES_FORCE_PROMPT:-0}" != "1" ]]; then
  :
# Show the host when connected over SSH — easy to forget which box you are on
# when several of them share a prompt.
elif [[ -n "$SSH_CONNECTION" ]]; then
  PS1="${c_yellow}\h${c_reset} ${c_lblue}[\$(path_display)] >${c_reset} "
else
  PS1="${c_lblue}[\$(path_display)] >${c_reset} "
fi

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"
