# Shared aliases. OS-specific ls/ll/la live in 40-mac.sh / 41-linux.sh, and
# anything Puls-specific lives in 50-work.sh.
#
# Everything here is guarded: these files are applied to machines that do not
# have the tool installed, and an alias to a missing binary only fails later,
# at the confusing moment you use it.

alias grep='grep --color=auto'
command -v nvim >/dev/null && { alias vim=nvim; alias n=nvim; }
command -v lazygit >/dev/null && alias lg=lazygit
command -v rg      >/dev/null && alias ag=rg
command -v qalc    >/dev/null && alias calc=qalc # awesome calculator
command -v pino-pretty >/dev/null && \
  alias pino-pretty='pino-pretty -i hostname,pid -S -t "SYS:yyyy-mm-dd HH:MM:ss"' # hide hostname,pid + single line + timestamp
alias s="code .; yarn run dev"
alias hurrah="echo \"Hurrah!\""

# bat-backed cat, with inline images under kitty.
if command -v bat >/dev/null 2>&1; then
  cat() {
    if [[ $# -eq 0 ]]; then
      command bat --paging=never --style=plain --theme=gruvbox-dark
      return
    fi

    for f in "$@"; do
      if [[ -f "$f" ]] && command -v kitten >/dev/null 2>&1 \
        && file --mime-type -b "$f" | grep -q '^image/'; then
        kitten icat "$f"
      else
        command bat --paging=never --style=plain --theme=gruvbox-dark "$f"
      fi
    done
  }
fi

# Text-to-speech. Needs ELEVENLABS_VOICE_ID / ELEVENLABS_API_KEY from ~/.secrets.
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
