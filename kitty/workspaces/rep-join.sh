kitty @ launch \
    --type tab \
    --title "join/" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/join
kitty @ launch \
    --type tab \
    --title "join/run" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/join
kitty @ launch \
    --type tab \
    --title "join/edit" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/join

kitty @ focus-tab -m title:join/
