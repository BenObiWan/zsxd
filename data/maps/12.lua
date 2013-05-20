local map = ...

-- Link's cave

function map:on_map_started(destination_point)

  sol.map.enemy_set_enabled("zelda_enemy", false)
  sol.map.door_set_open("door", true)
end

function map:on_treasure_obtained(item_name, variant, savegame_variable)

  if item_name == "zelda" then
    sol.main.play_music("boss.spc")
    sol.map.npc_set_position("zelda", 224, 85)
    sol.map.hero_freeze()
    sol.main.timer_start(angry_zelda, 1000)
    sol.game.add_life(80)
  end
end

function angry_zelda()

  map:start_dialog("link_cave.angry_zelda")
end

function map:on_dialog_finished(dialog_id)

  if dialog_id == "link_cave.angry_zelda" then

    local m = sol.main.jump_movement_create(6, 24)
    m:set_property("ignore_obstacles", true)
    m:set_property("speed", 48)
    sol.map.npc_start_movement("zelda", m)

    local zelda_sprite = sol.map.npc_get_sprite("zelda")
    zelda_sprite:set_animation("walking")

    sol.map.door_close("door")
  end
end

function map:on_npc_movement_finished(npc_name)

  if npc_name == "zelda" then
    sol.map.npc_set_position("zelda", -100, -100) -- disable the NPC
    local x, y = sol.map.npc_get_position("zelda")
    sol.map.hero_unfreeze()
    sol.map.enemy_set_enabled("zelda_enemy", true) -- enable the enemy
  end
end

function map:on_update()

  if not sol.map.door_is_open("door") and sol.game.get_life() <= 4 then
    -- go to the end screen
    sol.map.hero_set_map(17, "start_position", 1)
  end
end

