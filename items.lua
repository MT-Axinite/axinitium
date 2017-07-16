--Define Axinite_Ore and lingot node
minetest.register_craftitem("axinitium:ore", {
	description = "Axinite ore",
	inventory_image = "ore.png",
})

minetest.register_craftitem("axinitium:ore_ingot", {
	description = "Axinitium Ingot",
	inventory_image = "ore_ingot.png",
})

--Define Axinitium_crystal_seed
minetest.register_craftitem("axinitium:crystal_seed", {
	description = "Axinite Crystal Seed",
	inventory_image = "crystal_seed.png",
	on_place = function(itemstack, user, pointed_thing)
		local growpos = minetest.get_pointed_thing_position(pointed_thing, true)
		local name = user:get_player_name()
		if pointed_thing.type ~= "node" or minetest.is_protected(growpos, name) then
			return
		end
		local pos = pointed_thing.under
		local node = minetest.get_node(pos)
		if node.name == "axinitium:dirt" then
			local pos1 = pointed_thing.above
			local node1 = minetest.get_node(pos1)
			if node1.name == "air" then
				itemstack:take_item()
				node.name = "axinitium:crystal_ore1"
				minetest.swap_node(pos1, node)
				return itemstack
			end
		end
	end,
})

--Define Axinite bucket
minetest.register_craftitem("axinitium:bucket_empty", {
    description = "Empty Axinite Bucket",
    inventory_image = "bucket_empty.png",
    stack_max = 99,
    liquids_pointable = true,
    on_use = function(itemstack, user, pointed_thing)
        -- Must be pointing to node
        if pointed_thing.type ~= "node" then
            return
        end
        -- Check if pointing to a liquid source
        local node = minetest.get_node(pointed_thing.under)
        local liquiddef = axinitium.liquids[node.name]
        local item_count = user:get_wielded_item():get_count()

        if liquiddef ~= nil
        and liquiddef.itemname ~= nil
        and node.name == liquiddef.source then
            if axinitium.check_protection(pointed_thing.under,
                    user:get_player_name(),
                    "take ".. node.name) then
                return
            end

            -- default set to return filled bucket
            local giving_back = liquiddef.itemname

            -- check if holding more than 1 empty bucket
            if item_count > 1 then

                -- if space in inventory add filled bucked, otherwise drop as item
                local inv = user:get_inventory()
                if inv:room_for_item("main", {name=liquiddef.itemname}) then
                    inv:add_item("main", liquiddef.itemname)
                else
                    local pos = user:getpos()
                    pos.y = math.floor(pos.y + 0.5)
                    core.add_item(pos, liquiddef.itemname)
                end

                -- set to return empty buckets minus 1
                giving_back = "axinitium:bucket_empty "..tostring(item_count-1)

            end

            minetest.add_node(pointed_thing.under, {name="air"})

            return ItemStack(giving_back)
        end
    end,
})
