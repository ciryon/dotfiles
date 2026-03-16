# Dotfiles (chezmoi)

## New machine

Install chezmoi and apply:

`sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ciryon`

## After changing configs

If you edited files in $HOME:

    chezmoi re-add
    chezmoi cd
    git add .
    git commit -m "update configs"
    git push

---

Pull changes on another machine

```
    chezmoi update
```
