# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


include () {
    [[ -f "$1" ]] && source "$1"
}


export ZSH_CUSTOM="/Users/ciryon/.dotfiles/oh-my-zsh-custom"
export ZSH="/Users/ciryon/.oh-my-zsh"
# ZSH_THEME="agnoster" # fancy
# ZSH_THEME="amuse" # fancy
# ZSH_THEME="fox" # previous one
ZSH_THEME="powerlevel10k/powerlevel10k"

COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="yyyy-mm-dd"

plugins=(
  git
  dotenv
  aws
  nvm
  #rvm
  brew
  #zsh-autosuggestions
  )

# Plugin settings
ZSH_DOTENV_FILE=.envrc
ZSH_DOTENV_PROMPT=false
SHOW_AWS_PROMPT=true

include $ZSH/oh-my-zsh.sh

# User configuration

setopt noautomenu
setopt nomenucomplete


# export MANPATH="/usr/local/man:$MANPATH"
export AWS_CONFIG_FILE=~/.aws/config

export AWS_PAGER=""
# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"

# Dont use universal history
unsetopt inc_append_history
unsetopt share_history

# Aliases
alias g='git'
alias xc='cd ~/Coding/XCode'
alias an='cd ~/Coding/Android'
alias ra='cd ~/Coding/Ruby_on_Rails'
alias ja='cd ~/Coding/Java'
alias js='cd ~/Coding/JavaScript'
alias ru='cd ~/Coding/Ruby'
alias is='cd ~/Coding/Istari && asp istari && echo Istari'
alias t='tmux'
alias yesterday='~/Coding/misc_scripts/yesterday.rb'
alias grep='grep --color=auto'
#alias serve='python3 -m http.server'
alias r='rails'
alias subs='echo "Recursively updating Git submodules..."; git submodule update --init --recursive'
alias pico=vim
alias chrome-insecure='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --allow-running-insecure-content  --disable-web-security'
alias aws-profile="asp"
alias aws="aws-wrapper"
alias chrome="open -a \"Google Chrome\""
# alias atom="echo 'You did mean code right?'; code"
# alias code="echo 'You did vim code right? Otherwise run /usr/local/bin/code'; vim"
alias prod="node ./scripts/deploy_site.js www puls-solutions.com appen sv dryRun; echo 'config is for prod now' "
#alias logs='echo "Tailing ${PWD##*/}-${ENVIRONMENT}"; aws logs tail --format short --follow  "/aws/lambda/${PWD##*/}-${ENVIRONMENT}"'
# instead get logs from shell script
alias lg=lazygit
alias vim=nvim
alias s="code .; yarn run dev"
# alias s='iterm "cd $PWD; vim ."; yarn run dev'
alias top=htop # custom top variant https://htop.dev/
alias man=tldr # custom man pages 
alias pino-pretty='pino-pretty -i hostname,pid -S -t "SYS:yyyy-mm-dd HH:MM:ss"' # hide hostname,pid + single line + timestamp 
alias logs=puls_aws_logs
alias serve='npx serve'
alias grepo='open "https://github.com/$(git config --get remote.origin.url \
| sed -E "s#.*github.com[:/]##;s/\.git$//")"'
# Pager with nice colors
export PAGER="most"


# Secrets file (not to be version controlled)
SECRETS=~/.secrets && test -f $SECRETS && source $SECRETS

# export NVM_DIR="~/.nvm"
# source ~/.nvm/nvm.sh

include ~/.rvm/scripts/rvm


export XDG_CONFIG_HOME="$HOME/.config"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=/usr/local/bin:/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:$RUBY_GEM_BIN:~/bin:$HOME/Coding/misc_scripts:$HOME/Coding/Istari/AWS/scripts:$HOME/dev/flutter/.pub-cache/bin:$HOME/dev/flutter/bin:$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:/opt/metasploit-framework/bin:$HOME/Coding/PulsSolutions/scripts/bin

if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

# Android
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export CHROME_EXECUTABLE="/Applications/Arc.app/Contents/MacOS/Arc"


if [[ -n $AWS_EXECUTION_ENV ]]; then
  # AWS CloudConsole
  alias pu='cd ~/Coding/PulsSolutions && echo Puls'
else
  # Local environment
  alias pu='cd ~/Coding/PulsSolutions && asp puls-dev && echo Puls'
  alias cat='bat --paging=never --style "changes,rule,snip" --theme  "Monokai Extended"'
  # And a Fortune!
  # echo ""
  # tput setaf 1; fortune -s aynrand
  # echo ""
  # echo ""
fi

include ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# bun completions
[ -s "/Users/ciryon/.bun/_bun" ] && source "/Users/ciryon/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# check for .nvmrc when cd:ing
cd() {
  builtin cd "$@"
  if [ -f ".nvmrc" ]; then
     nvm use
  fi
}
