-- Zelda

function event_appear()

  sol.enemy.set_life(100)
  sol.enemy.set_damage(8)
  sol.enemy.create_sprite("enemies/zelda")
  sol.enemy.set_size(16, 16)
  sol.enemy.set_origin(8, 13)
  sol.enemy.set_invincible()
end

function event_restart()

  local m = sol.main.path_finding_movement_create(64)
  sol.enemy.start_movement(m)
end

function event_movement_changed()

  local m = sol.enemy.get_movement()
  local direction4 = m:get_property("displayed_direction")
  local sprite = sol.enemy.get_sprite()
  sprite:set_direction(direction4)
end

