#!/usr/local/bin/fish

kitty @ set-tab-title last

kitty @ launch \
    --type tab \
    --window-title main \
    ssh jared@home -t "cd ~/dev/github/rtfeldman/roc; fish -i"
kitty @ launch \
    --type window \
    --window-title main \
    ssh jared@home -t "cd ~/dev/github/rtfeldman/roc; fish -i"
kitty @ goto-layout -m title:main stack

kitty @ launch \
    --type tab \
    --window-title bitcode \
    ssh jared@home -t "cd ~/dev/github/rtfeldman/roc/compiler/builtins/bitcode; fish -i"
kitty @ launch \
    --type window \
    --window-title bitcode \
    ssh jared@home -t "cd ~/dev/github/rtfeldman/roc/compiler/builtins/bitcode; fish -i"
kitty @ goto-layout -m title:bitcode stack

kitty @ close-tab -m title:last
