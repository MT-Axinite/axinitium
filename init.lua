axinitium = {}

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

axinitium.intllib = S

local path = minetest.get_modpath("axinitium")

-- Adds extra damage on eating (uncomment to activate)
--hbhunger.register_food("axinitium:apple", 1, "", 1)

-- Protection Check
function axinitium.check_protection(pos, name, text)
    if minetest.is_protected(pos, name) then
        minetest.log("action", (name ~= "" and name or "A mod")
            .. " tried to " .. text .. " at protected position "
            .. minetest.pos_to_string(pos) .. " with an axinite bucket")
        minetest.record_protection_violation(pos, name)
        return true
    end
    return false
end

-- Axinite crystal growth
function grow_crystal(pos, node)
	local pos1 = {x = pos.x, y = pos.y-1, z = pos.z}
	local name = minetest.get_node(pos1).name
	if name ~= "axinitium:dirt" then
		return
	end
	local pos_sw = {x = pos.x-1, y = pos.y-1, z = pos.z-1}
	local pos_ne = {x = pos.x+1, y = pos.y-1, z = pos.z+1}
  --  le type de node que l'on consomme a chaque poussée
	local consomme = {"default:bronzeblock"}
  local consumernodes = minetest.find_nodes_in_area(
		pos_sw,
		pos_ne,
		consomme
	)
	local axinitiumnodes = minetest.find_nodes_in_area(
		pos_sw,
		pos_ne,
		{"axinitium:source","axinitium:flowing"}
	)
	if #axinitiumnodes < 2 or #consumernodes < 1 then
		return
	end

	if node.name == "axinitium:crystal_ore3" then
		node.name = "axinitium:crystal_ore4"
		minetest.swap_node(pos, node)
	elseif node.name == "axinitium:crystal_ore2" then
		node.name = "axinitium:crystal_ore3"
		minetest.swap_node(pos, node)
	elseif node.name == "axinitium:crystal_ore1" then
		node.name = "axinitium:crystal_ore2"
		minetest.swap_node(pos, node)
	end

	local consumepos = consumernodes[math.random(1,#consumernodes)]
	minetest.swap_node( consumepos, {name="air"} )
end

-- Axinite tree
local add_tree = function (pos, ofx, ofy, ofz, schem)
	-- check for schematic
	if not schem then
		print ("Schematic not found")
		return
	end
	-- remove sapling and place schematic
	minetest.swap_node(pos, {name = "air"})
	minetest.place_schematic(
		{x = pos.x - ofx, y = pos.y - ofy, z = pos.z - ofz},
		schem, 0, nil, false)
end

function grow_axinitium_tree(pos)
	add_tree(pos, 2, 1, 2, path .. "/schematics/tree.mts")
end

-- check if sapling has enough height room to grow
local function enough_height(pos, height)
	local nod = minetest.line_of_sight(
		{x = pos.x, y = pos.y + 1, z = pos.z},
		{x = pos.x, y = pos.y + height, z = pos.z})
	if not nod then
		return false -- obstructed
	else
		return true -- can grow
	end
end

local grow_sapling = function (pos, node)
	local under =  minetest.get_node({
		x = pos.x,
		y = pos.y - 1,
		z = pos.z
	}).name

	if not minetest.registered_nodes[node.name] then
		return
	end

	local height = minetest.registered_nodes[node.name].grown_height

	-- do we have enough height to grow sapling into tree?
	if not height or not enough_height(pos, height) then
		return
	end

		-- Check if Axinitium Sapling is growing on correct substrate
		if node.name == "axinitium:sapling"
		and under == "axinitium:dirt" then
			grow_axinitium_tree(pos)
		end
end

-- Grow saplings
minetest.register_abm({
	label = "Axinitium grow sapling",
	nodenames = {"group:axinitium_sapling"},
	interval = 20,
	chance = 8,
	catch_up = false,
	action = function(pos, node)
		local light_level = minetest.get_node_light(pos)
		if not light_level or light_level < 13 then
			return
		end
		grow_sapling(pos, node)
	end,
})

-- Grow axinitium crystal
minetest.register_abm({
	nodenames = {"axinitium:crystal_ore1", "axinitium:crystal_ore2",
		"axinitium:crystal_ore3"},
	neighbors = {"axinitium:dirt", "axinitium:source"},
	interval = 20,
	chance = 8,
	action = function(...)
		grow_crystal(...)
	end
})

dofile(path.."/mapgen.lua")
dofile(path.."/nodes.lua")
dofile(path.."/crafts.lua")
dofile(path.."/liquids.lua")
dofile(path.."/tree.lua")
dofile(path.."/items.lua")
dofile(path.."/tools.lua")
dofile(path.."/armor.lua")
dofile(path.."/arrow.lua")
