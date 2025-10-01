if [[ "$(uname -s)" == "Linux" ]] && [[ -r ~/.local/share/omarchy/default/bash/rc ]]; then
  source ~/.local/share/omarchy/default/bash/rc
fi

set -h

# Exports
export DEVOPS_EVENTS_DIR="/home/ciryon/Coding/PulsSolutions/services/devops-events-service" # should move elsewhere
export PATH="$HOME/Coding/PulsSolutions/scripts/bin:$PATH"

case "$(uname -s)" in
Darwin)
  HOMEBREW_PREFIX="/opt/homebrew"
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
  ;;
esac

# Direnv
eval "$(direnv hook bash)"

# atuin history
eval "$(atuin init bash --disable-up-arrow)"
