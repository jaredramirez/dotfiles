function kf
    # Get file to open
    set -l file (rg --files --hidden | fzf --height 50% --layout=reverse -q "$argv[1]")

    # Make sure we have a file (didn't press ctrl-c)
    if set -q file && test -n "$file"
        # Append open file cmd into history
        echo "- cmd:" "k $file" >>"$HOME/.local/share/fish/fish_history"
        echo "  when:" (date "+%s") >>"$HOME/.local/share/fish/fish_history"

        # Load history
        history --merge

        # Open file
        k "$file"
    end
end 
