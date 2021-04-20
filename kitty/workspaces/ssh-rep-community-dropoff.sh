kitty @ launch \
    --type tab \
    --title "community-dropoff/" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/community-dropoff; fish -i"
kitty @ launch \
    --type tab \
    --title "community-dropoff/run" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/community-dropoff; fish -i"
kitty @ launch \
    --type tab \
    --title "community-dropoff/edit" \
    ssh jared@home -t "cd ~/dev/github/replenysh/core/community-dropoff; fish -i"
kitty @ launch \
    --type tab \
    --title "community-dropoff/serve" \
    ssh jared@home -L 19000:localhost:19000 -L 19001:localhost:19001 -L 19002:localhost:19002 -t "cd ~/dev/github/replenysh/core/community-dropoff; fish -i"
