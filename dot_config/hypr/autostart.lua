-- Extra autostart processes.

-- Clipboard history: pipe every text selection into clipvault.
o.exec_on_start("wl-paste -t text --watch clipvault store")

-- Turn the office Hue lights on at login. Delayed so the network is up, and
-- run through a login shell so openhue finds its config and credentials.
o.exec_on_start(
  [[bash -lc 'sleep 4; PATH=/usr/bin:/usr/local/bin XDG_CONFIG_HOME="$HOME/.config" ~/.local/bin/hue_office.sh on >>~/.local/share/openhue.log 2>&1']]
)
