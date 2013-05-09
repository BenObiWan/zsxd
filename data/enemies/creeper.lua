-- Creeper

local explosion_soon = false
local going_hero = false

function event_appear()

  sol.enemy.set_life(5)
  sol.enemy.set_damage(1)
  sol.enemy.create_sprite("enemies/creeper")
  sol.enemy.set_size(16, 16)
  sol.enemy.set_origin(8, 13)
  sol.enemy.set_attack_consequence("explosion", "ignored")
end

function event_restart()

  go_random()
  check_hero()
end

function check_hero()

  local distance_to_hero = sol.enemy.get_distance_to_hero()
  local near_hero = distance_to_hero < 40

  if distance_to_hero < 160 and not going_hero then
    go_hero()
  elseif distance_to_hero >= 160 and going_hero then
    go_random()
  end

  if not near_hero and distance_to_hero < 80 then
    local x, y = sol.enemy.get_position()
    local hero_x, hero_y = sol.map.hero_get_position()
    if hero_y < y and y - hero_y >= 40 then
      near_hero = true
    end
  end

  if near_hero and not explosion_soon then
    explosion_soon = true
    local sprite = sol.enemy.get_sprite()
    sprite:set_animation("hurt")
    sol.main.play_sound("creeper")
    sol.main.timer_start(explode_if_near_hero, 600)
  else
    sol.main.timer_start(check_hero, 100)
  end
end

function explode_if_near_hero()

  local distance = sol.enemy.get_distance_to_hero()
  local near_hero = distance < 70

  if not near_hero and distance < 90 then
    local x, y = sol.enemy.get_position()
    local hero_x, hero_y = sol.map.hero_get_position()
    if hero_y < y and y - hero_y >= 20 then
      near_hero = true
    end
  end

  if not near_hero then
    -- cancel the explosion
    explosion_soon = false
    sol.main.timer_start(check_hero, 400)
    local sprite = sol.enemy.get_sprite()
    sprite:set_animation("walking")
  else
    -- explode
    local x, y, layer = sol.enemy.get_position()
    sol.main.play_sound("explosion")
    sol.map.explosion_create(x, y - 16, layer)
    sol.map.explosion_create(x + 32, y - 16, layer)
    sol.map.explosion_create(x + 24, y - 40, layer)
    sol.map.explosion_create(x, y - 48, layer)
    sol.map.explosion_create(x - 24, y - 40, layer)
    sol.map.explosion_create(x - 32, y - 16, layer)
    sol.map.explosion_create(x - 24, y + 8, layer)
    sol.map.explosion_create(x, y + 16, layer)
    sol.map.explosion_create(x + 24, y + 8, layer)
    sol.map.enemy_remove(sol.enemy.get_name())
  end
end

function go_random()

  local m = sol.main.random_path_movement_create(40)
  sol.enemy.start_movement(m)
  going_hero = false
end

function go_hero()
  
  local m = sol.main.target_movement_create(40)
  sol.enemy.start_movement(m)
  going_hero = true
end

