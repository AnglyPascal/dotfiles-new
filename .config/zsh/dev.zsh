# =============================================================================
# ~/.config/zsh/dev.zsh - Development tools (Git, C++, build systems)
# =============================================================================

# Git shortcuts
alias gst="git status"
alias gco="git checkout" 
alias gcb="git checkout -b"
alias gpl="git pull"
alias gps="git push"
alias glog="git log --oneline -10"
alias gdiff="git diff"
alias ga="git add"
alias gcom="git commit -m"
alias grg="git --no-pager grep"

# C++ Development
alias gcc_arm="arm-none-eabi-gcc"
alias gdb_arm="arm-none-eabi-gdb"
alias arm="arm-none-eabi-gcc"

# Build system shortcuts
cpp_build() {
    local build_type="${1:-r}"
    local build_dir="${2:-build}"
    
    # Map short forms to full CMake build types
    case "$(echo "${build_type}" | tr '[:upper:]' '[:lower:]')" in
        d|debug)
            build_type="Debug" ;;
        r|rel|release)
            build_type="Release" ;;
        rd|relwithdeb|relwithdebinfo)
            build_type="RelWithDebInfo" ;;
        ms|minsize|minsizerel)
            build_type="MinSizeRel" ;;
        *)
            echo "[!] Unknown build type: $build_type"
            echo "   Valid options: d/debug, r/release, rd/relwithdebinfo, ms/minsizerel"
            return 1 ;;
    esac
    
    # Set default build_dir based on build_type if not explicitly provided
    if [[ "$2" == "" ]]; then
        if [[ "$build_type" == "Debug" ]]; then
            build_dir="build_dev"
        else
            build_dir="build"
        fi
    fi
    
    echo "Building C++ project..."
    echo "   Build dir: $build_dir"
    echo "   Type: $build_type"
    
    if [[ ! -d "$build_dir" ]]; then
        mkdir -p "$build_dir"
    fi
    
    cd "$build_dir" || return 1
    
    if command -v ninja &> /dev/null; then
        cmake -DCMAKE_BUILD_TYPE="$build_type" -GNinja .. && ninja
    else
        cmake -DCMAKE_BUILD_TYPE="$build_type" .. && make -j$(nproc)
    fi
    
    cd ..
}

cpp_clean() {
    local build_dir="${1:-build}"
    
    # Check if first argument is a build type shortform
    case "$(echo "${1}" | tr '[:upper:]' '[:lower:]')" in
        d|debug)
            build_dir="build_dev" ;;
        r|rel|release|rd|relwithdeb|relwithdebinfo|ms|minsize|minsizerel)
            build_dir="build" ;;
        "")
            build_dir="build" ;;  # Default case
        *)
            build_dir="$1" ;;     # Use as literal directory name
    esac
    
    if [[ -d "$build_dir" ]]; then
        echo "Cleaning build directory: $build_dir"
        rm -rf "$build_dir"
    else
        echo "No build directory found: $build_dir"
    fi
}

cpp_run() {
    local build_dir=""
    local binary="${2:-main}"
    
    # Check if first argument is a build type shortform
    case "$(echo "${1}" | tr '[:upper:]' '[:lower:]')" in
        d|debug)
            build_dir="build_dev" ;;
        r|rel|release|rd|relwithdeb|relwithdebinfo|ms|minsize|minsizerel)
            build_dir="build" ;;
        "")
            build_dir="build" ;;  # Default case
        *)
            build_dir="$1" ;;     # Use as literal directory name
    esac
    
    if [[ -f "$build_dir/$binary" ]]; then
        echo "Running: $build_dir/$binary"
        "$build_dir/$binary"
    else
        echo "[x] Binary not found: $build_dir/$binary"
        return 1
    fi
}

# Quick single-file compile and run
com() {
    local file="$1"
    local output="${file%.*}"
    
    if [[ ! -f "$file" ]]; then
        echo "[x] File not found: $file"
        return 1
    fi
    
    echo "Compiling: $file"
    if g++ -std=c++20 -Wall -Wextra -O2 "$file" -o "$output"; then
        echo "[✓] Compilation successful"
        echo "Running: $output"
        "./$output"
    else
        echo "[x] Compilation failed"
        return 1
    fi
}

