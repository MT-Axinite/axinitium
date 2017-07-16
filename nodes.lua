minetest.register_alias("bucket", "axinitium:bucket_empty")
minetest.register_alias("bucket_axinite", "axinitium:bucket")
minetest.register_alias("axinitium_crystals:axinitium_crystal_seed", "axinitium:crystal_seed")
minetest.register_alias("axinitium_crystals:axinitium_crystal_ore1", "axinitium:crystal_ore1")
minetest.register_alias("axinitium_crystals:axinitium_crystal_ore2", "axinitium:crystal_ore2")
minetest.register_alias("axinitium_crystals:axinitium_crystal_ore3", "axinitium:crystal_ore3")
minetest.register_alias("axinitium_crystals:axinitium_crystal_ore4", "axinitium:crystal_ore4")
minetest.register_alias("axinitium_crystals:crystaline_bell", "axinitium:crystaline_bell")
minetest.register_alias("axinitium:axinite_flowing", "axinitium:flowing")
minetest.register_alias("axinitium:axinite_source", "axinitium:source")

--Make Axinite Ore Block spawn
minetest.register_ore({
	ore_type = "scatter",
	ore = "axinitium:ore_block",
	wherein = "default:stone",
	clust_scarcity = 19*19*19,
	clust_num_ores = 1,
	clust_size = 1,
	y_min = -8000,
	y_max = -4000,
})

-- Define Axinite_ore_block node
minetest.register_node("axinitium:ore_block", {
	description = "Axinitium",
	tiles = {"default_stone.png^ore_block.png"},
	groups = {stone=2, cracky=3},
	drop = "axinitium:ore",
	is_ground_content = true,
})

minetest.register_node("axinitium:block", {
	description = "Axinitium Block",
	tiles = {"block.png", "block.png^[transformR270", "block.png^[transformR90",
	"block.png", "block.png^[transformR270", "block.png^[transformR180"},
	light_source = LIGHT_MAX,
	groups = {cracky=1, level=3},
	sounds = default.node_sound_stone_defaults(),
})

-- Axinite Crystal
minetest.register_node("axinitium:crystal_ore1", {
	description = "Axinite Crystal Ore",
	mesh = "crystal_ore1.obj",
	tiles = {"crystal.png"},
	paramtype = "light",
	drawtype = "mesh",
	groups = {cracky = 1},
	drop = "axinitium:ore_lingot 1",
	use_texture_alpha = true,
	sounds = default.node_sound_stone_defaults(),
	light_source = 7,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
})

minetest.register_node("axinitium:crystal_ore2", {
	description = "Axinite Crystal Ore",
	mesh = "crystal_ore2.obj",
	tiles = {"crystal.png"},
	paramtype = "light",
	drawtype = "mesh",
	groups = {cracky = 1},
	drop = "axinitium:ore_lingot 2",
	use_texture_alpha = true,
	sounds = default.node_sound_stone_defaults(),
	light_source = 8,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
})

minetest.register_node("axinitium:crystal_ore3", {
	description = "Axinite Crystal Ore",
	mesh = "crystal_ore3.obj",
	tiles = {"crystal.png"},
	paramtype = "light",
	drawtype = "mesh",
	groups = {cracky = 1},
	drop = "axinitium:ore_lingot 3",
	use_texture_alpha = true,
	sounds = default.node_sound_stone_defaults(),
	light_source = 9,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
})

minetest.register_node("axinitium:crystal_ore4", {
	description = "Axinite Crystal Ore",
	mesh = "crystal_ore4.obj",
	tiles = {"crystal.png"},
	paramtype = "light",
	drawtype = "mesh",
	groups = {cracky = 1},
	drop = "axinitium:ore_ingot 4",
	use_texture_alpha = true,
	sounds = default.node_sound_stone_defaults(),
	light_source = 10,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
})

-- axinite dirt
minetest.register_node("axinitium:dirt", {
	description = "Axinite Dirt",
	tiles = {"grass.png", "default_dirt.png",
		{name = "default_dirt.png^dirt_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, ethereal_grass = 1},
	soil = {
		base = "axinitium:dirt",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

-- Axinite Source
minetest.register_node("axinitium:source", {
	description = "Axinite Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	special_tiles = {
		-- New-style lava source material (mostly unused)
		{
			name = "source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
			backface_culling = false,
		},
	},
	paramtype = "light",
	light_source = default.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "axinitium:flowing",
	liquid_alternative_source = "axinitium:source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, hot = 3, igniter = 1},
})

minetest.register_node("axinitium:flowing", {
	description = "Flowing Axinite",
	drawtype = "flowingliquid",
	tiles = {"src.png"},
	special_tiles = {
		{
			name = "flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = default.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "axinitium:flowing",
	liquid_alternative_source = "axinitium:source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, hot = 3, igniter = 1,
		not_in_creative_inventory = 1},
})
