

winpath() {
    if [ ${#} -eq 0 ]; then
        : skip
    elif [ -f "$1" ]; then
        local dirname=$(dirname "$1")
        local basename=$(basename "$1")
        echo "$(cd "$dirname" && pwd -W)/$basename" \
        | sed \
          -e 's|/|\\|g';
    elif [ -d "$1" ]; then
        echo "$(cd "$1" && pwd -W)" \
        | sed \
          -e 's|/|\\|g';
    else
        echo "$1" \
        | sed \
          -e 's|^/\(.\)/|\1:\\|g' \
          -e 's|/|\\|g'
    fi
}

unixpath() {
    echo "$1" \
    | sed -r \
      -e 's/\\/\//g' \
      -e 's/^([^:]+):/\/\1/'
}
export -f winpath
export -f unixpath