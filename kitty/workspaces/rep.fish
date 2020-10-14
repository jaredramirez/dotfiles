#!/usr/local/bin/fish

kitty @ set-tab-title last

kitty @ launch \
    --type tab \
    --tab-title web \
    --cwd ~/dev/github/replenysh/replenysh-web-app
kitty @ launch \
    --type window \
    --cwd ~/dev/github/replenysh/replenysh-web-app
kitty @ goto-layout -m title:web stack

kitty @ launch \
    --type tab \
    --tab-title server-one \
    --cwd ~/dev/github/replenysh/replenysh-backend
kitty @ launch \
    --type window \
    --cwd ~/dev/github/replenysh/replenysh-backend
kitty @ goto-layout -m title:server-one stack

kitty @ launch \
    --type tab \
    --tab-title server-two \
    --cwd ~/dev/github/replenysh/replenysh-backend
kitty @ launch \
    --type window \
    --cwd ~/dev/github/replenysh/replenysh-backend
kitty @ goto-layout -m title:server-two stack

kitty @ launch \
    --type tab \
    --tab-title mobile \
    --cwd ~/dev/github/replenysh/replenysh-mobile
kitty @ launch \
    --type window \
    --cwd ~/dev/github/replenysh/replenysh-mobile
kitty @ goto-layout -m title:mobile stack

kitty @ new-window \
    --new-tab \
    --tab-title mobile-two \
    --cwd ~/dev/github/replenysh/replenysh-mobile

kitty @ close-tab -m title:last
