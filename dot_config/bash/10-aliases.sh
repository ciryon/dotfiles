# Aliases
alias pu="cd ~/Coding/PulsSolutions"
alias s="code .; yarn run dev"
alias vim=nvim
alias pino-pretty='pino-pretty -i hostname,pid -S -t "SYS:yyyy-mm-dd HH:MM:ss"' # hide hostname,pid + single line + timestamp
alias lg=lazygit
alias logs=puls_aws_logs
alias js='cd ~/Coding/JavaScript'
alias is='cd ~/Coding/Istari'
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

alias hurrah="echo \"Hurrah!\""
