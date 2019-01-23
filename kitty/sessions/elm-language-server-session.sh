#!/bin/zsh

kitty @ set-tab-title last

kitty @ new-window \
  --new-tab \
  --tab-title elm-language-server \
  --cwd ~/dev/github.com/jaredramirez/elm-language-server
kitty @ goto-layout -m title:elm-language-server stack
kitty @ new-window \
  --cwd ~/dev/github.com/jaredramirez/elm-language-server

kitty @ new-window \
  --new-tab \
  --tab-title elm-field \
  --cwd ~/dev/github.com/jaredramirez/elm-field
kitty @ goto-layout -m title:elm-field stack
kitty @ new-window \
  --cwd ~/dev/github.com/jaredramirez/elm-field

kitty @ close-tab -m title:last
