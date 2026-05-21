# =============================================================================
# ~/.config/zsh/media.zsh - Media handling (mpv, feh, documents)
# =============================================================================

# Enhanced MPV with better defaults
mpv() { /usr/bin/mpv --force-window "$@" &| }
mpvc() { /usr/bin/mpv --loop-file=0 "$@" &| }

# Enhanced MPV shuffled playlist with path support
mpvs() {
  local shuffle=true
  local recursive=false
  local -a paths=()

  # Parse options and collect paths
  while [[ $# -gt 0 ]]; do
    case $1 in
    -n | --no-shuffle)
      shuffle=false
      shift
      ;;
    -s | --shuffle)
      shuffle=true
      shift
      ;;
    -l | --local)
      recursive=false
      shift
      ;;
    -r | --recursive)
      recursive=true
      shift
      ;;
    -h | --help)
      echo "MPV Shuffle Player"
      echo "Usage: mpvs [OPTIONS] [PATHS...]"
      echo "  -s/--shuffle (default)    │ Shuffle playlist"
      echo "  -n/--no-shuffle          │ Play in order"
      echo "  -r/--recursive           │ Include subdirectories"
      echo "  -l/--local (default)     │ Current directory only"
      echo ""
      echo "PATHS can be:"
      echo "  • Video files (direct playbook)"
      echo "  • Directories (search for videos)"
      echo "  • Mix of files and directories"
      echo "  • If no paths given, uses current directory"
      return 0
      ;;
    -*)
      echo "[x] Unknown option: $1"
      return 1
      ;;
    *)
      paths+=("$1")
      shift
      ;;
    esac
  done

  # Default to current directory if no paths given
  [[ ${#paths} -eq 0 ]] && paths=(".")

  local video_exts=(
    mp4 mkv webm gif mov avi wmv flv
  )

  local video_regex=".*\.(${(j:|:)video_exts})$"
  local find_regex='.*\.\('"${(j:\|:)video_exts}"'\)$'
  local video_files=""

  for target_path in "${paths[@]}"; do
    # Resolve to absolute path using zsh built-ins
    local abs_path
    if [[ "$target_path" = /* ]]; then
      # Already absolute path
      abs_path="$target_path"
    else
      # Convert relative path to absolute
      abs_path="$PWD/$target_path"
    fi

    # Normalize the path (remove ./ and ../ components)
    abs_path="${abs_path:A}"

    if [[ ! -e "$abs_path" ]]; then
      echo "[x] Path not found: $target_path"
      continue
    fi

    if [[ -f "$abs_path" ]]; then
      # Direct file - check if it's a video
      if [[ "$abs_path" =~ $video_regex ]]; then
        video_files+="$abs_path"$'\n'
      else
        echo "[!] Skipping non-video file: $target_path"
      fi
    elif [[ -d "$abs_path" ]]; then
      # Directory - find videos
      local find_args=(-type f -iregex "$find_regex")
      [[ "$recursive" == false ]] && find_args=(-maxdepth 1 "${find_args[@]}")

      local dir_videos=$(find "$abs_path" "${find_args[@]}" 2>/dev/null)
      [[ -n "$dir_videos" ]] && video_files+="$dir_videos"$'\n'
    else
      echo "[x] Path not found: $target_path"
    fi
  done

  # Remove trailing newline and check if we found anything
  video_files=${video_files%$'\n'}

  if [[ -z "$video_files" ]]; then
    echo "[x] No video files found in given paths"
    return 1
  fi

  echo "Found $(echo "$video_files" | wc -l) video files"
  [[ "$shuffle" == true ]] && video_files=$(echo "$video_files" | shuf)

  echo "$video_files" | xargs -d '\n' mpv --really-quiet --msg-level=all=info
}

alias mpvr='mpvs --recursive'
alias mpvn='mpvs --no-shuffle'

feh() { "$HOME/.config/zsh/feh.sh" "$@" }

# Document viewer with better error handling
z() {
  if [[ ! -f "$1" ]]; then
    echo "[x] File not found: $1"
    return 1
  fi

  case "$1" in
  *.pdf | *.djvu)
    echo "Opening document: $1"
    zathura "$1" &|
    ;;
  *.epub)
    echo "Opening ebook: $1"
    ebook-viewer "$1" &|
    ;;
  *.zip | *.cbz | *.rar | *.cbr)
    echo "Opening comic: $1"
    mcomix "$1" &|
    ;;
  *)
    echo "[x] Unsupported file type: $1"
    echo "Supported: pdf, djvu, epub, zip, cbz, rar, cbr"
    return 1
    ;;
  esac
}

# Quick file managers
alias fm='dolphin ./ &!'

combine_videos() {
  local output=""
  local files=()

  while [[ $# -gt 0 ]]; do
    case "$1" in
    -o)
      output="$2"
      shift 2
      ;;
    *)
      files+=("$1")
      shift
      ;;
    esac
  done

  if [[ -z "$output" || ${#files[@]} -eq 0 ]]; then
    echo "Usage: combine_videos file1 file2 ... -o output.mkv"
    return 1
  fi

  local list=$(mktemp /tmp/ffmpeg-concat-XXXX.txt)
  for f in "${files[@]}"; do
    printf "file '%s'\n" "$(realpath "$f")" >>"$list"
  done

  ffmpeg -f concat -safe 0 -i "$list" -c copy "$output"
  rm "$list"
}

compress_video() {
  local output=""
  local input=""
  local preset="medium"
  local crf=22

  while [[ $# -gt 0 ]]; do
    case "$1" in
    -o)
      output="$2"
      shift 2
      ;;
    -preset)
      preset="$2"
      shift 2
      ;;
    -crf)
      crf="$2"
      shift 2
      ;;
    *)
      input="$1"
      shift
      ;;
    esac
  done

  if [[ -z "$input" || -z "$output" ]]; then
    echo "Usage: compress_video input.mkv -o output.mkv [-preset slow] [-crf 20]"
    return 1
  fi

  ffmpeg -i "$input" \
    -c:v libx265 -preset "$preset" -crf "$crf" \
    -pix_fmt yuv420p10le \
    -c:a aac -b:a 128k \
    -sn \
    "$output"
}
