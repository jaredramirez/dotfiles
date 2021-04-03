kitty @ set-tab-title redirect

kitty @ launch \
    --type tab \
    --title "dotfiles/1" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/jaredramirez/dotfiles

kitty @ launch \
    --type tab \
    --title "dotfiles/2" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/jaredramirez/dotfiles

kitty @ close-tab --match=title:redirect
