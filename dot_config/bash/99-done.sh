# carapace completions
if command -v carapace >/dev/null 2>&1; then
  export CARAPACE_EXCLUDES='node,npx'
  source <(carapace _carapace)
fi

# atuin history
[[ -r ~/.atuin/bin/env ]] && source ~/.atuin/bin/env
if command -v atuin >/dev/null 2>&1; then
  [[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
  eval "$(atuin init bash --disable-up-arrow)"
fi


# A fun pic (only on host telchar)
if [[ "$(hostname)" == "telchar" ]] && [[ -z "$PS1_SHOWN" ]]; then
  PS1_SHOWN=1

  if command -v chafa >/dev/null 2>&1 && [[ -n "$DROPBOX_PERSONAL" ]] \
    && [[ -z "$SSH_CONNECTION" ]] && [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    chafa --format=kitty --scale=max --align=center \
      "$DROPBOX_PERSONAL/Images/telchar.png"
  else
    cat << 'EOF'
 _______ ______ _      _____ _    _          _____  
|__   __|  ____| |    / ____| |  | |   /\   |  __ \ 
   | |  | |__  | |   | |    | |__| |  /  \  | |__) |
   | |  |  __| | |   | |    |  __  | / /\ \ |  _  / 
   | |  | |____| |___| |____| |  | |/ ____ \| | \ \ 
   |_|  |______|______\_____|_|  |_/_/    \_\_|  \_\

EOF
  fi

fi


echo "Remember: 'herdr' for tmux work session with AI, ctrl-o to jump to dir, gh dash - and yazi for file manager!"
