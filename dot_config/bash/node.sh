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

# NVM (Arch vs Homebrew)
if [[ -r /usr/share/nvm/init-nvm.sh ]]; then
  source /usr/share/nvm/init-nvm.sh
elif [[ -r /opt/homebrew/opt/nvm/nvm.sh ]]; then
  export NVM_DIR="$HOME/.nvm"
  source /opt/homebrew/opt/nvm/nvm.sh
fi
