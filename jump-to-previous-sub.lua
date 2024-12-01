-- 解析字幕文件中的所有字幕条目
function get_subtitles()
    mp.msg.info("加载字幕文件...")
    
    -- 获取所有字幕文件
    local sub_files = mp.get_property_native("sub-files")
    if not sub_files or #sub_files == 0 then
        mp.msg.error("未找到字幕文件。")
        return {}
    end
    
    -- 假设加载第一个字幕文件
    local subtitles_file = sub_files[1]
    mp.msg.info("使用字幕文件: " .. subtitles_file)

    -- 打开字幕文件并读取内容
    local file = io.open(subtitles_file, "r")
    if not file then
        mp.msg.error("无法打开字幕文件。" .. subtitles_file)
        return {}
    end

    local content = file:read("*all")
    file:close()
    
    -- 提取字幕条目
    local lines = {}
    for line in content:gmatch("Dialogue: ([^\n]+)") do
        local start_time, end_time = line:match("([%d:%.,]+),([%d:%.,]+),")
        if start_time and end_time then
            -- 将时间从字符串转换为秒数
            local start_sec = parse_time(start_time)
            local end_sec = parse_time(end_time)
            table.insert(lines, {
                start = start_sec,
                finish = end_sec,
            })
            -- mp.msg.info(string.format("解析字幕条目: start=%f, finish=%f", start_sec, end_sec))
        else
            mp.msg.warn("无法解析字幕条目: " .. line)
        end
    end

    return lines
end

-- 解析时间字符串为秒数
function parse_time(t)
    local h, m, s = t:match("(%d+):(%d+):([%d.]+)")
    local total_seconds = tonumber(h) * 3600 + tonumber(m) * 60 + tonumber(s)
    return total_seconds
end

-- 处理左箭头按键事件
function on_left_arrow()
    mp.msg.info("左箭头被按下，跳转到上一条字幕...")

    -- 获取当前播放时间
    local current_time = mp.get_property_number("time-pos", 0)
    mp.msg.info("当前时间: " .. current_time)

    -- 获取所有字幕条目
    local subtitles = get_subtitles()
    if #subtitles == 0 then
        mp.msg.warn("没有找到字幕条目。")
        return
    end

    -- 寻找当前时间之前的最后一条字幕
    local previous_sub = nil
    for i = #subtitles, 1, -1 do
        -- mp.msg.info(string.format("检查字幕 %d: start=%f, finish=%f", i, subtitles[i].start, subtitles[i].finish))
        if subtitles[i].finish <= current_time then
            previous_sub = subtitles[i]
            mp.msg.info("找到上一条字幕: " .. previous_sub.start)
            break
        end
    end

    -- 如果找到了上一条字幕，跳转到它的开始时间
    if previous_sub then
        mp.msg.info("跳转到上一条字幕的 start time: " .. previous_sub.start)
        mp.set_property("time-pos", previous_sub.start)
    else
        mp.msg.warn("未发现上一条字幕。")
    end
end

-- 绑定左箭头按键事件
mp.add_key_binding("left", "jump-to-previous-sub", on_left_arrow)
