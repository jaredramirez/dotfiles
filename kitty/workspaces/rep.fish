#!/usr/local/bin/fish

kitty @ set-tab-title last

kitty @ launch \
    --type tab \
    --tab-title web \
    --cwd ~/dev/github/replenysh/core/dashboard
kitty @ launch \
    --type window \
    --cwd ~/dev/github/replenysh/core/dashboard
kitty @ goto-layout -m title:web stack

kitty @ launch \
    --type tab \
    --tab-title portal \
    --cwd ~/dev/github/replenysh/core/portal
kitty @ launch \
    --type window \
    --cwd ~/dev/github/replenysh/core/portal
kitty @ goto-layout -m title:portal stack

kitty @ launch \
    --type tab \
    --tab-title tools \
    --cwd ~/dev/github/replenysh/core/tools
kitty @ launch \
    --type window \
    --cwd ~/dev/github/replenysh/core/tools
kitty @ goto-layout -m title:tools stack

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
    --cwd ~/dev/github/replenysh/core/mobile
kitty @ launch \
    --type window \
    --cwd ~/dev/github/replenysh/core/mobile
kitty @ goto-layout -m title:mobile stack

kitty @ new-window \
    --new-tab \
    --tab-title mobile-two \
    --cwd ~/dev/github/replenysh/core/mobile

kitty @ close-tab -m title:last
