#!/usr/local/bin/fish

kitty @ set-tab-title last

kitty @ launch \
    --type tab \
    --tab-title root \
    --cwd ~/dev/github/rtfeldman/roc
kitty @ launch \
    --type window \
    --cwd ~/dev/github/rtfeldman/roc
kitty @ goto-layout -m title:root stack

kitty @ launch \
    --type tab \
    --tab-title bitcode \
    --cwd ~/dev/github/rtfeldman/roc/compiler/builtins/bitcode
kitty @ launch \
    --type window \
    --cwd ~/dev/github/rtfeldman/roc/compiler/builtins/bitcode
kitty @ goto-layout -m title:bitcode stack

kitty @ close-tab -m title:last
