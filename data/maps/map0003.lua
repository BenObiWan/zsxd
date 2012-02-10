------------------------------
-- Outside fields SO script --
------------------------------

-- Function called when the map starts.
-- The NPCs are initialized.
function event_map_started(destination_point_name)
   -- make the NPCs walk
   -- random_run("forest_monkey")
end

function random_run(npc_name)
   m = sol.main.random_path_movement_create(128)
   sol.map.npc_start_movement(npc_name, m)
   sol.main.sprite_set_animation(sol.map.npc_get_sprite(npc_name), "walking")
end


-- Function called when the player wants to talk to a non-playing character.
-- If the NPC is the guard, then the dialog starts.
function event_npc_dialog(npc_name)
  if string.find(npc_name, "guard") then
    if sol.map.hero_get_direction() == 0 then
      sol.map.dialog_start("outside_fields_SO_guard_ok")
    else
      sol.map.dialog_start("outside_fields_SO_guard_nok")
    end
  elseif string.find(npc_name, "forest_monkey") then
    sol.map.dialog_start("outside_fields_SO_forest_monkey_give_boots")
  end
end

-- Function called when the dialog box is being closed.
-- If the player was talking to the guard, we do the appropriate action
function event_dialog_finished(first_message_id, answer)
   if first_message_id == "outside_fields_SO_guard_ok" then
      -- make the guard move
      m = sol.main.path_movement_create("000000000066", 24)
      s = sol.map.npc_get_sprite("guard")
      sol.main.sprite_set_animation(s, "walking")
      sol.map.npc_start_movement("guard", m)
  end
end

function event_chest_empty(chest_name)
   if chest_name == "chest_link_house" then
    sol.map.dialog_start("outside_fields_SO_chest_link_house")
    sol.map.hero_unfreeze()
  end
end
