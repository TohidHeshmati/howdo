# 🧠 howdo

`howdo` is a context-aware command runner for Zsh. It transforms your flat cheat sheets into interactive tools that prompt for variables, remember your input history, and provide safety checks for destructive commands.



## 🚀 Key Features

* **Live Variable Injection:** Detects `<placeholders>` and prompts you for values with history support.
* **Safety First:** Automatically detects destructive actions (`rm`, `delete`, `push`, etc.) and offers to append `--dry-run`.
* **Rich Previews:** Uses `bat` for syntax highlighting and custom formatting for explanations and tips.
* **Quick Add:** Add new snippets instantly using the `howadd` function without leaving your terminal.
* **Granular Organization:** Categorize commands into specific files (git, docker, network) for faster searching.

---

## 📦 Installation

### 1. Clone and Install
Run the following commands to clone the repository and run the automated setup script:

```bash
git clone [https://github.com/TohidHeshmati/howdo.git](https://github.com/TohidHeshmati/howdo.git)
cd howdo
chmod +x install.sh
./install.sh
```

### 2. Manual Setup (Optional)
If you prefer to set it up manually, add this line to your `~/.zshrc`:

```bash
source /path/to/howdo/bin/howdo.zsh
```
### 3. Dependencies
Ensure you have the following installed:

fzf (Fuzzy search interface)

bat (Syntax highlighting)

grep (GNU-grep ggrep is recommended for macOS users)

### 🛠 Usage
Type howdo to open the search interface.

[ENTER]: Run/Buffer the selected command.

[CTRL-E]: Open the selected cheat file in nano.

[CTRL-A]: Add a new command to your library on the fly.

Cheat Sheet Syntax
Your files in the files/ directory should follow this format: [TAG] command <variable> ;; explanation @ variable: tip #metadata

### Example:
```
[GIT] git commit -m "<msg>" ;; Commit changes @ msg: Write a clear summary #git
```
### 📂 Project Structure
```
File,Content Types
network.txt,"ping, ip addr, curl, traceroute, arp"
text-processing.txt,"grep, sed, awk, sort, uniq, wc"
sys-admin.txt,"uptime, free, ps, chmod, stat"
docker.txt / k8s.txt,Container and Orchestration management
yazi.txt,Keybinds and shortcuts for the Yazi file manager
```