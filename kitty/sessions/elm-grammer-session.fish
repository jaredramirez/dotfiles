#!/usr/local/bin/fish

kitty @ set-tab-title last

kitty @ launch \
    --type tab \
    --tab-title one \
    --cwd ~/dev/github.com/jaredramirez/elm-grammar
kitty @ launch \
    --type window \
    --cwd ~/dev/github.com/jaredramirez/elm-grammar
kitty @ goto-layout -m title:one stack

kitty @ launch \
    --type tab \
    --tab-title two \
    --cwd ~/dev/github.com/jaredramirez/elm-grammar
kitty @ launch \
    --type window \
    --cwd ~/dev/github.com/jaredramirez/elm-grammar
kitty @ goto-layout -m title:two stack

kitty @ close-tab -m title:last
