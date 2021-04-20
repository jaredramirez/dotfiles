#! /usr/local/bin/fish

kitty @ set-window-title redirect

kitty @ launch \
    --type tab \
    --title "api/" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/api; fish -i"
kitty @ launch \
    --type tab \
    --title "api/run" \
    ssh jared@home -L 2000:localhost:2000 -t "cd ~/dev/github/replenysh/core/api; fish -i"
kitty @ launch \
    --type tab \
    --title "api/edit" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/api; fish -i"

kitty @ launch \
    --type tab \
    --title "dashboard/" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/dashboard; fish -i"
kitty @ launch \
    --type tab \
    --title "dashboard/run" \
    ssh jared@home -L 2001:localhost:2001 -t "cd ~/dev/github/replenysh/core/dashboard; fish -i"
kitty @ launch \
    --type tab \
    --title "dashboard/edit" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/dashboard; fish -i"
    
kitty @ launch \
    --type tab \
    --title "portal/" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/portal; fish -i"
kitty @ launch \
    --type tab \
    --title "portal/run" \
    ssh jared@home -L 2002:localhost:2002 -t "cd ~/dev/github/replenysh/core/portal; fish -i"
kitty @ launch \
    --type tab \
    --title "portal/edit" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/portal; fish -i"
    
kitty @ launch \
    --type tab \
    --title "join/" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/join; fish -i"
kitty @ launch \
    --type tab \
    --title "join/run" \
    ssh jared@home -L 2003:localhost:2003 -t "cd ~/dev/github/replenysh/core/join; fish -i"
kitty @ launch \
    --type tab \
    --title "join/edit" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/join; fish -i"
    
kitty @ launch \
    --type tab \
    --title "mobile/" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/mobile; fish -i"
kitty @ launch \
    --type tab \
    --title "mobile/run" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/mobile; fish -i"
kitty @ launch \
    --type tab \
    --title "mobile/edit" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/mobile; fish -i"
kitty @ launch \
    --type tab \
    --title "mobile/serve" \
    ssh jared@home -L 19000:localhost:19000 -L 19001:localhost:19001 -L 19002:localhost:19002 -t "cd ~/dev/github/replenysh/core/mobile; fish -i"

kitty @ launch \
    --type tab \
    --title "root/" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core; fish -i"

kitty @ focus-tab -m title:root

kitty @ close-window -m title:redirect
