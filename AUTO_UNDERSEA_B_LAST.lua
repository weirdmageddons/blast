local break_sj = false
local item_world = "..."
local item_world_id = "..."
local other_items_world = "..."
local other_items_world_id = "..."
local water_save_world = "..."
local water_save_world_id = "..."
local WebhookUrl = "..."
local trash_list = {1536,850,8252,8254,5040,5024,5026,5028,5030,5038,8254,8255,8253,5038}
local save_list = {1522,1523,846,847,1520,1521,832,3922,5039,833,1537,851,1538,1539,1530,1531,1528,1529,1524,1526,1518}







------------------------------DO NOT TOUCH HERE------------------------------

local app = "lucifer" --koftrfarm yada lucifer
local su_fiyat = 1 / 200
local eski_worldi_yapion = false
local clear_world_fiyat = 10
local dl_fiyat = 11
local punch_delay = 150
local water_delay = 150
local imageurl = "https://media.discordapp.net/attachments/1135480262013235243/1135982902287548467/11054541.png"
local esya_world = item_world
local esya_world_id = item_world_id


getBot().ignore_gems = true
getBot().collect_all = false

local current_world = nil
local curent_id = nil


local manuel = false
local manuel_world = ""--yerelması c.
local icons = {
    wl = "<:wl:1135500526432288869>",
    blast = "<:blast:1135486174182510693>",
    water = "<:water:1135486199839076452>",
    clock = "<:jam:987145988470898758>",
    dirt = "<:dirt:1135504350123397151>",
    world = "<:world:1006699847308546109>",
    bot = "<:growbot:992058196439072770>",
    id_1522 = "<:Jellyfish:1135600208324079636>",
    id_8252 = "<:SeaUrchin:1135600237554188339>",
    id_846 = "<:Seaweed:1135600260744495175>",
    id_1520 = "<:GreatWhiteShark:1135600282907181179>",
    id_832 = "<:Coral:1135600305174749185>",
    id_3922 = "<:DeepFossilRock:1160199769168298065>",
    id_5038 = "<:Anemone:1160206986336538635>",
    id_1536 = "<:DeepSand:1135600327081594910>",
    id_850 = "<:OceanRock:1135600348606759023>",
    id_1538 = "<:DeepRock:1135600377031577600>",
    id_1530 = "<:GiantClam:1135600410799911022>",
    id_1528 = "<:SunkenAnchor:1135600438289371249>",
    id_8254 = "<:CopperBlock:1135600475727745026>",
    signal_jam = "<:signal_jam:1135948665672974448>",
    cpu = "<:CPU:1135970927532851230>",
    ram = "<:RAM:1135970951578779648>",
    gem = "<:GEMS:1135970998571761815>",
    level = "<:LVLUP:1135969301011112016>",
    bp = "<:BPBOT:1135971018213691472>",
    online = "<a:StatusOnline:1135971041236230285>",
    ping = "<:PING:1135970974781669497>",
    id_1518 = "<:DivingBell:1136222406114033754>",
    id_1524 = "<:WetsuitPants:1136222381959024670>",
    id_1526 = "<:WetsuitTop:1136222357829197824>"
}
local folderPath = "worlds"

-- Check if the folder exists
local cmd = "mkdir " .. folderPath
local exitCode = os.execute(cmd)

if exitCode == 0 then
    print("Folder created successfully.")
else
    print("Error creating folder.")
end
local filePath = "worlds/" .. getBot().name .. ".txt"

local file = io.open(filePath, "r") -- Try opening the file for reading

if not file then
    -- File doesn't exist, create it
    file = io.open(filePath, "w") -- Open the file in write mode to create it
    if file then
        print("File created successfully.")
        file:close() -- Close the file
    else
        print("Error creating file.")
    end
else
    print("File already exists.")
    file:close() -- Close the file
end
local function getLocalSafe()
    local l = getLocal()
    if l ~= nil then
        return l
    else
        return {posx=-1,posy=-1}
    end
end
function replaceString(input_string, pattern, replacement, max_replacements, case_insensitive)
    -- Set default values for optional parameters
    max_replacements = max_replacements or -1
    case_insensitive = case_insensitive or false
    
    -- Prepare the pattern with case-insensitive flag if needed
    if case_insensitive then
        pattern = "(?i)" .. pattern
    end
    
    -- Perform the string replacement using string.gsub
    local new_string, num_replacements = string.gsub(input_string, pattern, replacement, max_replacements)
    
    return new_string, num_replacements
