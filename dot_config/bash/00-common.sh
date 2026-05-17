if [[ "$(uname -s)" == "Linux" ]] && [[ -r ~/.local/share/omarchy/default/bash/rc ]]; then
  source ~/.local/share/omarchy/default/bash/rc
fi

set -o vi

# Exports
export DEVOPS_EVENTS_DIR="/home/ciryon/Coding/PulsSolutions/services/devops-events-service" # should move elsewhere
export PATH="$HOME/Coding/PulsSolutions/scripts/bin:$PATH:$HOME/bin:$HOME/.local/bin"

case "$(uname -s)" in
Darwin)
  HOMEBREW_PREFIX="/opt/homebrew"
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
  # Mise
  eval "$(~/.local/bin/mise activate bash)"
  ;;
esac

case "$(uname -s)" in
Linux)
  export CAPACITOR_ANDROID_STUDIO_PATH="/usr/bin/android-studio"
  # Mise
  if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate bash)"
  fi
  ;;
esac

export CLOUDFLARED_USERNAME=christian

# Direnv
# eval "$(direnv hook bash)"
