local S = axinitium.intllib

local timer = 0

local function add_priv_wear(player)
	local inv = player:get_inventory()
	if inv then
		local list = inv:get_list("armor")
		for index, stack in pairs(list) do
			local name = stack:get_name()
			local wear = minetest.get_item_group(name, "privkit_use")
			if wear > 0 then
				armor:damage(player, index, stack, wear)
			end
		end
	end
end

minetest.register_tool("axinitium:boots", {
	description = S('Flying Boots'),
	inventory_image = "boots_inv.png",
	groups = {armor_feet=1, privkit_use=8000},
	armor_groups = {fleshy=5},
	on_equip = function(player, index, stack)
		local name = player:get_player_name()
		local privs = minetest.get_player_privs(name)
		--if privs.privkit then
			privs.fly = true

			if not minetest.check_player_privs(player:get_player_name(),{ban = true})
			then
				minetest.set_player_privs(name, privs)
			end
	end,
	on_unequip = function(player, index, stack)
		local name = player:get_player_name()
		local privs = minetest.get_player_privs(name)
		--if privs.privkit then
			privs.fly = nil

			if not minetest.check_player_privs(player:get_player_name(),{ban = true})
			then
				minetest.set_player_privs(name, privs)
			end

		--end
	end,
})

-- minetest.register_privilege("privkit", {
-- 	description = "Player privileges determined by privkit armor",
--	give_to_singleplayer = false,
--})

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if privs.privkit then
		privs.fly = nil
		if not minetest.check_player_privs(player:get_player_name(),{ban = true})
		then
			minetest.set_player_privs(name, privs)
		end
	end
end)

-- apply wear once every 8 seconds
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer > 8 then
		local players = minetest.get_connected_players()
		for _, player in pairs(players) do
			add_priv_wear(player)
		end
		timer = 0
	end
end)
