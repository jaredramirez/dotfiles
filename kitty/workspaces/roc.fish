#!/usr/local/bin/fish

kitty @ set-tab-title last

kitty @ launch \
    --type tab \
    --tab-title roc \
    --cwd ~/dev/github/rtfeldman/roc
kitty @ launch \
    --type window \
    --cwd ~/dev/github/rtfeldman/roc
kitty @ goto-layout -m title:roc stack

kitty @ close-tab -m title:last
