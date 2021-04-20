#! /usr/local/bin/fish

kitty @ set-window-title redirect

kitty @ launch \
    --type tab \
    --title "dotfiles/1" \
    ssh jared@home -t "cd ~/dev/github/jaredramirez/dotfiles; fish -i"
kitty @ launch \
    --type tab \
    --title "dotfiles/2" \
    ssh jared@home -t "cd ~/dev/github/jaredramirez/dotfiles; fish -i"

kitty @ close-window -m title:redirect
