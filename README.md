# Dotfiles managed with chezmoi

## Overview

These are my personal dotfiles, managed using [chezmoi](https://www.chezmoi.io).  
Omarchy Linux (Hyprland) is the **source of truth**, and changes are synced to macOS.

Everything lives in `~/.local/share/chezmoi`, but chezmoi transparently manages `$HOME`.

---

## Quick start (new machine)

```sh
# Install chezmoi
brew install chezmoi              # macOS
sudo pacman -S chezmoi            # Arch/Omarchy

# Initialize from repo
chezmoi init ciryon --branch master

# Review changes before applying
chezmoi diff
chezmoi apply
```

---

## Workflow

### Editing on Linux (preferred source of truth)

1. Edit a dotfile in `$HOME` **or** with `chezmoi edit <path>`.
2. If you edited in `$HOME`, bring it into chezmoi:
   ```sh
   chezmoi add ~/.config/bash/aliases.sh
   ```
3. Commit & push:
   ```sh
   chezmoi git add -A
   chezmoi git commit -m "update: aliases"
   chezmoi git push
   ```

### Updating on Mac

```sh
chezmoi update    # does git pull + apply
source ~/.zshrc   # reload aliases/env if needed
```

### Updating on Linux (after changes elsewhere)

```sh
chezmoi update
```

---

## OS specifics

- **Linux-only configs** (Hyprland, Waybar, Rofi, Mako, Walker, etc.) live under `.config/` and should be wrapped with:
  ```tmpl
  {{ if eq .chezmoi.os "linux" }}
  # linux-specific config
  {{ end }}
  ```
- **macOS-only apps** (Raycast, iTerm2, etc.) are ignored via `.chezmoiignore`.

---

## Directory layout

- `dot_bashrc`, `dot_bash_profile`: thin shims → load from `~/.config/bash/*.sh`
- `dot_config/bash/`: modular bash configs
  - `common.sh` (env, exports)
  - `aliases.sh` (aliases)
  - `node.sh` (npm / nvm / AWS CodeArtifact helpers)
  - `secrets.sh` (sources `~/.secrets` if present, not in git)
- `dot_config/nvim/`: Neovim config (Lua)
- `dot_config/git/`, `dot_gitconfig`: Git config
- `dot_config/hypr/`, `dot_config/waybar/`: Hyprland setup (Linux only)
- `dot_config/kitty/` (or `ghostty/` or `alacritty/`): terminal config

---

## Secrets

Secrets are **never** in the repo.

- `~/.config/bash/secrets.sh` sources `~/.secrets` if present.
- `.chezmoiignore` excludes `.secrets`, SSH keys, GnuPG, and app credentials.

```sh
# Example in secrets.sh
[[ -r "$HOME/.secrets" ]] && source "$HOME/.secrets"
```

---

## Handy commands

- Show what’s managed:
  ```sh
  chezmoi managed
  ```
- Show what would change:
  ```sh
  chezmoi diff
  ```
- Verify everything matches:
  ```sh
  chezmoi verify
  ```
- Apply only one file:
  ```sh
  chezmoi apply ~/.config/bash/aliases.sh
  ```
- Open the source repo:
  ```sh
  chezmoi cd
  ```

---

## 🔄 Sync instructions

### From Linux → to Mac

```sh
# On Linux
chezmoi add <path>         # if edited directly in $HOME
chezmoi git add -A
chezmoi git commit -m "message"
chezmoi git push

# On Mac
chezmoi update
source ~/.zshrc            # reload shell if aliases/env changed
```

### From Mac → to Linux

_(less common, same idea)_

```sh
# On Mac
chezmoi add <path>
chezmoi git add -A
chezmoi git commit -m "message"
chezmoi git push

# On Linux
chezmoi update
```

---

## One-liner sync loop (for muscle memory)

```sh
# On editing machine
chezmoi add <file> && chezmoi git add -A && chezmoi git commit -m "msg" && chezmoi git push

# On receiving machine
chezmoi update
```
