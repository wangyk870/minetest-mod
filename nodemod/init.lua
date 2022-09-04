MAX_X = -331
MIN_X = -342
MAX_Y = 25
MIN_Y = 23
MAX_Z = -226
MIN_Z = -242

minetest.register_node("nodemod:monkey", {
    description = "monkey block",
    drawtype = "nodebox",
    paramtype = "light",
    tiles = {"monkey.png"},
    groups = {oddly_breakable_by_hand = 3}
})


local old_is_protected = minetest.is_protected

-- check for protected area, return true if protected and digger isn't on list
function minetest.is_protected(pos, digger)

    print(dump(pos))
    print(dump(digger))

    local is_in = is_inarea(pos)

    print(is_in)

    if is_in then
        print("yes")
        return true
    else
        print("no")
        return false
    end

end

function is_inarea(pos)
    local x = pos.x
    local y = pos.y
    local z = pos.z
    print("is_inarea")
    if (x >= MIN_X and x <= MAX_X and y >= MIN_Y and y <= MAX_Y and z >= MIN_Z and z <= MAX_Z) then
        return true
    else
        return false
    end
end

minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
    -- print(dump(pos))
    local x = pos.x
    local y = pos.y
    local z = pos.z
    if (x >= MIN_X and x <= MAX_X and y >= MIN_Y and y <= MAX_Y and z >= MIN_Z and z <= MAX_Z) then
        print("Is in area")
    end
end)

core.register_chatcommand("timenow", {
    func = function(name, param)
        local date = os.date("%Y-%m-%d %H:%M:%S")
        print(date)
    end
})

-- write context to local file

function gettime()
    return os.date("%Y%m%d%H%M%S")
end

local world_path = core.get_worldpath()

function save_whitelist(filename, content)
	local file, err = io.open(world_path .. "/data/" .. filename .. ".txt", "w")

	if err then return end

	file:write(content)

	file:close()
end

core.register_chatcommand("writefile", {
    func = function(name, param)
        local filename = "moddata-" .. gettime()
        content = "this is test !"
        save_whitelist(filename, content)
    end
})

-- minetest.register_globalstep(function(dtime)
--     print(dump(dtime))
-- end)

-- core.register_chatcommand("getarea", {
--     func = function(name, param)
--         local pos1 = {
--             x = -342,
--             y = 23,
--             z = -242
--         }
--         local pos2 = {
--             x = -331,
--             y = 25,
--             z = -226
--         }
--         local nodelist = minetest.get_objects_in_area(pos1, pos2)
--         print(dump(nodelist))
--     end
-- })

-- minetest.is_protected(pos, name)
--     print(dump(pos))
--     print(dump(name))
-- end