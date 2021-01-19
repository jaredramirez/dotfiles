#!/usr/local/bin/fish

kitty @ set-tab-title last

kitty @ launch \
    --type tab \
    --window-title "web [port forward]" \
    ssh jared@home -L 5000:localhost:5000 -t "cd ~/dev/github/replenysh/core/webapp; fish -i"
kitty @ launch \
    --type window \
    --window-title web \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/webapp; fish -i"
kitty @ goto-layout -m title:web stack

kitty @ launch \
    --type tab \
    --window-title "api [port forward]" \
    ssh jared@home -L 4000:localhost:4000 -t "cd ~/dev/github/replenysh/core/api; fish -i"
kitty @ launch \
    --type window \
    --window-title api \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/api; fish -i"
kitty @ goto-layout -m title:api stack

kitty @ launch \
    --type tab \
    --window-title mobile \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/mobileapp; fish -i"
kitty @ launch \
    --type window \
    --window-title mobile \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/mobileapp; fish -i"
kitty @ goto-layout -m title:mobile stack

kitty @ launch \
    --type tab \
    --window-title "mobile [port forward]" \
    ssh jared@home -L 19000:localhost:19000 -L 19002:localhost:19002 -t "cd ~/dev/github/replenysh/core/mobileapp; fish -i"

kitty @ close-tab -m title:last
