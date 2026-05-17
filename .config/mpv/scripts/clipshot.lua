local SHOT = '/tmp/mpv-screenshot.jpeg'

local function clipshot(arg)
    return function()
        mp.commandv('screenshot-to-file', SHOT, arg)
        mp.command_native_async(
            { 'run', 'sh', '-c', ('copyq copy image/jpeg - < %q'):format(SHOT) },
            function(suc, _, err)
                mp.osd_message(suc and 'Copied screenshot to clipboard' or err)
            end
        )
    end
end

mp.add_key_binding('c', 'clipshot-subs', clipshot('subtitles'))
mp.add_key_binding('C', 'clipshot-video', clipshot('video'))
mp.add_key_binding('Alt+c', 'clipshot-window', clipshot('window'))
