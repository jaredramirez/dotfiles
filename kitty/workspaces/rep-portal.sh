kitty @ launch \
    --type tab \
    --title "portal/" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/portal
kitty @ launch \
    --type tab \
    --title "portal/run" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/portal
kitty @ launch \
    --type tab \
    --title "portal/edit" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/portal

kitty @ focus-tab -m title:portal/
