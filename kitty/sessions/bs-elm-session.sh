#!/bin/zsh

kitty @ set-tab-title last

kitty @ new-window \
  --new-tab \
  --tab-title bs-elm \
  --cwd ~/dev/src/github.com/jaredramirez/bs-elm
kitty @ goto-layout -m title:bs-elm stack
kitty @ new-window \
  --cwd ~/dev/src/github.com/jaredramirez/bs-elm

kitty @ new-window \
  --new-tab \
  --tab-title bs-elm-example \
  --cwd ~/dev/src/github.com/jaredramirez/bs-elm-example
kitty @ goto-layout -m title:bs-elm-example stack
kitty @ new-window \
  --cwd ~/dev/src/github.com/jaredramirez/bs-elm-example

kitty @ close-tab -m title:last
