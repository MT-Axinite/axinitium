-- Axinite Biome

axinitium.mg = {}
axinitium.mg.path = minetest.get_modpath("axinitium")

minetest.register_biome({
    name             = "axinite",
    node_top         = "axinitium:dirt",
    depth_top        = 1,
    node_filler      = "default:dirt",
    depth_filler     = 2,
	y_min       = 70,
	y_max       = 70,
	heat_point       = 55.0,
	humidity_point   = 185.0,
})

-- Register Biome Decoration
local path = minetest.get_modpath("axinitium")

minetest.register_decoration({
    deco_type = "simple",
    place_on = "axinitium:dirt",
    sidelen = 16,
    fill_ratio = 0.0008,
    biomes = {"axinite"},
    decoration = "axinitium:crystal_ore1",
--  height = 2,
    height_max = 1,
})

-- axinitium tree
minetest.register_decoration({
    deco_type = "schematic",
    place_on = "axinitium:dirt",
    sidelen = 16,
    fill_ratio = 0.01,
    biomes = {"axinite"},
    schematic = path.."/schematics/tree.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
})

-- Small Lava Crater -- from ethereal lava pits
minetest.register_decoration({
    deco_type = "schematic",
    place_on = "axinitium:dirt",
    sidelen = 16,
    fill_ratio = 0.002,
    biomes = {"axinite"},
    schematic = path.."/schematics/volcan.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
})
