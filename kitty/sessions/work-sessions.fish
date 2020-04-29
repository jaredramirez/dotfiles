#!/usr/local/bin/fish

kitty @ set-tab-title last

kitty @ new-window \
    --new-tab \
    --tab-title web \
    --cwd ~/dev/github.com/replenysh/replenysh-webapp
kitty @ goto-layout -m title:web horizontal
kitty @ new-window --cwd ~/dev/github.com/replenysh/replenysh-webapp

kitty @ new-window \
    --new-tab \
    --tab-title server \
    --cwd ~/dev/github.com/replenysh/replenysh-backend
kitty @ goto-layout -m title:server horizontal
kitty @ new-window --cwd ~/dev/github.com/replenysh/replenysh-backend

kitty @ new-window \
    --new-tab \
    --tab-title server-two \
    --cwd ~/dev/github.com/replenysh/replenysh-backend
kitty @ goto-layout -m title:server-two stack
kitty @ new-window --cwd ~/dev/github.com/replenysh/replenysh-backend

kitty @ close-tab -m title:last
