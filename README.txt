Ghostty + SSH + tmux terminfo

If tmux on a newly set up SSH target says:

  missing or unsuitable terminal: xterm-ghostty

the server is missing Ghostty's terminfo entry. Install it from a machine where
Ghostty works:

  infocmp -x xterm-ghostty | ssh <host> 'mkdir -p ~/.terminfo && tic -x -o ~/.terminfo -'

Then SSH to the host again and start tmux normally.
