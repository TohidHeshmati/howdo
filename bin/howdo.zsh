# howdo.zsh - Main functions for the howdo project

# Automatically find the project root relative to this script
export HOWDO_ROOT="$(cd "$(dirname "${(%):-%N}")/.." && pwd)"
export HOWDO_FILES="$HOWDO_ROOT/files"
export HOWDO_HIST="$HOME/.howdo_history"

# Handle Mac (ggrep) vs Linux (grep)
if command -v ggrep >/dev/null 2>&1; then
    _GREP="ggrep"
else
    _GREP="grep"
fi
[[ -f "$HOWDO_ROOT/lib/completion.zsh" ]] && source "$HOWDO_ROOT/lib/completion.zsh"

howdo() {
    local CHEAT_DIR="$HOWDO_FILES"
    local HIST_FILE="$HOWDO_HIST"
    touch "$HIST_FILE"

    # 1. Select the command
    # Changed grep to look in $HOWDO_FILES
    local selected=$(cd "$CHEAT_DIR" && grep -H ".*" *.txt | fzf --ansi \
        --header "🧠 [ENTER] Run | [CTRL-E] Edit | [CTRL-A] Add" \
        --delimiter ':' --with-nth '2..' \
        --layout=reverse --height=80% --border=rounded \
        --margin=1,2 --padding=1 --info=inline --prompt="⚡️ " \
        --preview "echo {} | cut -d: -f2- | sed 's/;;/\n\n💡 EXPLANATION:/' | sed 's/@/\n\n📝 TIPS:/' | sed 's/??/\n\n🎓 DEEP DIVE:/' | bat --style=grid --color=always -l bash" \
        --preview-window=right:55%:wrap \
        --bind "ctrl-e:execute(cd $CHEAT_DIR && nano \$(echo {} | cut -d: -f1))" \
        --bind "ctrl-a:execute-silent(read -p 'Add New Cheat: ' entry && howadd \"\$entry\")+reload(cd $CHEAT_DIR && grep -H '.*' *.txt)")

    if [ -n "$selected" ]; then
        local full_line=$(echo "$selected" | cut -d: -f2-)
        local raw_cmd=$(echo "$full_line" | sed 's/\[.*\] //' | cut -d';' -f1 | sed 's/#[^ ]*//g' | sed 's/[[:space:]]*$//')
        local explanation=$(echo "$full_line" | cut -d';' -f2-)

        # 2. Variable replacement loop
        while [[ "$raw_cmd" =~ "<([^>]+)>" ]]; do
            local var_name="${match[1]}"
            local tip=$(echo "$explanation" | ggrep -oP "(?<=@ $var_name: )[^#@]+" 2>/dev/null | sed 's/[[:space:]]*$//')
            local last_vals=$(grep "^$var_name=" "$HIST_FILE" | cut -d'=' -f2- | tail -n 15 | tac | awk '!seen[$0]++' | head -n 3 | tr '\n' ' ' | sed 's/ $//')
            local default_val=$(grep "^$var_name=" "$HIST_FILE" | tail -n 1 | cut -d'=' -f2-)

            echo -e "\n\033[1;34mTarget: <$var_name>\033[0m"
            [ -z "$last_vals" ] || echo -e "\033[1;30m🕒 Recent: $last_vals\033[0m"
            [ -z "$tip" ] || echo -e "\033[3;32mTip: $tip\033[0m"

            echo -n "Enter value${default_val:+ (default: $default_val)}: "
            read user_val
            user_val="${user_val:-$default_val}"

            if [ -n "$user_val" ]; then
                echo "$var_name=$user_val" >> "$HIST_FILE"
                raw_cmd="${raw_cmd//<$var_name>/$user_val}"
            fi
        done

        # 3. Safety Check
        if [[ "$raw_cmd" =~ "delete|rm|reset|push|prune" ]]; then
            echo -e "\n\033[1;33m⚠️  DANGER ZONE: Destructive action detected.\033[0m"
            echo -n "Append --dry-run? (y/n): "
            read -k 1 choice
            echo ""
            if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
                raw_cmd="$raw_cmd --dry-run"
                echo -e "\033[1;32m🛡️ Dry-run appended.\033[0m"
            fi
        fi

        print -z "$raw_cmd"
    fi
}

howadd() {
    local ENTRY="$*"
    local TAG=$(echo "$ENTRY" | grep -o '\[[^]]*\]' | head -1 | tr '[:lower:]' '[:upper:]')

    # Default file is now sys-admin.txt (replacing linux.txt)
    local FILE_PATH="$HOWDO_FILES/sys-admin.txt"

    case "$TAG" in
        "[GIT]"*)    FILE_PATH="$HOWDO_FILES/git.txt" ;;
        "[DOCKER]"*) FILE_PATH="$HOWDO_FILES/docker.txt" ;;
        "[K8S]"*)    FILE_PATH="$HOWDO_FILES/k8s.txt" ;;
        "[NET]"*)    FILE_PATH="$HOWDO_FILES/network.txt" ;;
        "[TEXT]"*)   FILE_PATH="$HOWDO_FILES/text-processing.txt" ;;
    esac

    echo "$ENTRY" >> "$FILE_PATH" && echo "✅ Added to $(basename $FILE_PATH)"
}

howdo_update() {
    echo "Checking for updates in $HOWDO_ROOT..."
    (cd "$HOWDO_ROOT" && git pull)
    source "$HOWDO_ROOT/bin/howdo.zsh"
    echo "✅ howdo updated and reloaded."
}