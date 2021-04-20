kitty @ launch \
    --type tab \
    --title "api/" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/api
kitty @ launch \
    --type tab \
    --title "api/run" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/api
kitty @ launch \
    --type tab \
    --title "api/edit" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/api

kitty @ focus-tab -m title:api/
