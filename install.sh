#!/bin/bash

# Define colors for feedback
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Installing howdo...${NC}"

# 1. Check for dependencies
for cmd in fzf bat ggrep; do
    if ! command -v $cmd &> /dev/null && ! command -v grep &> /dev/null; then
        echo "⚠️  Warning: $cmd is not installed. Please install it for the best experience."
    fi
done

# 2. Handle Directory & Updates
# We want to install to ~/.howdo by default
TARGET_DIR="$HOME/.howdo"

if [ -d "$TARGET_DIR" ]; then
    echo -e "${BLUE}🔄 Found existing installation at $TARGET_DIR. Pulling latest changes...${NC}"
    cd "$TARGET_DIR" && git pull
else
    # If the user is ALREADY inside the howdo folder they just cloned,
    # we move it to the home directory to stay organized.
    if [[ "$(basename $(pwd))" == "howdo" ]]; then
        echo "📦 Moving current folder to $TARGET_DIR"
        cd .. && mv howdo "$TARGET_DIR"
    else
        echo "📥 Cloning howdo to $TARGET_DIR..."
        git clone https://github.com/TohidHeshmati/howdo.git "$TARGET_DIR"
    fi
fi

# 3. Create history file if it doesn't exist
touch "$HOME/.howdo_history"

# 4. Add to .zshrc if not already there
SOURCE_LINE="source $TARGET_DIR/bin/howdo.zsh"

if grep -q "howdo.zsh" "$HOME/.zshrc"; then
    echo -e "${GREEN}✅ howdo is already referenced in your .zshrc${NC}"
else
    echo -e "\n# howdo - Interactive Cheat Sheets\n$SOURCE_LINE" >> "$HOME/.zshrc"
    echo -e "${GREEN}✅ Added howdo to your .zshrc${NC}"
fi

echo -e "${BLUE}✨ Installation complete! Please run 'source ~/.zshrc' or restart your terminal.${NC}"