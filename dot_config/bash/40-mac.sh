# mac-only niceties
[[ "$(uname -s)" != "Darwin" ]] && return 0

# ----- readable, colorful ls -----
# Prefer eza if available (nicer icons, columns, git, etc)
if command -v eza >/dev/null 2>&1; then
  alias ls='eza -al --group --header --time-style=long-iso'
  alias ll='eza -l --group --header --git --time-style=long-iso'
  alias la='eza -la --group --header --git --time-style=long-iso'
else
  # BSD ls colors
  export CLICOLOR=1
  # LSCOLORS: tweak as desired (dirs bold blue, symlinks cyan, etc.)
  export LSCOLORS=GxFxCxDxBxegedabagacad
  alias ls='ls -G'
  alias ll='ls -Glh'  # owner, sizes human-readable
  alias la='ls -GlAh' # include dotfiles, hide . and ..
fi

# ----- a couple of tasteful QoL aliases -----
alias grep='grep --color=auto'
alias n=nvim

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="$HOME/.local/bin:$PATH"

path_display() {
  local p="$PWD" home="$HOME" ell="…"

  # tilde at home
  if [[ "$p" == "$home" ]]; then
    printf '~'
    return
  fi

  # inside a git repo?
  local top
  if top=$(git rev-parse --show-toplevel 2>/dev/null); then
    # at repo root → just repo name
    if [[ "$p" == "$top" ]]; then
      printf '%s' "${top##*/}"
      return
    else
      # repo subdirs → repo-name:relative/path (nice and informative)
      printf '%s:%s' "${top##*/}" "${p#$top/}"
      return
    fi
  fi

  # not in a repo → show either ~/Name or …/Parent/Name
  local disp="${p/#$home/~}" # replace $HOME with ~
  IFS='/' read -r -a parts <<<"$disp"
  local n=${#parts[@]}
  if ((n <= 2)); then # "~" + one segment → ~/Name
    printf '%s' "$disp"
  else # deeper → …/Parent/Name (last two segments)
    printf '%s/%s/%s' "$ell" "${parts[n - 2]}" "${parts[n - 1]}"
  fi
}

# colors
c_reset='\[\e[0m\]'
c_lblue='\[\e[36m\]'

# Bash completions
#
if [ -f /opt/homebrew/etc/bash_completion ]; then
  . /opt/homebrew/etc/bash_completion
fi

# Prompt: [path] >
PS1="${c_lblue}[\$(path_display)] >${c_reset} "