end
local function get_last_world()
    local file = io.open(filePath, "r")
    if not file then
        return "EXIT"
    end
    local fcon = file:read("*a")
    if not fcon then
        return "EXIT"
    end
    local lines = {}

    for line in fcon:gmatch("%s*([^\r\n]+)%s*") do
        line = replaceString(line,"\n","")
        line = replaceString(line,"\r","")
        table.insert(lines, line)
    end
    local index = (#lines)
    if index >= 1 then
        return lines[index]
    else
        return "EXIT"
    end
end
local function appendLog(text)
    local file = io.open(filePath, "a") -- Open the file in append mode
    if file then
        file:write(text) -- Write the text to the file
        file:close() -- Close the file
        print("Text appended to file.")
    else
        print("Error opening file for appending.")
    end
end


local water_mask = (1 << 10)
local bot = getBot()

local function saga_bak()
    local pkt = GameUpdatePacket.new()
    pkt.type = 0
    pkt.flags = 32
    pkt.vec_x = getLocalSafe().posx
    pkt.vec_y = getLocalSafe().posy
    pkt.int_x = 4294967295
    pkt.int_y = 4294967295
    bot:sendRaw(pkt)
    sleep(10)
end
local world = bot:getWorld()
local function getTileSafe(x,y)
    local tile = world:getTile(x,y)
    if tile == nil or tile.fg == nil then
        return {fg = 0,bg = 0,flags = 0}
    else
        return tile
    end
end
local inventory = bot:getInventory()

local scan_x = 0
local scan_y = 0

local current_world = ""
local olmam_gereken_world = ""
local olamam_gereken_world_id = nil
local break_pos = {}

local max_su = 5397
local yuzde = 0



local function bot_data()
    local str = icons["bot"] .. " Bot name: " .. bot.name .. "\n"..
    icons["level"] .. " Bot level: " ..bot.level .. "\n" ..
    icons["gem"] .. " Bot Gems: " ..bot.gem_count .. "\n" ..
    icons["bp"] .. " "..inventory.itemcount .. " / " .. inventory.slotcount .. "\n"..
    icons["world"] .. " Current world: "..world.name .. "\n" ..
    icons["online"] .. " Bot Satus: Online" .. "\n"..
    icons["ping"] .. " Ping: "..bot:getPing() .. "\n"
    return str
end
local is_in_safe_wrap = false
local function safe_wrap(name,id)
end
local function AnlikYer()
    if not is_in_safe_wrap then
        if string.upper(current_world) ~= string.upper(world.name) then
            safe_wrap(current_world,curent_id)
            sleep(5000)
        end
        if curent_id ~= nil and getTileSafe(getLocalSafe().posx,getLocalSafe().posy).fg == 6 then
            safe_wrap(current_world,curent_id)
            sleep(5000)
        end

    end
    if app == "lucifer" then
        if bot.status ~= 1 then
            GonWebhook("Bot Offline @everyone ".." " .. bot.name .. "")
            while bot.status ~= 1 do
                bot:connect()
                sleep(1000 * 30 * 1)
            end
        sleep(5000)
            GonWebhook("Bot Back To Online @everyone ".." " .. bot.name .. "")
        end    
    elseif app == "koftrfarm" then
        if bot.state ~= 1 then
            GonWebhook("Bot Offline @everyone ".." " .. bot.name .. "")
            while bot.state ~= 1 do
            bot:connect()
            sleep(10000)
        end
        sleep(5000)
        GonWebhook("Bot Back To Online @everyone ".." " .. bot.name .. "")
        end    

    else
        bot:say("WTF WRONG COINFIG!")
    end
   
end
local function safe_wrap(name,id)
    is_in_safe_wrap = true
    current_world = name
    curent_id = id
    while (string.upper(name) ~= string.upper(world.name)) do
        AnlikYer()
        if id ~= nil then
            bot:warp(name,id)
        else
            bot:warp(name)
        end
        sleep(8000)
    end
    if id ~= nil then
        while true do
            sleep(5000)
            bot:warp(name,id)
            AnlikYer()
            local tile = getTileSafe(math.floor(getLocalSafe().posx / 32),math.floor(getLocalSafe().posy / 32))
            if tile.fg ~= 6 then
                is_in_safe_wrap = false
                return 0
            end
            bot:warp(name,id)
        end
    end
end

local worlds_done = 0

startT = os.time()

function SecondTT(seconds)
    local seconds = tonumber(seconds)
    if seconds <= 0 then
      return "00:00:00";
    else
      days = string.format("%02.f", math.floor(seconds / (3600 * 24)));
      hours = string.format("%02.f", math.floor(seconds / 3600) % 24);
      mins = string.format("%02.f", math.floor(seconds / 60) % 60);
      secs = string.format("%02.f", seconds % 60);
      
      if days == "00" then
        return hours .. ":" .. mins .. ":" .. secs
      else
        return days .. " days " .. hours .. ":" .. mins .. ":" .. secs
      end
    end
  end
  


  function xor_decode(input, key)
    local output = ""
    local keyLength = string.len(key)

    for i = 1, string.len(input) / 2 do
        local byte = tonumber(string.sub(input, i * 2 - 1, i * 2), 16)
        local keyByte = string.byte(key, (i % keyLength) + 1)
        local decodedByte = byte ~ keyByte  -- Bitwise XOR operation
        output = output .. string.char(decodedByte)
    end

    return output
end

function GonWebhook(Shinuqi)
    ::yeniden_dene::
    local script = [[
    $webHookUrl = "]]..WebhookUrl..[["
    $thumbnailObject = [PSCustomObject]@{
    url = ]] .. imageurl ..[[
    }
    $color = Get-Random -Minimum 0 -Maximum 16777215
    $title = 'YerElmasi-Koftrciali - Auto Undersea blast'
    $description = "**]]..Shinuqi..[[**"
  
    $footer = [PSCustomObject]@{
        icon_url = "https://cdn.discordapp.com/emojis/978628955907170314.gif?size=96&quality=lossless"
        text = "]].."YerElmasi-Koftrciali | Date : "..(os.date"%d/%m/%y":upper().." Hour : ")..os.date("%I")..":"..os.date("%M").." "..os.date("%p"):upper()..[["
    }
  
    $embedObject = [PSCustomObject]@{
        color = $color
        title = $title
        description = $description
        thumbnail = $thumbnailObject
        footer = $footer
    }
  
    [System.Collections.ArrayList]$embedArray = @()
    $embedArray.Add($embedObject)
  
    $payload = [PSCustomObject]@{
        embeds = $embedArray
    }
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
    ]]
  
  
    local pipe = io.popen("powershell -command -", "w")
    if pipe == nil then
        goto yeniden_dene
    end
    pipe:write(script)
    pipe:close()
end

local function object_count_scan(id)
    local objects = world:getObjects()
    local count = 0
    for _, object in ipairs(objects) do
        if object.id == id then
            count = count + object.count
        end
    end
    return count
end


local world_name = "koftekral14"
local function drop(item_id,item_count)
    if item_count ~= 0 then
        bot:drop(item_id,item_count)
        
        sleep(200)
        
	
    end
end

local scan_objects = {}
local function scan_tile_obj(x,y)
    local x_start = (x * 32) - 8
    local x_end = ((x + 1) * 32) + 8

    local y_start = (y * 32) - 8
    local y_end = ((y + 1) * 32) + 8
    
    local i = 0
    for _, object in ipairs(scan_objects) do
        if object.x >= x_start and object.x <= x_end and object.y >= y_start and object.y <= y_end then
            i = i + 1
        end
    end
    return i

end
local function drop_safe(id,count)
        scan_objects = world:getObjects()
        local x = math.floor(getLocalSafe().posx / 32) + 1
        local y = math.floor(getLocalSafe().posy / 32)
        ::yeniden::
        local obj_count = scan_tile_obj(x,y)
        if obj_count >= 20 then
            x = x + 1
            if x > 97 then
                y = y + 1
                x = 2
            end
            goto yeniden
        end
        bot:findPath(x - 1,y)
        saga_bak()
        sleep(1000)
        drop(id,count)
        sleep(1000)
    
   

end
local function water_save()
    AnlikYer()
    bot.auto_collect = false
    safe_wrap(water_save_world,water_save_world_id)
   
    sleep(500)
    ::zzzc::
    local item = inventory:getItem(822)
    if item ~= nil and item.count ~= nil and item.count >= 199 then
        drop_safe(822,item.count - 1)
        goto zzzc
    end
    bot:say("droped items")
   local tl_world = 0
   if worlds_done > 0 then
    tl_world = math.floor(((worlds_done * clear_world_fiyat) / 100) * dl_fiyat)
   end
   local tl_su = 0
   if object_count_scan(822) > 0 then
    tl_su = math.floor(((object_count_scan(822) * su_fiyat) / 100) * dl_fiyat)
   end
   
    GonWebhook(
        "Water Save World Information\n"..
        bot_data() ..
        icons["world"].." Water Collect world "..world_name.. " [%" .. math.floor(yuzde) .. "]" .. "\n" ..
        icons["water"].." Droped Water count: "..object_count_scan(822) ..  "["..tl_su .. "TL]" .. "\n"..
        icons["clock"].." Uptime Bot: "..SecondTT(os.difftime(os.time(), startT)) .."\n" ..
        icons["dirt"].." Total Worlds done: "..worlds_done .. "["..tl_world .. "TL]"
    )
    
    sleep(5000)
    safe_wrap(world_name,nil)
    AnlikYer()
    sleep(500)
    bot:findPath(scan_x,scan_y)
    AnlikYer()
    sleep(500)
    bot.auto_collect = true
end
--bot:say("y:" .. math.floor(getLocalSafe().posy / 32) )
local function water_var_mi(x,y)
    if x > 99 or x < 0 or y > 60 or y < 0 then
        return false
    end
    local tile = getTileSafe(x,y)
    return (tile.flags & water_mask) == water_mask
end
local function break_tile(x,y)
    if string.upper(current_world) ~= world.name then
        safe_wrap(current_world,nil)
    end
    while getTileSafe(x,y).fg ~= 0 or  getTileSafe(x,y).bg ~= 0 do
        if string.upper(current_world) ~= world.name then
            safe_wrap(current_world,nil)
        end
        AnlikYer()
        while break_pos[1] ~= math.floor(getLocalSafe().posx / 32) or break_pos[2] ~= math.floor(getLocalSafe().posy / 32) do
            bot:findPath(break_pos[1],break_pos[2])
            sleep(50)
        end
        bot:hit(x,y)
        sleep(punch_delay)
    end
end
local function yukari_kir()
    local y = math.floor((getLocalSafe().posy / 32)) - 1
    local x = 99
    while y >= 0 do
        AnlikYer()
        if getTileSafe(x,y).fg ~= 0 then
            break_pos = {x,y + 1}
            break_tile(x,y)
        end
        y = y - 1
    end
end
local function trash(item_id,item_count)
    if item_count ~= 0 then
	    bot:sendPacket(2, "action|trash\n|itemID|" .. item_id);
        sleep(5000)
        bot:sendPacket(2, "action|dialog_return\ndialog_name|trash_item\nitemID|".. item_id .."|\ncount|" .. item_count);
    end
end
local ignore_list = {
    242,--wl
    8, -- bedrock
    3760,--data bedrock
    6,--beyaz kapı
    9640, --my first wl
    226, --signal jammer
    3554,
    2382,
    2302,
    3682
}
local function get_white_door_pos()
    AnlikYer()
    local tiles = world:getTiles()
    for _, tile in ipairs(tiles) do
        if tile.fg == 6 then
            return {tile.x,tile.y}
        end
    end
end
local white_door_pos = get_white_door_pos()
--bot:say("x:" .. white_door_pos[1] .. " Y:" .. white_door_pos[2])
local function isInArray(element, array)
    for _, value in ipairs(array) do   
        if value == element then
            return true
        end
    end
    return false
end
local function trash_if_need()
    for _, item_id in ipairs(trash_list) do
        local item = inventory:getItem(item_id)
        if item ~= nil and item.count ~= nil then
            if item.count > 150 then
                trash(item.id,item.count)
                sleep(1000)
                AnlikYer()
            end
        end
    end
end
local function need_save()
     for _, item_id in ipairs(save_list) do
        local item = inventory:getItem(item_id)
        if item ~= nil and item.count ~= nil and item.count > 190 then
            return true
        end
    end
    return false
end
local function save_if_need()
    if need_save() then
        bot.auto_collect = false
        local pos = {math.floor(getLocalSafe().posx / 32),math.floor(getLocalSafe().posy / 32)}
        safe_wrap(other_items_world,other_items_world_id)
        AnlikYer()
        sleep(500)
        
        for _, item_id in ipairs(save_list) do
            local item = inventory:getItem(item_id)
            if item ~= nil and item.count ~= nil and item.count > 0 then
                drop_safe(item.id,item.count)
                sleep(1000)
                AnlikYer()
                      
            end
                    
        end
        local web_str = ""
        for _, item_id in ipairs(save_list) do
            local icon_id = item_id
            
            if (item_id % 2) == 1 then
                icon_id = item_id - 1
            end
            local icon = icons["id_" .. icon_id]
            if icon == nil then
                icon = icons["dirt"]
            end

            web_str = web_str .. icon .. " " .. getInfo(item_id).name .. " count: "..object_count_scan(item_id) .. "\n"
        end
        local tl_world = 0
   if worlds_done > 0 then
    tl_world = math.floor(((worlds_done * clear_world_fiyat) / 100) * dl_fiyat)
   end
        GonWebhook(
            "other Save World Information\n"..
            bot_data() ..
            web_str ..
            icons["blast"].." Under Sea Blast Count: "..object_count_scan(1532).. "\n" ..
            icons["clock"].." Uptime Bot: "..SecondTT(os.difftime(os.time(), startT)) .."\n" ..
            icons["dirt"].." Total Worlds done: "..worlds_done .. "["..tl_world .. "TL]"
        )
        if string.upper(world.name) ~= string.upper( world_name) then
        safe_wrap(world_name,nil)
        sleep(500)
        bot:findPath(pos[1],pos[2])
        sleep(500)
        AnlikYer()
        end
        bot.auto_collect = true
    end 
end

local function sol_taraf_kir()
    if string.upper(current_world) ~= world.name then
        safe_wrap(current_world,nil)
    end
    bot:say("Script By .yerelmasi ")
    local i = white_door_pos[1]
    while i > 0 do
        AnlikYer()
        if string.upper(current_world) ~= world.name then
            safe_wrap(current_world,nil)
        end
        i = i - 1
        if getTileSafe(i,white_door_pos[2]).fg ~= 0 or  getTileSafe(i,white_door_pos[2]).bg ~= 0 then
            bot:findPath(i + 1,white_door_pos[2])
            break_pos = {i + 1 ,white_door_pos[2]}
            sleep(40)
            break_tile(i,white_door_pos[2])
            trash_if_need()
            save_if_need()
        end
        
    end
end

local function sag_taraf_kir()
    if string.upper(current_world) ~= world.name then
        safe_wrap(current_world,nil)
    end
    bot:say("Script By .yerelmasi ")
    local i = white_door_pos[1]
    while i < 99 do
        AnlikYer()
        if string.upper(current_world) ~= world.name then
            safe_wrap(current_world,nil)
        end
        i = i + 1
        if getTileSafe(i,white_door_pos[2]).fg ~= 0 or  getTileSafe(i,white_door_pos[2]).bg ~= 0 then
            bot:findPath(i - 1,white_door_pos[2])
            sleep(40)
            break_pos = {i -1 ,white_door_pos[2]}
            break_tile(i,white_door_pos[2])
            trash_if_need()
            save_if_need()
        end
        
    end
end
local function is_world_clear()
    local tiles = world:getTiles()
    for _, tile in ipairs(tiles) do
        if (tile.fg ~= 0 or tile.bg ~= 0) and not isInArray(tile.fg,ignore_list) then
            return false
        end
    end
    return true
end
local function world_kir()
    bot:say("World kirma basladi")
    while not is_world_clear() do
        for y = 0, 59 do
            local x_min = 0
            local x_max = 99
            local add_num = 1
            if (y % 2) == 0 then
                x_min = 99
                x_max = 0
                add_num = -1
            end
            for x = x_min, x_max,add_num do
                if string.upper(current_world) ~= world.name then
                    safe_wrap(current_world,nil)
                    sleep(500)
                end
            local tile = getTileSafe(x,y)
            
                if (tile.fg ~= 0 or tile.bg ~= 0) and not isInArray(tile.fg,ignore_list) then
                    local kircan = true
                    if tile.y - 2 >= 0 and (getTileSafe(tile.x,tile.y - 2).fg == 0 or getTileSafe(tile.x,tile.y - 2).fg == 6) then
                        break_pos = {tile.x,tile.y - 2}
                        bot:findPath(tile.x,tile.y - 2)
                        sleep(40)
                        break_tile(tile.x,tile.y)
                    elseif tile.x - 1 >= 0 and getTileSafe(tile.x - 1,tile.y).fg == 0  then
                        break_pos = {tile.x -1 ,tile.y}
                        bot:findPath(tile.x - 1,tile.y)
                        sleep(40)
                    elseif tile.x + 1 <= 99 and getTileSafe(tile.x + 1,tile.y).fg == 0 then
                        break_pos = {tile.x + 1,tile.y}
                        bot:findPath(tile.x + 1,tile.y)
                        sleep(40)
                    elseif tile.y - 1 >= 0 and getTileSafe(tile.x,tile.y - 1).fg == 0  then
                        break_pos = {tile.x,tile.y - 1}
                        bot:findPath(tile.x,tile.y - 1)
                        sleep(40)
                    
                    else
                        bot:say("kiramiyorum")
                        kircan = false
                    end
                    if kircan then
                        break_tile(tile.x,tile.y)
                    end
                    
                    trash_if_need()
                    save_if_need()
                    
                end
            end
        end
        
    end
end

local function collect_water(x,y)
    local fg = getTileSafe(x,y).fg
    if water_var_mi(x,y) and  not isInArray(fg,ignore_list) then
        local pkt = GameUpdatePacket.new()
        pkt.type = 3
        pkt.int_data = 822
        pkt.vec_x = getLocalSafe().posx
        pkt.vec_y = getLocalSafe().posy
        pkt.int_x = x
        pkt.int_y = y
        bot:sendRaw(pkt)
        sleep(water_delay)
    end
         
    
end
local function water_count()
    local count = 0
    for y = 0, 59 do
        for x = 0, 99 do
            if water_var_mi(x,y) then
                count = count + 1
            end
        end
    end
    return count
end
local left = true
local function pickup(oid,id)
    local object = world:getObject(oid)
    if object ~= nil and object.id == id then
        local pkt = GameUpdatePacket.new()
    pkt.type = 11
    pkt.int_data = oid
    pkt.vec_x = object.x
    pkt.vec_y = object.y
    pkt.int_x = math.floor(object.x + object.y + 4)
    bot:sendRaw(pkt)
    end
    

end
local function saveden_item_al()
    bot.auto_collect = false
    ::yeniden_x::
    local items_to_pickup = {
        242, -- wl
        1532, -- blast
        822, --su
        226 -- jammer
    }
    safe_wrap(esya_world,esya_world_id)
    sleep(500)
    local objects = world:getObjects()

    for _, object in ipairs(objects) do
        for _, item_id in ipairs(items_to_pickup) do
            if object.id == item_id then
                local item = inventory:getItem(item_id)
                if item == nil or item.count == nil or item.count == 0 then
                    bot:findPath(math.floor(object.x / 32),math.floor(object.y / 32))
                    sleep(100)
                    pickup(object.oid,object.id)
                    sleep(1000)
                    local item = inventory:getItem(item_id)
                    if item ~= nil and item.count ~= nil and item.count > 1 then
                        bot:findPath(math.floor(object.x / 32) - 1,math.floor(object.y / 32))
                        sleep(100)
                        saga_bak()
                        drop(object.id,object.count - 1)
                        sleep(1000)
                    end
                end
            end
        end
    end
    for _, item_id in ipairs(items_to_pickup) do
        local item = inventory:getItem(item_id)
                    if item ~= nil and item.count ~= nil and item.count > 1 and item.id ~= 822 then
                       
                        sleep(100)
                        drop(item.id,item.count - 1)
                        sleep(1000)
                    end
    end
    if inventory.itemcount >= inventory.slotcount then
        GonWebhook("There is no bp left Disocnnecting... ["..bot.name .. "]")
        bot:disconnect()
        error("yer kalmadi amina koim")
    end

    for _, itemid in ipairs(items_to_pickup) do
        local item = inventory:getItem(itemid)
        if item == nil or item.count == nil or item.count == 0 then
            if object_count_scan(itemid) > 0 then
                goto yeniden_x
            end
            GonWebhook("There is no item left in save world Waiting [60 sec...]... ["..bot.name .. "] [" .. getInfo(itemid).name .."]")
            sleep(60 * 1000 )
            goto yeniden_x
            error("item kalmadi amina koim")
            --bot:findPath(math.floor(object.x / 32) - 1,math.floor(object.y / 32))
          
        
        end
    end
    
    for _, itemid in ipairs(items_to_pickup) do
        local item = inventory:getItem(itemid)
        if item ~= nil and item.count ~= nil and item.count > 1 then
            drop(item.id,item.count - 1)
        end
    end
    local tl_world = 0
   if worlds_done > 0 then
    tl_world = math.floor(((worlds_done * clear_world_fiyat) / 100) * dl_fiyat)
   end
    GonWebhook(
        "Save World Information\n"..
        bot_data() ..
        icons["wl"].." World Lock Count: "..object_count_scan(242).. "\n" ..
        icons["signal_jam"].." Signal Jammer Count: "..object_count_scan(226).. "\n" ..
        icons["blast"].." Under Sea Blast Count: "..object_count_scan(1532).. "\n" ..
        icons["clock"].." Uptime Bot: "..SecondTT(os.difftime(os.time(), startT)) .."\n" ..
        icons["dirt"].." Total Worlds done: "..worlds_done .. "["..tl_world .. "TL]"
    )
end
local function handle_water_area(x,y)
    print("::::HANDLE WATER AREA [".. x .. "," .. "y".."]::::")
    local posses = {
       {-2,-2},
       {-1,-2},
       {0,-2},
       {1,-2},
       {2,-2},

       {-2,-1},
       {-1,-1},
       {0,-1},
       {1,-1},
       {2,-1},

       {-2,0},
       {-1,0},
       {0,0},
       {1,0},
       {2,0},

       {-2,1},
       {-1,1},
       {0,1},
       {1,1},
       {2,1},

       {-2,2},
       {-1,2},
       {0,2},
       {1,2},
       {2,2}

    }
    for _, pos in pairs(posses) do
        if string.upper(current_world) ~= world.name then
            safe_wrap(current_world,nil)
            sleep(500)
        end
        AnlikYer()
        local item = inventory:getItem(822)
            if item == nil or item.count == nil or item.count == 0 then
                saveden_item_al()
                sleep(500)
                safe_wrap(world_name,nil)
                sleep(500)
            end
        while math.floor(getLocalSafe().posx / 32) ~= x or math.floor(getLocalSafe().posy / 32) ~= y do
            bot:findPath(x,y)
            sleep(40)
        end
        local rel_pos = {pos[1] + x,pos[2] + y}
        if water_var_mi(rel_pos[1],rel_pos[2]) then
            local item = inventory:getItem(822)
            if item ~= nil and item.count ~= nil and item.count >= 199 then
                water_save()
            end
            collect_water(rel_pos[1],rel_pos[2])
            sleep(50)
            
        end
    end
end


local function generateRandomString(length,nn)
    local charset

    if nn then
        charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    else
        charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    end
    local str = ""

    for i = 1, length do
        local randomIndex = math.random(1, #charset)
        str = str .. string.sub(charset, randomIndex, randomIndex)
    end

    return str
end

local function blast_kullan()
    bot:say("Script By .yerelmasi ")
    ::retry::
    AnlikYer()
    local generated_world = generateRandomString(8,false)
    bot:use(1532)
    addEvent(Event.variantlist, function(variant, netid)
        local tip = variant:get(0):getString()
        if tip == "OnDialogRequest" then
             bot:sendPacket(2,"action|dialog_return\ndialog_name|terraformer_reply\nitemID|1532|\nworldname|" .. generated_world)
        end
    end)
    listenEvents(6)
    removeEvent(Event.variantlist)
    if not bot:isInWorld(string.upper(generated_world)) then
        local item = inventory:getItem(1532)
        if item == nil or item.count == nil or item.count == 0 then
            safe_wrap(generated_world,nil)
            return            
        end
        
        generated_world = generateRandomString(8,false)
        goto retry
    end
end
local function place_safe(x,y,id)
    AnlikYer()
    while getTileSafe(x,y).fg == 0 do
        bot:place(x,y,id)
        sleep(punch_delay)
    end
end

local function main()
    local firstscan = true
    while true do
        ::tyogay::
        AnlikYer()
    bot.auto_collect = false
    saveden_item_al()
    if firstscan then
        local eski_world = get_last_world()
        if eski_world == "EXIT" then
            blast_kullan()
        else
            safe_wrap(eski_world)
            eski_worldi_yapion = true
        end
        
    else
        blast_kullan()
    end
    firstscan = false
    
       
    

    
   
    current_world = world.name
    local gacha_obj = nil
    world_start_time = os.time()
    

    bot.auto_collect = true
    left = true
    world_name = world.name
    olamam_gereken_world_id = world_name
    white_door_pos = get_white_door_pos()
    break_pos = white_door_pos
    if world.name == "EXIT" then
        goto tyogay
    end
    
    if  world:hasAccess(0,0) == 0 then
        bot:say("OROSPU COCUGU")
        goto tyogay
    end
    if not eski_worldi_yapion then
        appendLog(world.name .. "\n")
    end
    
    break_tile(math.floor(getLocalSafe().posx / 32),math.floor(getLocalSafe().posy / 32) - 1)
    sleep(100)
    break_tile(math.floor(getLocalSafe().posx / 32) - 1,math.floor(getLocalSafe().posy / 32) - 1)
    sleep(100)
    place_safe(math.floor(getLocalSafe().posx / 32),math.floor(getLocalSafe().posy / 32) - 1,242)
    sleep(500)
    place_safe(math.floor(getLocalSafe().posx / 32) - 1,math.floor(getLocalSafe().posy / 32) - 1,226)
    sleep(500)
    bot:hit(math.floor(getLocalSafe().posx / 32) - 1,math.floor(getLocalSafe().posy / 32) - 1)
    sleep(100)
    if not eski_worldi_yapion then
        for i = 1, 10, 1 do
            gacha_obj = world:getObjects()[1]
            sleep(100)
        end
    else
        gacha_obj = {id=112}
    end
    eski_worldi_yapion = false
    
    
    
    local tl_world = 0
   if worlds_done > 0 then
    tl_world = math.floor(((worlds_done * clear_world_fiyat) / 100) * dl_fiyat)
   end
   local gacha_str 
   if gacha_obj == nil then
    gacha_str = "NOT FOUND WTF"
   else
    if gacha_obj.id ~= nil then
        local info = getInfo(gacha_obj.id)
        if info == nil then
            gacha_str = "APP ISSUE"
        else
            gacha_str = info.name
        end
        
    else
        gacha_str = "NOT FOUND WTF"
    end
    
   end
   
    GonWebhook(
        "Starting Clear world\n"..
        bot_data() ..
        icons["clock"].." Uptime Bot: "..SecondTT(os.difftime(os.time(), startT)) .."\n" ..
        icons["wl"] .. "Gacha item: ".. gacha_str  .. "\n" ..
        icons["dirt"].." Total Worlds done: "..worlds_done .. "["..tl_world .. "TL]"
    )
    sol_taraf_kir()
    sag_taraf_kir()
    yukari_kir()
    world_kir()
    scan_x = 2
        scan_y = 2
        sleep(5000)
        bot:say("Su toplama basladi")
        local tl_world = 0
   if worlds_done > 0 then
    tl_world = math.floor(((worlds_done * clear_world_fiyat) / 100) * dl_fiyat)
   end
        GonWebhook(
        "Starting Collecting water\n"..
        bot_data() ..
        icons["clock"].." Uptime Bot: "..SecondTT(os.difftime(os.time(), startT)) .."\n" ..
        icons["dirt"].." Total Worlds done: "..worlds_done .. "["..tl_world .. "TL]"
    )
    while true do
        
        if water_var_mi(scan_x,scan_y) then 
            bot:findPath(scan_x,scan_y)
        sleep(40)
        for i = 0, 3 do
            handle_water_area(scan_x,scan_y)
            yuzde = ((water_count() - 3) / max_su) * 100

            sleep(10)
        end
        end
        
        
        if left then
            scan_x = scan_x + 5
        else
            scan_x = scan_x - 5
        end
        
        if scan_x > 99 then
            scan_x = 97
            scan_y = scan_y + 5
            left = false
        end
        if scan_x < 0 then
            scan_x = 2
            scan_y = scan_y + 5
            left = true
        end
        if scan_y > 53 then
            break
        end
        
        if getTileSafe(scan_x,scan_y).fg ~= 0 then
            if getTileSafe(scan_x + 1,scan_y).fg ~= 0 then
                scan_x = scan_x + 2
            else
            scan_x = scan_x + 1
            end
        end
    end
    
    for y = 0, 59 do
        for x = 0, 99 do
           if water_var_mi(x,y) and not isInArray(getTileSafe(x,y).fg,ignore_list) then
            --bot:findPath(x,y)
            sleep(50)
            for i = 0, 3 do
                handle_water_area(x,y)
                sleep(100)
            end
            
           end
        end
    end
    if break_sj then
    bot:findPath(white_door_pos[1],white_door_pos[2])
    break_pos = {white_door_pos[1],white_door_pos[2]}
    break_tile(math.floor(getLocalSafe().posx / 32) - 1,math.floor(getLocalSafe().posy / 32) - 1)
    sleep(100)
    end
    worlds_done = worlds_done + 1
    local tl_world = 0
   if worlds_done > 0 then
    tl_world = math.floor(((worlds_done * clear_world_fiyat) / 100) * dl_fiyat)
   end
    GonWebhook(
        "World Done\n"..
        bot_data() ..
        icons["clock"].." World Done in: "..SecondTT(os.difftime(os.time(), world_start_time)) .."\n" ..
        icons["clock"].." Uptime Bot: "..SecondTT(os.difftime(os.time(), startT)) .."\n" ..
        icons["dirt"].." Total Worlds done: "..worlds_done .. "["..tl_world .. "TL]"
    )
    
    sleep(60 * 1000)
end
end
main()





