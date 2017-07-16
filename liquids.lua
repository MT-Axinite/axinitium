
axinitium.liquids = {}

-- Register a new liquid
--    source = name of the source node
--    flowing = name of the flowing node
--    itemname = name of the new bucket item (or nil if liquid is not takeable)
--    inventory_image = texture of the new bucket item (ignored if itemname == nil)
--    name = text description of the bucket item
--    groups = (optional) groups of the bucket item, for example {water_bucket = 1}
-- This function can be called from any mod (that depends on bucket).
function axinitium.register_liquid(source, flowing, itemname, inventory_image, name, groups)
    axinitium.liquids[source] = {
        source = source,
        flowing = flowing,
        itemname = itemname,
    }
    axinitium.liquids[flowing] = axinitium.liquids[source]

    if itemname ~= nil then
        minetest.register_craftitem(itemname, {
            description = name,
            inventory_image = inventory_image,
            stack_max = 1,
            liquids_pointable = true,
            groups = groups,
            on_place = function(itemstack, user, pointed_thing)
                -- Must be pointing to node
                if pointed_thing.type ~= "node" then
                    return
                end

                local node = minetest.get_node_or_nil(pointed_thing.under)
                local ndef
                if node then
                    ndef = minetest.registered_nodes[node.name]
                end
                -- Call on_rightclick if the pointed node defines it
                if ndef and ndef.on_rightclick and
                   user and not user:get_player_control().sneak then
                    return ndef.on_rightclick(
                        pointed_thing.under,
                        node, user,
                        itemstack) or itemstack
                end

                local place_liquid = function(pos, node, source, flowing)
                    if axinitium.check_protection(pos,
                            user and user:get_player_name() or "",
                            "place "..source) then
                        return
                    end
                    minetest.add_node(pos, {name=source})
                end

                -- Check if pointing to a buildable node
                if ndef and ndef.buildable_to then
                    -- buildable; replace the node
                    place_liquid(pointed_thing.under, node,
                            source, flowing)
                else
                    -- not buildable to; place the liquid above
                    -- check if the node above can be replaced
                    local node = minetest.get_node_or_nil(pointed_thing.above)
                    if node and minetest.registered_nodes[node.name].buildable_to then
                        place_liquid(pointed_thing.above,
                                node, source,
                                flowing)
                    else
                        -- do not remove the bucket with the liquid
                        return
                    end
                end
                return {name="axinitium:bucket_empty"}
            end
        })
    end
end

axinitium.register_liquid(
    "axinitium:source",
    "axinitium:flowing",
    "axinitium:bucket",
    "bucket.png",
    "Axinitium Bucket"
)
