# carapace completions
export CARAPACE_EXCLUDES='node,npx'
source <(carapace _carapace)
#
# atuin history
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash --disable-up-arrow)"


# A fun pic
if command -v chafa >/dev/null 2>&1 && [[ -n "$DROPBOX_PERSONAL" ]] \
  && [[ -z "$SSH_CONNECTION" ]] && [[ "$TERM_PROGRAM" == "ghostty" ]]; then

  if [[ -z "$PS1_SHOWN" ]]; then
    export PS1_SHOWN=1
    chafa --format=kitty --scale=max --align=center \
      "$DROPBOX_PERSONAL/Images/telchar.png"
  fi

fi


echo "Remember: 'tdl c' for tmux work session with AI - and yazi for file manager!"
