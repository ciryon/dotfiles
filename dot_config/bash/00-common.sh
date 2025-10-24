if [[ "$(uname -s)" == "Linux" ]] && [[ -r ~/.local/share/omarchy/default/bash/rc ]]; then
  source ~/.local/share/omarchy/default/bash/rc
fi

set -o vi

# Exports
export DEVOPS_EVENTS_DIR="/home/ciryon/Coding/PulsSolutions/services/devops-events-service" # should move elsewhere
export PATH="$HOME/Coding/PulsSolutions/scripts/bin:$PATH:~/bin"

case "$(uname -s)" in
Darwin)
  HOMEBREW_PREFIX="/opt/homebrew"
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
  ;;
esac

# Direnv
eval "$(direnv hook bash)"
