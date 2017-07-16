--Register Axinite Pickaxe
minetest.register_tool("axinitium:pickaxe", {
	description = "Axinite Pickaxe",
	inventory_image = "pickaxe.png",
	range = 8,
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

--Register Axinite Axe
minetest.register_tool("axinitium:axe", {
	description = "Axinite Axe",
	inventory_image = "axe.png",
	range = 8,
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	}
})

--Register Axinite shovel
minetest.register_tool("axinitium:shovel", {
	description = "Axinite Shovel",
	inventory_image = "shovel.png",
	wield_image = "shovel.png^[transformR90",
	range = 8,
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

--Register Axinite sword
minetest.register_tool("axinitium:sword", {
	description = "Axinite Sword",
	inventory_image = "sword.png",
	range = 8,
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=3,
		groupcaps={
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=150, maxlevel=3},
		},
		damage_groups = {fleshy=10},
	}
})

minetest.register_tool("axinitium:crystaline_bell", {
	description = "Crystaline Bell",
	inventory_image = "crystalline_bell.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		local pos = pointed_thing.under
		local node = minetest.get_node(pos)
		local growth_stage = 0
		if node.name == "axinitium:crystal_ore4" then
			growth_stage = 4
		elseif node.name == "axinitium:crystal_ore3" then
			growth_stage = 3
		elseif node.name == "axinitium:crystal_ore2" then
			growth_stage = 2
		elseif node.name == "axinitium:crystal_ore" then
			growth_stage = 1
		end
		if growth_stage == 4 then
			node.name = "axinitium:crystal_ore3"
			minetest.swap_node(pos, node)
		elseif growth_stage == 3 then
			node.name = "axinitium:crystal_ore2"
			minetest.swap_node(pos, node)
		elseif growth_stage == 2 then
			node.name = "axinitium:crystal_ore1"
			minetest.swap_node(pos, node)
		end
		if growth_stage > 1 then
			itemstack:add_wear(65535 / 100)
			local player_inv = user:get_inventory()
			local stack = ItemStack("axinitium:ore_ingot")
			if player_inv:room_for_item("main", stack) then
				player_inv:add_item("main", stack)
			end
			return itemstack
		end
	end,
})
