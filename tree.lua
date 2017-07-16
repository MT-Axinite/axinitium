local S = axinitium.intllib

-- Axinite tree
minetest.register_node("axinitium:sapling", {
	description = "Axinitium Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"sapling.png"},
	inventory_image = "sapling.png",
	wield_image = "sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1, axinite_sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
	grown_height = 8,
})

minetest.register_node("axinitium:tree", {
	description = "Axinitium Tree",
	tiles = {"tree_top.png", "tree_top.png", "tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("axinitium:wood", {
	description = "Axinitium Wooden Planks",
	tiles = {"wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("axinitium:leaves", {
	description = "Axinitium Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"leaves.png"},
	special_tiles = {"leaves_simple.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'axinitium:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'axinitium:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})

minetest.register_node("axinitium:apple", {
	description = "Axinitium Apple",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"apple.png"},
	inventory_image = "apple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups =
	{fleshy = 3, dig_immediate = 3, flammable = 2,leafdecay = 3, leafdecay_drop = 1, leaves = 1, attached_node=1 },
	on_use = function(itemstack, user, pointed_thing)
		local name = user:get_player_name()
		local h = tonumber(hbhunger.hunger[name])
		if h > 0 then
			h = h-5
			if h < 0 then
				h = 0
			end
			hbhunger.hunger[name] = h
			hbhunger.set_hunger(user)
			mana.add_up_to(user:get_player_name(), 10)
		end
		itemstack:take_item()
		return itemstack
	end,
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name = "axinitium:apple", param2 = 1})
		end
	end,
})

default.register_fence("axinitium:fence_wood", {
	description = "Axinitium Fence",
	texture = "fence_wood.png",
	material = "axinitium:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})


default.register_leafdecay({
	 trunks = {"axinitium:tree"},
	 leaves = {"axinitium:apple", "axinitium:leaves"},
	 radius = 3,
})
