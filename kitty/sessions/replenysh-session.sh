#!/bin/zsh

kitty @ set-tab-title last

kitty @ new-window \
  --new-tab \
  --tab-title server \
  --cwd ~/dev/src/github.com/replenysh/replenysh-backend
kitty @ goto-layout -m title:server stack
kitty @ new-window \
  --cwd ~/dev/src/github.com/replenysh/replenysh-backend

kitty @ new-window \
  --new-tab \
  --tab-title web \
  --cwd ~/dev/src/github.com/replenysh/replenysh-frontend
kitty @ goto-layout -m title:web stack
kitty @ new-window \
  --cwd ~/dev/src/github.com/replenysh/replenysh-frontend

kitty @ new-window \
  --new-tab \
  --tab-title mobile \
  --cwd ~/dev/src/github.com/replenysh/replenysh-hauler-mobile
kitty @ goto-layout -m title:mobile stack
kitty @ new-window \
  --cwd ~/dev/src/github.com/replenysh/replenysh-hauler-mobile

kitty @ close-tab -m title:last
