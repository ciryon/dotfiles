# Aliases
alias pu="cd ~/Coding/PulsSolutions"
alias s="code .; yarn run dev"
alias vim=nvim
alias pino-pretty='pino-pretty -i hostname,pid -S -t "SYS:yyyy-mm-dd HH:MM:ss"' # hide hostname,pid + single line + timestamp
alias lg=lazygit
command -v rg >/dev/null && alias ag=rg
alias logs=puls_aws_logs
command -v qalc >/dev/null && alias calc=qalc # awesome calculator

cat() {
  if [[ $# -eq 0 ]]; then
    command bat --paging=never --style=plain --theme=gruvbox-dark 2>/dev/null
    return
  fi

  for f in "$@"; do
    if [[ -f "$f" ]] && file --mime-type -b "$f" | grep -q '^image/'; then
      kitten icat "$f"
    else
      command bat --paging=never --style=plain --theme=gruvbox-dark 2>/dev/null "$f"
    fi
  done
}


say() {
  local text="$*"

  curl -sS \
    -X POST "https://api.elevenlabs.io/v1/text-to-speech/$ELEVENLABS_VOICE_ID?output_format=mp3_44100_128" \
    -H "xi-api-key: $ELEVENLABS_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$(jq -n \
      --arg text "$text" \
      '{text: $text, model_id: "eleven_flash_v2_5"}')" \
    | mpv --no-video --really-quiet -
}

PULS_ROOT="$HOME/Coding/PulsSolutions"
claude() {
  if [[ "$PWD" == "$PULS_ROOT" || "$PWD" == "$PULS_ROOT"/* ]]; then
    AWS_PROFILE=puls-agent command claude "$@"
  else
    command claude "$@"
  fi
}



alias hurrah="echo \"Hurrah!\""
