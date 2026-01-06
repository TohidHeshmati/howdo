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

# 2. Get the current directory (where they cloned the repo)
INSTALL_PATH=$(pwd)
SOURCE_LINE="source $INSTALL_PATH/bin/howdo.zsh"

# 3. Create history file if it doesn't exist
touch "$HOME/.howdo_history"

# 4. Add to .zshrc if not already there
if grep -q "howdo.zsh" "$HOME/.zshrc"; then
    echo -e "${GREEN}✅ howdo is already in your .zshrc${NC}"
else
    echo -e "\n# howdo - Interactive Cheat Sheets\n$SOURCE_LINE" >> "$HOME/.zshrc"
    echo -e "${GREEN}✅ Added howdo to your .zshrc${NC}"
fi

echo -e "${BLUE}✨ Installation complete! Please run 'source ~/.zshrc' or restart your terminal.${NC}"