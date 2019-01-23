#!/bin/zsh

kitty @ set-tab-title last

kitty @ new-window \
  --new-tab \
  --tab-title server \
  --cwd ~/dev/github.com/replenysh/replenysh-backend
kitty @ goto-layout -m title:server stack
kitty @ new-window \
  --cwd ~/dev/github.com/replenysh/replenysh-backend

kitty @ new-window \
  --new-tab \
  --tab-title web \
  --cwd ~/dev/github.com/replenysh/replenysh-webapp
kitty @ goto-layout -m title:web stack
kitty @ new-window \
  --cwd ~/dev/github.com/replenysh/replenysh-webapp

kitty @ new-window \
  --new-tab \
  --tab-title mobile \
  --cwd ~/dev/github.com/replenysh/replenysh-captain-app
kitty @ goto-layout -m title:mobile stack
kitty @ new-window \
  --cwd ~/dev/github.com/replenysh/replenysh-captain-app

kitty @ close-tab -m title:last
