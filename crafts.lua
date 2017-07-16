--Define Axinite_Pickaxe crafting recipe
minetest.register_craft({
	output = "axinitium:pickaxe",
	recipe = {
		{"axinitium:block", "axinitium:block", "axinitium:block", ""},
		{"", "default:stick", "", ""},
		{"", "default:stick", "", ""}
	}
})

--Define Axinite Axe crafting recipe
minetest.register_craft({
	output = "axinitium:axe",
	recipe = {
		{"axinitium:block", "axinitium:block", "", ""},
		{"axinitium:block", "default:stick", "", ""},
		{"", "default:stick", "", ""}
	}
})

--Define Axinite shovel crafting recipe
minetest.register_craft({
	output = "axinitium:shovel",
	recipe = {
		{"", "axinitium:block", "", ""},
		{"", "default:stick", "", ""},
		{"", "default:stick", "", ""}
	}
})

--Define Axinite sword crafting recipe
minetest.register_craft({
	output = "axinitium:sword",
	recipe = {
		{"", "axinitium:block", "", ""},
		{"", "axinitium:block", "", ""},
		{"", "default:stick", "", ""}
	}
})

--Define Axinite Block crafting recipe
minetest.register_craft({
	output = "axinitium:block",
	recipe = {
		{"axinitium:ore_ingot", "axinitium:ore_ingot", "axinitium:ore_ingot"},
		{"axinitium:ore_ingot", "axinitium:ore_ingot", "axinitium:ore_ingot"},
		{"axinitium:ore_ingot", "axinitium:ore_ingot", "axinitium:ore_ingot"}
	}
})

minetest.register_craft({
	type = "shapeless",
	output = 'axinitium:ore_ingot 9',
	recipe = {'axinitium:block'},
})

--Define Axinite_Ore Smelt Recipe
minetest.register_craft({
	type = "cooking",
	output = "axinitium:ore_ingot",
	recipe = "axinitium:ore",
	cooktime = 50,
	inventory_image = "ore.png",
})

--Define Axinite wood crafting recipe
minetest.register_craft({
	output = "axinitium:wood 4",
	recipe = {{"axinitium:tree"}},
})

--Define Axinitium crystal seed crafting recipe
minetest.register_craft({
	output = "axinitium:crystal_seed",
	recipe = {
		{'axinitium:block','axinitium:bucket','axinitium:block'},
		{'axinitium:bucket','axinitium:block','axinitium:bucket'},
		{'axinitium:block','axinitium:bucket','axinitium:block'},
	}
})

--Define crystaline_bell crafting recipe
minetest.register_craft({
	output = "axinitium:crystaline_bell",
	recipe = {
		{'nyancat:nyancat_rainbow'},
		{'default:glass'},
		{'default:stick'},
	}
})

--Define Axinite bucket crafting recipe
minetest.register_craft({
	output = 'axinitium:bucket_empty 1',
	recipe = {
		{'axinitium:block', '', 'axinitium:block'},
		{'', 'axinitium:block', ''},
	}
})
