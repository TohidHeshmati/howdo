# lib/completion.zsh

_howdo() {
    local -a categories
    # 1. Dynamically list filenames from project's files/ directory
    # We use HOWDO_FILES which is exported in bin/howdo.zsh
    if [[ -d "$HOWDO_FILES" ]]; then
        categories=($(ls "$HOWDO_FILES" | sed 's/\.txt//'))
    fi

    # 2. Tell Zsh to use this list for completions
    _arguments "1: :(${categories[*]})"
}

# Register the completion for the 'howdo' command
compdef _howdo howdo