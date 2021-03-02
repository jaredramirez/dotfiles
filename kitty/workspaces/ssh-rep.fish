#!/usr/local/bin/fish

kitty @ set-tab-title last

kitty @ launch \
    --type tab \
    --window-title "dashboard [port forward]" \
    ssh jared@home -L 5000:localhost:5000 -t "cd ~/dev/github/replenysh/core/dashboard; fish -i"
kitty @ launch \
    --type window \
    --window-title dashboard \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/dashboard; fish -i"
kitty @ goto-layout -m title:dashboard stack

kitty @ launch \
    --type tab \
    --window-title "portal [port forward]" \
    ssh jared@home -L 5000:localhost:5000 -t "cd ~/dev/github/replenysh/core/portal; fish -i"
kitty @ launch \
    --type window \
    --window-title portal \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/portal; fish -i"
kitty @ goto-layout -m title:portal stack

kitty @ launch \
    --type tab \
    --window-title "tools [port forward]" \
    ssh jared@home -L 9000:localhost:9000 -t "cd ~/dev/github/replenysh/core/tools; fish -i"
kitty @ launch \
    --type window \
    --window-title tools \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/tools; fish -i"
kitty @ goto-layout -m title:tools stack

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
    ssh jared@home -t "cd ~/dev/github/replenysh/core/mobile; fish -i"
kitty @ launch \
    --type window \
    --window-title mobile \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/mobile; fish -i"
kitty @ goto-layout -m title:mobile stack

kitty @ launch \
    --type tab \
    --window-title "mobile [port forward]" \
    ssh jared@home -L 19000:localhost:19000 -L 19001:localhost:19001 -L 19002:localhost:19002 -t "cd ~/dev/github/replenysh/core/mobile; fish -i"

kitty @ close-tab -m title:last
