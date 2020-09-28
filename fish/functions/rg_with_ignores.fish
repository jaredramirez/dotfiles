function rg_with_ignores
    set -l filter "*.jpg" "*.bmp" "*.png" "*.jar" "*.7z" "*.bz" "*.zip" "*.tar" "*.gz" "*.tgz"
    set -l filter ".git" ".direnv"
    if [ -f "bsconfig.json" ]
        set filter $filter "lib" "*.bs.js"
    end
    if [ -f "metro.config.js" ] || [ -f "react-native.config.js" ]
        set filter $filter "build" "Pods"
    end
    if [ -f "Cargo.toml" ]
        set filter $filter "target"
    end
    if [ -f "elm.json" ]
        set filter $filter "elm-stuff"
    end
    if [ -f "package.json" ]
        set filter $filter "node_modules" "*.min.js"
    end
    if [ -f "package.yaml" ] || [ -f "stack.yaml" ]
        set filter $filter ".stack-work"
    end
    rg --files --no-ignore-vcs --hidden -g (echo "!{"(string join "," $filter)"}")
end
