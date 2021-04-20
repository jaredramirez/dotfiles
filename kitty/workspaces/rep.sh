kitty @ set-window-title redirect

kitty @ launch \
    --type tab \
    --title "root/" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core

kitty @ focus-tab -m title:root

kitty @ close-window -m title:redirect
