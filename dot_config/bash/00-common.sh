if [[ "$(uname -s)" == "Linux" ]] && [[ -r ~/.local/share/omarchy/default/bash/rc ]]; then
  source ~/.local/share/omarchy/default/bash/rc
fi

set -o vi

# Exports
export DEVOPS_EVENTS_DIR="/home/ciryon/Coding/PulsSolutions/services/devops-events-service" # should move elsewhere
export PULS_AI_TOOLS_DIR="$HOME/Coding/PulsSolutions/puls-ai-tools"
export PATH="$HOME/Coding/PulsSolutions/scripts/bin:$PULS_AI_TOOLS_DIR/agent-personas/bin:$PATH:$HOME/bin:$HOME/.local/bin:$PULS_AI_TOOLS_DIR/tools"

case "$(uname -s)" in
Darwin)
  HOMEBREW_PREFIX="/opt/homebrew"
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
  ;;
esac

case "$(uname -s)" in
Linux)
  export CAPACITOR_ANDROID_STUDIO_PATH="/usr/bin/android-studio"
  ;;
esac

export CLOUDFLARED_USERNAME=christian

# Direnv
# eval "$(direnv hook bash)"
