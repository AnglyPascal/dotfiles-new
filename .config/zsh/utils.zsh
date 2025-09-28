# =============================================================================
# ~/.config/zsh/utils.zsh - System utilities and file operations
# =============================================================================

# Enhanced find functions (your requested improvement)
if command -v fd &> /dev/null; then
    # Modern find using fd
    ff() {
        local pattern="$1"
        local path="${2:-.}"
        fd -i "$pattern" "$path"
    }
    
    fe() {
        local ext="$1" 
        local path="${2:-.}"
        fd -e "$ext" "$path"
    }
    
    fdir() {
        local pattern="$1"
        local path="${2:-.}"
        fd -t d -i "$pattern" "$path"
    }
    
    fx() {
        local pattern="$1"
        shift
        fd -i "$pattern" -x "$@"
    }
else
    # Fallback find functions
    ff() {
        local pattern="$1"
        local path="${2:-.}"
        echo "🔍 Searching for: $pattern in $path"
        find "$path" -iname "*$pattern*" -type f 2>/dev/null
    }
    
    fe() {
        local ext="$1"
        local path="${2:-.}"
        echo "🔍 Finding .$ext files in $path"
        find "$path" -name "*.$ext" -type f 2>/dev/null
    }
    
    fdir() {
        local pattern="$1"
        local path="${2:-.}"
        echo "🔍 Finding directories: $pattern in $path"
        find "$path" -type d -iname "*$pattern*" 2>/dev/null
    }
    
    fx() {
        local pattern="$1"
        shift
        echo "🔍 Finding and executing: $pattern"
        find . -iname "*$pattern*" -type f -exec "$@" {} \;
    }
fi

# Quick media file searches
fv() { 
    echo "🎬 Finding video files..."
    if command -v fd &> /dev/null; then
        fd -e mp4 -e mkv -e webm -e mov -e avi -e wmv -e flv "${1:-.}"
    else
        find "${1:-.}" -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.webm" -o -iname "*.mov" -o -iname "*.avi" \) 2>/dev/null
    fi
}

fp() {
    echo "🖼️  Finding image files..."
    if command -v fd &> /dev/null; then
        fd -e jpg -e jpeg -e png -e webp -e bmp "${1:-.}"
    else
        find "${1:-.}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null
    fi
}

# Content search in files
fs() {
    local pattern="$1"
    local path="${2:-.}"
    echo "🔍 Searching content: $pattern in $path"
    
    if command -v rg &> /dev/null; then
        rg -i "$pattern" "$path"
    else
        grep -r -i "$pattern" "$path"
    fi
}

# Time-based find functions
fmod() {
    local days="${1:-1}"
    echo "🕐 Finding files modified in last $days day(s)..."
    
    if command -v fd &> /dev/null; then
        fd --changed-within "${days}d" --type f
    else
        find . -mtime "-${days}" -type f
    fi
}

flarge() {
    local size="${1:-100}"
    echo "📊 Finding files larger than ${size}MB..."
    
    if command -v fd &> /dev/null; then
        fd --size +"${size}m" --type f
    else
        find . -size +"${size}M" -type f
    fi
}

# Directory size analysis
sizes() {
    echo "📊 Directory sizes:"
    if command -v dust &> /dev/null; then
        dust -d 1
    else
        du -h --max-depth=1 | sort -hr
    fi
}

# Toggle seagate ssd
sea() {
  if grep -qs '/home/ahsan/sea' /proc/mounts; then
    echo "remounting"
    sudo umount /dev/mapper/sea
    sudo cryptsetup luksClose sea
  else
    echo "mounting"
  fi
  dev="$(sudo blkid | rg "crypto_LUKS" | awk '{print substr($1, 1, length($1)-1)}')"
  sudo cryptsetup luksOpen $dev sea --key-file /root/sea.key
  sudo mount /dev/mapper/sea sea; 
}

# Archive extraction with better error handling
ex() {
    if [[ ! -f "$1" ]]; then
        echo "❌ File not found: $1"
        return 1
    fi
    
    echo "📦 Extracting: $1"
    case "$1" in
        *.tar.bz2|*.tbz2) tar xjf "$1" ;;
        *.tar.gz|*.tgz) tar xzf "$1" ;;
        *.tar.xz) tar xJf "$1" ;;
        *.tar) tar xf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *.xz) unxz "$1" ;;
        *.lzma) unlzma "$1" ;;
        *) echo "❌ Unsupported format: $1"; return 1 ;;
    esac
    echo "✅ Extraction complete"
}

# Extract all archives to individual folders
uz() {
    local count=0
    for archive in *.{zip,rar,7z}(N); do
        [[ -f "$archive" ]] || continue
        local name="${archive%.*}"
        mkdir -p "$name"
        
        case "$archive" in
            *.zip) unzip "$archive" -d "$name" ;;
            *.rar) unrar x "$archive" "$name/" ;;
            *.7z) 7z x "$archive" -o"$name" ;;
        esac
        
        echo "✅ $archive → $name/"
        ((count++))
    done
    
    [[ $count -eq 0 ]] && echo "No archives found to extract"
    [[ $count -gt 0 ]] && echo "🎉 Extracted $count archive(s)"
}

# Find help function
fhelp() {
    echo "🔍 Find Functions Help"
    echo "====================="
    echo "  ff <pattern> [path]  │ Find files by name (case insensitive)"
    echo "  fe <ext> [path]      │ Find files by extension"
    echo "  fdir <pattern>       │ Find directories"
    echo "  fx <pattern> <cmd>   │ Find files and execute command"
    echo "  fv [path]           │ Find video files"
    echo "  fp [path]           │ Find image files"
    echo "  fs <pattern> [path]  │ Search file contents"
    echo "  fmod [days]          │ Find recently modified files"
    echo "  flarge [mb]          │ Find large files (default: 100MB+)"
    echo
    echo "Examples:"
    echo "  ff config            │ Find files containing 'config'"
    echo "  fe cpp               │ Find all .cpp files"  
    echo "  fdir build           │ Find directories with 'build' in name"
    echo "  fx '*.log' rm        │ Delete all log files"
    echo "  fs 'TODO'            │ Search for 'TODO' in files"
    echo "  fmod 3               │ Files modified in last 3 days"
}

cq() {
    i=$1
    for x in {0..$((i-1))}
    do 
        l=$(copyq read $x)
        if [[ $l == *"youtube"* ]]; then
            echo $l >> $2
        else
            echo $l | cut -d "?" -f 1 >> $2
        fi
    done
}

tk() {
    temp=yt_temp
    if [[ -f "yt_temp" ]]; then rm $temp; fi
    cq $1 $temp
    while IFS= read -r line; do
        format="%(upload_date>%Y-%m-%d)s_%(epoch-3600>%H-%M-%S)s_%(title)s_%(id)s.%(ext)s"
        yt-dlp -o "$format" "$line"
    done < $temp
    rm $temp 
}
