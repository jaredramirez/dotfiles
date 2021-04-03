kitty @ set-window-title redirect

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

kitty @ launch \
    --type tab \
    --title "dashboard/" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/dashboard
kitty @ launch \
    --type tab \
    --title "dashboard/run" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/dashboard
kitty @ launch 
    --type tab \
    --title "dashboard/edit" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/dashboard
    
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
    
kitty @ launch \
    --type tab \
    --title "mobile/" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/mobile
kitty @ launch \
    --type tab \
    --title "mobile/run" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/mobile
kitty @ launch \
    --type tab \
    --title "mobile/edit" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/mobile
kitty @ launch \
    --type tab \
    --title "mobile/serve" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core/mobile

kitty @ launch \
    --type tab \
    --title "root/" \
    --env KITTY_TAB=1 \
    --cwd ~/dev/github/replenysh/core

kitty @ focus-tab -m title:root

kitty @ close-window -m title:redirect    
