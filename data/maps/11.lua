local map = ...

-- Shop

function map:on_started(destination_point)
   -- make the NPCs walk
   random_walk("lady_a")
end

function random_walk(npc_name)
   local m = sol.main.random_path_movement_create(32)
   sol.map.npc_start_movement(npc_name, m)
   sol.map.npc_get_sprite(npc_name):set_animation("walking")
end
