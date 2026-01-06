<div align="center">

# 🧠 howdo
**The context-aware command runner for Zsh**

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/TohidHeshmati/howdo/blob/main/LICENSE)
[![Zsh](https://img.shields.io/badge/shell-zsh-orange.svg)](https://www.zsh.org/)

<p>howdo transforms flat cheat sheets into interactive tools with variable injection, history support, and safety guards.</p>

<img src="assets/howdo_demo.gif" width="750" alt="howdo demo" />

<p><i>Effortlessly run complex commands without leaving your terminal.</i></p>

</div>

---
---

---

## 📋 Prerequisites

`howdo` relies on a few external tools to provide its rich features.

### macOS

You can install the dependencies using [Homebrew](https://brew.sh/):

```bash
brew install fzf bat coreutils
```

*   `fzf`: For the interactive fuzzy search menu.
*   `bat`: For syntax highlighting in previews.
*   `coreutils`: Provides `ggrep`, which is required for some features.

### Linux

You can install the dependencies using your distribution's package manager. For example, on Debian/Ubuntu:

```bash
sudo apt-get update
sudo apt-get install fzf bat ripgrep
```

*   `fzf`: For the interactive fuzzy search menu.
*   `bat`: For syntax highlighting in previews.
*   `ripgrep`: Provides `rg`, which is used for searching.

## 📦 Installation

The installation is handled by a single script. It automatically clones the repository to `~/.howdo`, sets up the necessary files, and adds a source line to your `.zshrc`.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/TohidHeshmati/howdo/main/install.sh)"
```

After installation, restart your terminal or run `source ~/.zshrc` to apply the changes.

## 🐚 Shell

Currently, `howdo` only supports **Zsh**.

## ✨ Key Features

*   **Live Variable Injection:** Detects `<placeholders>` and prompts you for values with history support.
*   **Safety First:** Automatically detects destructive actions (`rm`, `delete`, `push`, etc.) and offers to append `--dry-run`.
*   **Rich Previews:** Uses `bat` for syntax highlighting and custom formatting for explanations and tips.
*   **Quick Add:** Add new snippets instantly using the `howadd` function without leaving your terminal.
*   **Granular Organization:** Categorize commands into specific files (git, docker, network) for faster searching.

## 🛠️ Usage

*   **`howdo`**: Opens the main fuzzy search interface.
    *   **`[ENTER]`**: Selects and buffers the chosen command into your prompt.
    *   **`[CTRL-E]`**: Opens the source file of the selected command in your default editor.
    *   **`[CTRL-A]`**: Adds a new command to your library on the fly.
*   **`howadd`**: A standalone function to quickly add a new command to one of your cheat sheets.
*   **`howdo_update`**: Pulls the latest changes from the `howdo` repository and reloads the functions.

## ✍️ Cheat Sheet Syntax

Your cheat sheets are simple text files located in the `~/.howdo/files/` directory. Each line represents a command and follows this format:

`[TAG] command <variable> ;; explanation @ variable: tip #metadata`

### Example:

```
[GIT] git commit -m "<msg>" ;; Commits staged changes with a message. @ msg: Write a clear, concise summary of your changes. #git #commit
```

*   **`[TAG]`**: (Optional) A tag to categorize the command (e.g., `[GIT]`, `[DOCKER]`).
*   **`command <variable>`**: The command itself. Use `<variable>` for placeholders.
*   **`;;`**: A separator for the command's explanation.
*   **`@ variable: tip`**: (Optional) A tip for a specific variable.
*   **`#metadata`**: (Optional) Additional tags for searching.

## 📂 Project Structure

The project is structured as follows:

*   **`bin/`**: Contains the main `howdo.zsh` script.
*   **`files/`**: Contains the cheat sheet files.
*   **`lib/`**: Contains the Zsh completion script.
*   **`install.sh`**: The installation script.

The cheat sheets are organized by topic:

*   `network.txt`: Networking commands (`ping`, `curl`, `traceroute`).
*   `text-processing.txt`: Text manipulation commands (`grep`, `sed`, `awk`).
*   `sys-admin.txt`: System administration commands (`uptime`, `free`, `chmod`).
*   `docker.txt` / `k8s.txt`: Container and orchestration management.
*   `git.txt`: Git commands.