# Git cheat sheet tool
gcheat() {
    case "${1:-help}" in
        help|--help|-h)
            echo "Git Cheat Sheet"
            echo "=================="
            echo "  gcheat basic     │ Basic operations (status, add, commit)"
            echo "  gcheat branch    │ Branch operations"
            echo "  gcheat remote    │ Remote operations" 
            echo "  gcheat undo      │ Undo operations"
            echo "  gcheat search    │ Search operations"
            echo "  gcheat config    │ Configuration"
            echo "  gcheat aliases   │ Show current git aliases"
            ;;
        basic)
            echo "Basic Git Operations"
            echo "======================="
            echo "  git status               │ gst    │ Show repo status"
            echo "  git add                  │ ga     │ Stage all changes"
            echo "  git add -p               │ gap    │ Interactive staging"
            echo "  git commit -m \"msg\"      │ gcom   │ Commit with message"
            echo "  git commit -am \"msg\"     │        │ Stage all and commit"
            echo "  git push                 │ gps    │ Push changes"
            echo "  git pull                 │ gpl    │ Pull changes"
            echo "  git log --oneline -10    │ glog   │ Recent commits"
            echo "  git diff                 │ gdiff  │ Show changes"
            ;;
        branch)
            echo "Branch Operations"
            echo "==================="
            echo "  git checkout <branch>    │ gco    │ Switch to branch"
            echo "  git checkout -b <name>   │ gcb    │ Create & switch"
            echo "  git branch               │        │ List local branches"
            echo "  git branch -r            │        │ List remote branches"
            echo "  git branch -d <name>     │        │ Delete local branch"
            echo "  git merge <branch>       │        │ Merge branch"
            echo "  git rebase <branch>      │        │ Rebase onto branch"
            echo "  git branch -m <new>      │        │ Rename current branch"
            ;;
        remote)
            echo "Remote Operations"
            echo "==================="
            echo "  git remote -v               │        │ Show remotes"
            echo "  git fetch                   │        │ Fetch changes"
            echo "  git pull --rebase           │        │ Pull with rebase"
            echo "  git push -u origin <br>     │        │ Push & set upstream"
            echo "  git push --force-with-lease │        │ Safe force push"
            echo "  git remote add <n> <url>    │        │ Add remote"
            ;;
        undo)
            echo "Undo Operations"
            echo "=================="
            echo "  git checkout -- <file>   │        │ Discard file changes"
            echo "  git reset HEAD <file>    │        │ Unstage file"
            echo "  git reset --soft HEAD~1  │        │ Undo commit, keep changes"
            echo "  git reset --hard HEAD~1  │        │ Undo commit, lose changes"
            echo "  git revert <commit>      │        │ Safe undo via new commit"
            echo "  git reflog               │        │ Show reference log"
            echo "  git stash                │        │ Stash changes"
            echo "  git stash pop            │        │ Apply last stash"
            ;;
        search)
            echo "Search Operations"
            echo "==================="
            echo "  git grep <pattern>       │ grg    │ Search tracked files"
            echo "  git log --grep=\"msg\"     │        │ Search commit messages"
            echo "  git log -S\"code\"         │        │ Search code changes"
            echo "  git log --author=\"name\"  │        │ Search by author"
            echo "  git blame <file>         │        │ Show line authors"
            echo "  git show <commit>        │        │ Show commit details"
            ;;
        config)
            echo "Configuration"
            echo "=================="
            echo "  git config user.name \"N\"       │ Set username"
            echo "  git config user.email \"E\"      │ Set email"
            echo "  git config --global --list     │ Show config"
            echo "  git config --global alias.<n>  │ Create alias"
            echo "  git config core.editor nvim    │ Set editor"
            ;;
        aliases)
            echo "Current Git Aliases"
            echo "====================="
            if git config --get-regexp alias &>/dev/null; then
                git config --get-regexp alias | sed 's/alias\.//' | column -t -s ' '
            else
                echo "No git aliases configured"
            fi
            ;;
        *)
            echo "[x] Unknown section: $1"
            echo "Use 'gcheat help' to see available sections"
            ;;
    esac
}
