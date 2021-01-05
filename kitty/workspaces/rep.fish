#!/usr/local/bin/fish

kitty @ set-tab-title last

kitty @ launch \
    --type tab \
    --tab-title web \
    --cwd ~/dev/github/replenysh/core/webapp
kitty @ launch \
    --type window \
    --cwd ~/dev/github/replenysh/core/webapp
kitty @ goto-layout -m title:web stack

kitty @ launch \
    --type tab \
    --tab-title server \
    --cwd ~/dev/github/replenysh/core/api
kitty @ launch \
    --type window \
    --cwd ~/dev/github/replenysh/core/api
kitty @ goto-layout -m title:server stack

kitty @ launch \
    --type tab \
    --tab-title mobile \
    --cwd ~/dev/github/replenysh/core/mobileapp
kitty @ launch \
    --type window \
    --cwd ~/dev/github/replenysh/core/mobileapp
kitty @ goto-layout -m title:mobile stack

kitty @ new-window \
    --new-tab \
    --tab-title mobile-two \
    --cwd ~/dev/github/replenysh/core/mobileapp

kitty @ close-tab -m title:last
