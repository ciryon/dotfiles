# NPM

awsnpm() {
  local domain=puls-solutions
  local owner=881074146182
  local repo=node-modules
  local region=eu-west-1
  local host="$domain-$owner.d.codeartifact.$region.amazonaws.com"

  aws codeartifact login \
    --tool npm --domain "$domain" --domain-owner "$owner" \
    --repository "$repo" --region "$region"

  npm config set @puls-solutions:registry "https://$host/npm/$repo/"

  export CODEARTIFACT_AUTH_TOKEN=$(
    aws codeartifact get-authorization-token \
      --domain "$domain" --domain-owner "$owner" --region "$region" \
      --query authorizationToken --output text
  )
  npm config set "//$host/npm/$repo/:_authToken" "$CODEARTIFACT_AUTH_TOKEN"

  npm config set registry "https://registry.npmjs.org/"
}

# NVM (Arch and Homebrew)

# Linux (Arch)
if [[ -r /usr/share/nvm/init-nvm.sh ]]; then
  source /usr/share/nvm/init-nvm.sh

# macOS (Homebrew)
elif [[ -r /opt/homebrew/opt/nvm/nvm.sh ]]; then
  export NVM_DIR="$HOME/.nvm"
  source /opt/homebrew/opt/nvm/nvm.sh
  [[ -s /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm ]] &&
    source /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm
fi

# Bash completion if present
[[ -s /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm ]] && source /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm
[[ -s /usr/local/opt/nvm/etc/bash_completion.d/nvm ]] && source /usr/local/opt/nvm/etc/bash_completion.d/nvm

# Auto-use Node version from nearest .nvmrc (on cd and on new shells)
nvm_auto_use() {
  # nvm provides nvm_find_nvmrc; fall back to local .nvmrc
  local nvmrc
  nvmrc="$(command -v nvm_find_nvmrc >/dev/null 2>&1 && nvm_find_nvmrc || true)"
  [[ -z "$nvmrc" && -f .nvmrc ]] && nvmrc="$PWD/.nvmrc"
  [[ -z "$nvmrc" ]] && return 0

  local required current
  required="$(nvm version "$(cat "$nvmrc")")"
  current="$(nvm version)"
  [[ "$required" = "N/A" ]] && {
    nvm install >/dev/null
    return 0
  }
  [[ "$required" != "$current" ]] && nvm use >/dev/null
}
# run on each prompt (covers new shells + after cd)
PROMPT_COMMAND="nvm_auto_use${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
