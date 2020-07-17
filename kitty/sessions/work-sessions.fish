#!/usr/local/bin/fish

kitty @ set-tab-title last

kitty @ new-window \
    --new-tab \
    --tab-title web-app \
    --cwd ~/dev/github.com/replenysh/replenysh-web-app
kitty @ goto-layout -m title:web stack
kitty @ new-window --cwd ~/dev/github.com/replenysh/replenysh-web-app

kitty @ new-window \
    --new-tab \
    --tab-title server-one \
    --cwd ~/dev/github.com/replenysh/replenysh-backend
kitty @ goto-layout -m title:server-one stack
kitty @ new-window --cwd ~/dev/github.com/replenysh/replenysh-backend

kitty @ new-window \
    --new-tab \
    --tab-title server-two \
    --cwd ~/dev/github.com/replenysh/replenysh-backend
kitty @ goto-layout -m title:server-two stack
kitty @ new-window --cwd ~/dev/github.com/replenysh/replenysh-backend

kitty @ new-window \
    --new-tab \
    --tab-title mobile \
    --cwd ~/dev/github.com/replenysh/replenysh-mobile
kitty @ goto-layout -m title:mobile stack
kitty @ new-window --cwd ~/dev/github.com/replenysh/replenysh-mobile

kitty @ close-tab -m title:last
