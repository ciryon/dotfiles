# Robust Git completion for 'git' and alias 'g' (Linux + macOS)

# ensure programmable completion
shopt -q progcomp || shopt -s progcomp

# load bash-completion core (if present)
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion
[[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ]] && . /opt/homebrew/etc/profile.d/bash_completion.sh

# load git’s completion script
# Linux
[[ -r /usr/share/bash-completion/completions/git ]] && . /usr/share/bash-completion/completions/git
# macOS (Homebrew)
[[ -r /opt/homebrew/etc/bash_completion.d/git-completion.bash ]] && . /opt/homebrew/etc/bash_completion.d/git-completion.bash

# ensure 'g' alias exists (define only if missing)
alias g >/dev/null 2>&1 || alias g='git'

# bind completion to 'g'
# newer git-completion exposes __git_main; older uses _git
if type __git_complete >/dev/null 2>&1; then
  if type __git_main >/dev/null 2>&1; then
    __git_complete g __git_main
  else
    __git_complete g _git
  fi
else
  # very old fallback
  complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null
fi
