import catppuccin
catppuccin.setup(c, 'mocha', True)
# config.source('bestblack.py')

c.content.user_stylesheets = "/home/ahsan/.config/qutebrowser/css/sharify.css"
c.fonts.default_size       = "12pt"
c.fonts.default_family     = "Share"
c.fonts.web.family.fixed   = "Share Tech Mono"
c.zoom.default      = 100

c.url.searchengines = {
    "DEFAULT":"https://google.com/search?q={}",
    "ddg":"https://duckduckgo.com/?q={}",
    "you":"https://youtube.com/results?search_query={}",
    "tl":"https://translate.google.com/?sl=auto&tl=en&text={}&op=translate",
    "hs":"https://hoogle.haskell.org/?hoogle={}&scope=set%3Astackage",
    "lg": "http://libgen.is/search.php?req={}&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def",
    "gr": "https://www.goodreads.com/search?q={}&qid=",
}

c.hints.chars = "wearsdfjklio"

c.editor.command    = ["alacritty", "-e", "vim", "-f", "{file}", 
                       "-c", "normal {line}G{column0}l"]
c.url.default_page  = "https://web.tabliss.io/"
c.url.start_pages   = "https://web.tabliss.io/"

c.confirm_quit      = ["downloads"]
c.downloads.location.directory = "/home/ahsan/downloads/"
c.downloads.position = "bottom"
c.content.autoplay  = False
c.auto_save.session = True

c.content.blocking.whitelist = ["https://www.i2pdf.com/crop-pdf"]

c.aliases = {
    "w"        : "session-save",
    "wq"       : "quit --save",
    "q"        : "close",
    "mpv"      : "spawn --userscript /home/ahsan/.config/qutebrowser/userscripts/view_in_mpv",
    "pass"     : "spawn -d pass -c",
    "d"        : "set downloads.location.prompt"
}

# Padding around text for tabs
c.tabs.padding = {
    "left"   : 3,
    "right"  : 3,
    "top"    : 2,
    "bottom" : 2,
}


config.load_autoconfig()

config.unbind("=")
config.unbind("+")
config.bind("=", "zoom-in")
config.bind("+", "zoom")

config.unbind("<ctrl+tab>")
config.bind("<ctrl+tab>", "tab-next")
config.bind("<ctrl+shift+tab>", "tab-prev")
config.bind("wo", "set-cmd-text -sr :tab-focus")
config.bind("yd", "yank;;tab-close")

config.unbind(";d")
config.bind(";dt", "set downloads.location.prompt true ;; set downloads.remove_finished -1")
config.bind(";df", "set downloads.location.prompt false ;; set downloads.remove_finished 0")

config.bind(";p", "mode-enter passthrough")

# config.unbind("cd")
config.bind("cc", "download-clear")
config.bind("co", "download-open")
config.bind("e", 'spawn mpv --no-terminal -force-window=immediate ' + 
            '--keep-open=yes "{url}"')
config.bind(";m", 'hint links spawn mpv --no-terminal -force-window=immediate ' + 
            '--keep-open=yes "{hint-url}"')
# config.bind(";v", 'spawn yt-dlp -o' +  
#             '"/home/ahsan/downloads/%(title)s_%(id)s.%(ext)s" "{url}" ')
# config.bind(";V", 'hint links spawn yt-dlp -o' +  
#             '"/home/ahsan/downloads/%(title)s_%(id)s.%(ext)s" "{hint-url}" ')
config.bind(";c", 'hint images userscript copy_image_to_clipboard')

config.bind("<ctrl+l>", "hint inputs --first")
config.unbind("<ctrl+q>")
config.unbind("<ctrl+w>")
config.bind("<ctrl+q>", "wq")
config.bind("<ctrl+w>", "tab-close")
config.unbind("sf")
config.bind("sf", "save;;session-save")
config.unbind("<ctrl+a>")

config.bind("J", "tab-prev")
config.bind("K", "tab-next")
config.unbind("gJ")
config.unbind("gK")
config.bind("gJ", "tab-move -")
config.bind("gK", "tab-move +")
config.bind("<", "navigate decrement")
config.bind(">", "navigate increment")

config.unbind("D")
config.bind("D", "yank ;; tab-close")

config.unbind("<ctrl+v>")
config.bind("<ctrl+shift+g>", 'mode-enter passthrough')
config.bind("<ctrl+shift+r>", "config-source /home/ahsan/.config/qutebrowser/config.py")
config.bind("<ctrl+shift+p>", "open -p")
config.unbind("<ctrl+shift+w>")

# config.bind("e", "spawn --userscript /home/ahsan/.config/qutebrowser/userscripts/view_in_mpv")
config.bind("sp", "spawn --userscript qute-lastpass")
