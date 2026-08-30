# Puls Solutions. Opt-in: does nothing unless the checkout is present, so this
# file is inert on the servers and the Mac. These paths and the awsnpm helper
# used to be unconditional in 00-common.sh and 20-node.sh, which put
# non-existent directories on PATH on every machine.
PULS_ROOT="$HOME/Coding/PulsSolutions"
[[ -d "$PULS_ROOT" ]] || return 0

export PULS_AI_TOOLS_DIR="$PULS_ROOT/puls-ai-tools"
export DEVOPS_EVENTS_DIR="$PULS_ROOT/services/devops-events-service"
export PATH="$PULS_ROOT/scripts/bin:$PULS_AI_TOOLS_DIR/agent-personas/bin:$PATH:$PULS_AI_TOOLS_DIR/tools"

alias pu="cd $PULS_ROOT"
command -v puls_aws_logs >/dev/null && alias logs=puls_aws_logs

# Use the agent AWS profile for anything run inside the PulsSolutions tree.
claude() {
  if [[ "$PWD" == "$PULS_ROOT" || "$PWD" == "$PULS_ROOT"/* ]]; then
    AWS_PROFILE=puls-agent command claude "$@"
  else
    command claude "$@"
  fi
}

# AWS CodeArtifact npm login
awsnpm() {
  local domain=puls-solutions owner=881074146182 repo=node-modules region=eu-west-1
  local host="$domain-$owner.d.codeartifact.$region.amazonaws.com"

  aws codeartifact login --tool npm --domain "$domain" --domain-owner "$owner" \
    --repository "$repo" --region "$region"

  npm config set @puls-solutions:registry "https://$host/npm/$repo/"

  export CODEARTIFACT_AUTH_TOKEN=$(
    aws codeartifact get-authorization-token --domain "$domain" \
      --domain-owner "$owner" --region "$region" --query authorizationToken --output text
  )
  npm config set "//$host/npm/$repo/:_authToken" "$CODEARTIFACT_AUTH_TOKEN"

  npm config set registry "https://registry.npmjs.org/"
}
