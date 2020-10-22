function kakf
    # Get file to open
    set -l file (rg_with_ignores | sk)

    # Make sure we have a file (didn't press ctrl-c)
    if set -q file && test -n "$file"
        # Append open file cmd into history
        echo "- cmd:" "kak $file" >>"$HOME/.local/share/fish/fish_history"
        echo "  when:" (date "+%s") >>"$HOME/.local/share/fish/fish_history"

        # Load history
        history --merge

        # Open file
        kak "$file"
    end
end
