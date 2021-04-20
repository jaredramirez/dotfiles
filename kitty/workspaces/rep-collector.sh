kitty @ launch \
    --type tab \
    --title "collector/" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/collector
kitty @ launch \
    --type tab \
    --title "collector/run" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/collector
kitty @ launch \
    --type tab \
    --title "collector/edit" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/collector
kitty @ launch \
    --type tab \
    --title "collector/serve" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/collector

kitty @ focus-tab -m title:collector/
