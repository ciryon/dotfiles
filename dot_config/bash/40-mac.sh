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

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"

# Bash completions
#
if [ -f /opt/homebrew/etc/bash_completion ]; then
  . /opt/homebrew/etc/bash_completion
fi

