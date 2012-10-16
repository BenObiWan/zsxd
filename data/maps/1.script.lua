------------------------------
-- Outside fields NO script --
------------------------------

-- Function called when the map starts.
-- The NPCs are initialized.
function event_map_started(destination_point_name)
  -- make the NPCs walk
  random_walk("lady_b")
  random_walk("guy_a")
end

function random_walk(npc_name)
  local m = sol.main.random_path_movement_create(32)
  sol.map.npc_start_movement(npc_name, m)
  sol.map.npc_get_sprite(npc_name):set_animation("walking")
end
