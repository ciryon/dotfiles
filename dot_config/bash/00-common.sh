# Core environment. Nothing machine- or employer-specific belongs here.

# Omarchy (Arch boxes: telchar) provides ll/la/ls, a prompt and much else —
# which is exactly why the plain Ubuntu hosts had none of it. 41-linux.sh
# fills that gap and defers to Omarchy when this flag is set.
export DOTFILES_OMARCHY=0
if [[ "$(uname -s)" == "Linux" ]] && [[ -r ~/.local/share/omarchy/default/bash/rc ]]; then
  source ~/.local/share/omarchy/default/bash/rc
  export DOTFILES_OMARCHY=1
fi

set -o vi

export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

case "$(uname -s)" in
Darwin)
  for p in /opt/homebrew /usr/local; do
    [[ -d "$p/bin" ]] && export PATH="$p/bin:$p/sbin:$PATH"
  done
  ;;
Linux)
  [[ -x /usr/bin/android-studio ]] && export CAPACITOR_ANDROID_STUDIO_PATH="/usr/bin/android-studio"
  ;;
esac

export CLOUDFLARED_USERNAME=christian

# uv / cargo shim, if installed
[[ -r "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
