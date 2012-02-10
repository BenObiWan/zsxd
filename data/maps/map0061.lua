-- Temple of Stupidities 1F NE

cannonballs_enabled = false
remove_water_delay = 500 -- delay between each step when some water is disappearing

-- initialization
function event_map_started(destination_point_name)

  -- miniboss door
  sol.map.door_set_open("miniboss_door", true)

  -- water drained
  if sol.game.savegame_get_boolean(303) then
    sol.map.tile_set_group_enabled("c_water", false)
    sol.map.tile_set_enabled("c_water_exit", true)
    sol.map.switch_set_activated("remove_water_switch", true)
  end
end

-- weak walls: play the secret sound
function event_door_open(door_name)

  if door_name == "weak_wall_compass"
      or door_name == "weak_wall_red_tunic" then
    sol.main.play_sound("secret")
  end
end

-- dialog near the WTF room
function event_treasure_obtained(item_name, variant, savegame_variable)

  if savegame_variable == 248 then
    sol.map.dialog_start("small_key_danger_east")
  end
end

-- random cannonballs
nb_cannonballs_created = 0
function launch_cannonball()

  sol.main.timer_start(1500, "launch_cannonball", false)
  nb_cannonballs_created = nb_cannonballs_created + 1
  sol.map.enemy_create("cannonball_"..nb_cannonballs_created, "cannonball", 0, 280, 725)
end

-- miniboss
fighting_miniboss = false
function event_hero_on_sensor(sensor_name)

  if string.match(sensor_name, "^cannonballs_start_sensor") and not cannonballs_enabled then
    launch_cannonball()
    cannonballs_enabled = true
  elseif string.match(sensor_name, "^cannonballs_stop_sensor") and cannonballs_enabled then
    sol.main.timer_stop("launch_cannonball")
    cannonballs_enabled = false
  elseif sensor_name == "start_miniboss_sensor" and not sol.game.savegame_get_boolean(302)
     and not fighting_miniboss then
    -- the miniboss is alive
    sol.map.door_close("miniboss_door")
    sol.map.hero_freeze()
    sol.main.timer_start(1000, "miniboss_timer", false)
    fighting_miniboss = true
  end
end

function miniboss_timer()
  sol.main.play_music("boss.spc")
  sol.map.enemy_set_enabled("miniboss", true)
  sol.map.hero_unfreeze()
end

function event_enemy_dead(enemy_name)

  if enemy_name == "miniboss" then
    sol.main.play_music("dark_world_dungeon.spc")
    sol.map.door_open("miniboss_door")
  end
end

-- draining the water
function event_switch_activated(switch_name)

  if switch_name == "remove_water_switch"
    and not sol.game.savegame_get_boolean(303) then
    sol.map.hero_freeze()
    remove_c_water()
  end
end

function remove_c_water()
  sol.main.play_sound("water_drain_begin")
  sol.main.play_sound("water_drain")
  sol.map.tile_set_enabled("c_water_exit", true)
  sol.map.tile_set_enabled("c_water_source", false)
  sol.main.timer_start(remove_water_delay, "remove_c_water_2", false)
end

function remove_c_water_2()
  sol.map.tile_set_enabled("c_water_middle", false)
  sol.main.timer_start(remove_water_delay, "remove_c_water_3", false)
end

function remove_c_water_3()
  sol.map.tile_set_group_enabled("c_water_initial", false)
  sol.map.tile_set_group_enabled("c_water_less_a", true)
  sol.main.timer_start(remove_water_delay, "remove_c_water_4", false)
end

function remove_c_water_4()
  sol.map.tile_set_group_enabled("c_water_less_a", false)
  sol.map.tile_set_group_enabled("c_water_less_b", true)
  sol.main.timer_start(remove_water_delay, "remove_c_water_5", false)
end

function remove_c_water_5()
  sol.map.tile_set_group_enabled("c_water_less_b", false)
  sol.map.tile_set_group_enabled("c_water_less_c", true)
  sol.main.timer_start(remove_water_delay, "remove_c_water_6", false)
end

function remove_c_water_6()
  sol.map.tile_set_group_enabled("c_water_less_c", false)
  sol.game.savegame_set_boolean(303, true)
  sol.main.play_sound("secret")
  sol.map.hero_unfreeze()
end

