function nvf
    # Get file to open
    set -l file (rg_files | sk --preview "~/.config/nvim/bundle/fzf.vim/bin/preview.sh {}")

    # Make sure we have a file (didn't press ctrl-c)
    if set -q file && test -n "$file"
        # Append open file cmd into history
        echo "- cmd:" "nv $file" >>"$HOME/.local/share/fish/fish_history"
        echo "  when:" (date "+%s") >>"$HOME/.local/share/fish/fish_history"

        # Load history
        history --merge

        # Open file
        nv "$file"
    end
end
