#!/usr/local/bin/fish

kitty @ set-tab-title last

kitty @ launch \
    --type tab \
    --window-title "webapp [port forward]" \
    ssh jared@home -L 5000:localhost:5000 -t "cd ~/dev/github/replenysh/core/webapp; fish -i"
kitty @ launch \
    --type window \
    --window-title webapp \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/webapp; fish -i"
kitty @ goto-layout -m title:webapp stack

kitty @ launch \
    --type tab \
    --window-title "api [port forward]" \
    ssh jared@home -L 4000:localhost:4000 -t "cd ~/dev/github/replenysh/core/api; fish -i"
kitty @ launch \
    --type window \
    --window-title api \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/api; fish -i"
kitty @ goto-layout -m title:api stack

kitty @ close-tab -m title:last
