alias q='exit'
alias now='echo $(basename $(pwd))'
alias rm='rm -v'
alias rr='rm -r'
alias du='du -h'
alias c='clear'
alias rgh='history|rg'

alias cp="cp -i"
alias df='df -h'
alias free='free -m'

alias grg="git --no-pager grep"

alias wo='nmcli device connect wlp3s0'
alias xp='sudo pkill Pentablet_Drive; sudo /home/ahsan/.config/xp_pen/Pentablet_Driver.sh'

alias ls='ls -X --group-directories-first --color=auto'
alias ll='ls -alF'
alias la='ls -XA --group-directories-first --color=auto'
alias ld='ls -d */'
alias lc='ls --hide="*.class" --hide="*.out"'
alias math='cd /home/ahsan/git/main/; vim main.tex'

alias oxcs='ssh ug21maam@ecs.ox.ac.uk'

alias musicbee='wine "$wine/Program Files (x86)/MusicBee/MusicBee.exe"'
alias kate='QT_IM_MODULE=ibus kate &!'
alias tg="telegram-desktop QT_IM_MODULE=ibus &!"
alias r='ranger'
alias fm='dolphin ./ &!'

alias yt='noglob yt-dlp'
alias yv='noglob yt-dlp -o "%(title)s.%(ext)s"'
alias ym='noglob yt-dlp --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"'

alias wss="sudo systemctl start windscribe"
alias wsh='windscribe connect hk'
alias wsu='windscribe connect us'
alias wso='windscribe disconnect'

alias kmd='killall megasync dropbox'

alias fv="find . -regex '$vidRegex' -type f -exec echo \"{}\" \;"
alias fp="find . -regex '$picRegex' -type f -exec echo \"{}\" \;"

alias gpssh='gcloud compute ssh --zone "us-central1-c" "main" --project "group-design-practical"'
alias snvim="sudo -E -s nvim"

alias gcc_arm="arm-none-eabi-gcc"
alias arm="arm-none-eabi-gcc"

