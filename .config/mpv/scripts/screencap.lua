local OUT_DIR = '/home/ahsan/pictures/screencasts/'

local MODES = {
    lossy = {
        label = 'lossy/fast',
        ext   = 'mp4',
        args  = { '-c:v', 'libx264', '-preset', 'ultrafast', '-crf', '35', '-c:a', 'aac', '-b:a', '96k' }
    },
    hq = {
        label = 'high quality',
        ext   = 'mkv',
        args  = { '-c:v', 'libx265', '-preset', 'slow', '-crf', '16', '-pix_fmt', 'yuv420p10le', '-c:a', 'aac', '-b:a', '192k' }
    },
    lossless = {
        label = 'lossless',
        ext   = 'mkv',
        args  = { '-c:v', 'libx265', '-preset', 'slow', '-x265-params', 'lossless=1', '-pix_fmt', 'yuv420p10le', '-c:a', 'flac' }
    },
}

local function encode(mode)
    return function()
        local a = mp.get_property_number('ab-loop-a')
        local b = mp.get_property_number('ab-loop-b')

        if not a or not b or a == -1 or b == -1 then
            mp.osd_message('Set A-B loop points first (;)')
            return
        end
        if b <= a then
            mp.osd_message('B must be after A')
            return
        end

        local src = mp.get_property('path')
        if not src then
            mp.osd_message('No file loaded')
            return
        end

        local m        = MODES[mode]
        local src_name = mp.get_property('filename/no-ext')
        local outfile  = string.format('%s%s_%.2f_%.2f.%s', OUT_DIR, src_name, a, b, m.ext)

        local cmd      = {
            'ffmpeg', '-y',
            '-ss', tostring(a),
            '-to', tostring(b),
            '-i', src,
            '-sn',
        }
        for _, v in ipairs(m.args) do
            cmd[#cmd + 1] = v
        end
        cmd[#cmd + 1] = outfile

        mp.osd_message(string.format('Encoding (%s)...', m.label))

        mp.command_native_async({
            name           = 'subprocess',
            args           = cmd,
            capture_stderr = true,
        }, function(suc, res)
            if suc and res.status == 0 then
                mp.command_native_async(
                    { 'run', 'sh', '-c', ('printf %%s %q | copyq copy text/plain -'):format(outfile) },
                    function()
                        mp.osd_message('Done: ' .. outfile)
                    end
                )
            else
                mp.msg.error(tostring(res.stderr))
                mp.osd_message('Encode failed: ' .. tostring(res.status))
            end
        end)
    end
end

mp.add_key_binding('Ctrl+Shift+c', 'clip-lossy', encode('lossy'))
mp.add_key_binding('Ctrl+Shift+e', 'clip-hq', encode('hq'))
mp.add_key_binding('Ctrl+Shift+l', 'clip-lossless', encode('lossless'))
