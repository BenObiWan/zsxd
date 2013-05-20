local map = ...

----------------------------------
-- Crazy House 2FA (south)      --
----------------------------------

local locked_door_A_value = 0

function event_map_started(destination_point_name)

  -- Interrupteurs
  if sol.game.savegame_get_boolean(127) then
    sol.map.switch_set_activated("locked_door_switch_A", true)
    sol.map.switch_set_activated("locked_door_switch_B", true)
  end
end

-- Vieillard --------------------------------------------------
function vieillard()

  if sol.game.savegame_get_integer(1411) >= 1 then
    if sol.game.savegame_get_boolean(124) == false then
      -- Première rencontre
      sol.map.dialog_start("crazy_house.vieillard")
      sol.game.savegame_set_boolean(124, true)
    else
      if sol.game.savegame_get_boolean(125) == false then
        -- Vieillard n'a pas encore changé d'avis
        if sol.game.get_item_amount("poivron_counter") < 1 then
          -- N'a pas encore de poivron
          sol.map.dialog_start("crazy_house.vieillard")
        else
          -- A le poivron
          sol.map.dialog_start("crazy_house.vieillard_poivron")
          -- Changement d'avis
          sol.game.savegame_set_boolean(125, true)
        end
        -- Incrémentation branche 1411
        local branche1411 = sol.game.savegame_get_integer(1411)
        if branche1411 > 0 and branche1411 <= 1 then
          sol.game.savegame_set_integer(1411, 2)
        end
      else
        -- Vieillard veut du riz maintenant !
        if sol.game.get_item_amount("sac_riz_counter") < 1 then
          sol.map.dialog_start("crazy_house.vieillard_riz_quantite")
        else
          -- A le sac de riz
          sol.map.dialog_start("crazy_house.vieillard_riz_ok")
        end
        -- Incrémentation branche 1411
        local branche1411 = sol.game.savegame_get_integer(1411)
        if branche1411 > 0 and branche1411 <= 8 then
          sol.game.savegame_set_integer(1411, 9)
        end
      end
    end
  else
    sol.map.dialog_start("crazy_house.vieillard_ronfl")
  end
end

-- Guichet 21 -------------------------------------------------
function guichet_21()

  if sol.game.savegame_get_integer(1410) == 1 then
    sol.map.dialog_start("crazy_house.guichet_21_ech_eq_1")
    sol.game.savegame_set_integer(1410, 2)
  else
    sol.map.dialog_start("crazy_house.guichet_21_ech_ne_1")
  end
end

-- Guichet 22A -------------------------------------------------
function guichet_22A()

  sol.map.dialog_start("crazy_house.guichet_22A")
  -- Incrémentation branche 1412
  local branche1412 = sol.game.savegame_get_integer(1412)
  if branche1412 > 0 and branche1412 <= 1 then
    sol.game.savegame_set_integer(1412, 2)
  end
end

-- Guichet 22B -------------------------------------------------
function guichet_22B()

  sol.map.dialog_start("crazy_house.guichet_22B")
  -- Incrémentation branche 1411
  local branche1411 = sol.game.savegame_get_integer(1411)
  if branche1411 > 0 and branche1411 <= 3 then
    sol.game.savegame_set_integer(1411, 4)
  end
  -- Incrémentation branche 1412
  local branche1412 = sol.game.savegame_get_integer(1412)
  if branche1412 == 6 then
    sol.game.savegame_set_integer(1412, 7)
  end
end

-- Interactions avec capteur pour guichet (devanture) ou NPC
function event_npc_interaction(npc_name)

  if npc_name == "GC21front" then
    guichet_21()
  elseif npc_name == "GC22A" then
    guichet_22A()
  elseif npc_name == "GC22B" then
    guichet_22B()
  elseif npc_name == "Vieillard" then
    vieillard()
  elseif npc_name == "GC21" then
    guichet_21()
  end
end

function event_dialog_finished(dialog_id, answer)

  if dialog_id == "crazy_house.vieillard_riz_ok" then
    sol.map.treasure_give("bocal_epice", 1, -1)
    sol.game.remove_item_amount("sac_riz_counter", 1)
    -- branche 1411 finie
    if sol.game.get_item_amount("balai_counter") > 0 then
      sol.game.savegame_set_integer(1410, 9)
    end
    sol.game.savegame_set_integer(1411, 10)
  elseif dialog_id == "crazy_house.guichet_22A" then
    if answer == 0 then
      if sol.game.get_item_amount("roc_magma_counter") < 1 then
        sol.main.play_sound("wrong")
        sol.map.dialog_start("crazy_house.guichet_22_rm_un")
      else
        sol.map.dialog_start("crazy_house.guichet_22_rm_ok")
      end
    end
  elseif dialog_id == "crazy_house.guichet_22B" then
    if answer == 0 then
      if sol.game.get_item_amount("sac_riz_counter") < 1 then
        sol.main.play_sound("wrong")
        sol.map.dialog_start("crazy_house.guichet_22_sr_un")
      else
        sol.map.dialog_start("crazy_house.guichet_22_sr_ok")
      end
    end
  elseif dialog_id == "crazy_house.guichet_22_rm_ok" then
    sol.map.treasure_give("balai", 1, -1)
    sol.game.remove_item_amount("roc_magma_counter", 1)
    -- branche 1412 finie
    if sol.game.get_item_amount("bocal_epice_counter") > 0 then
      sol.game.savegame_set_integer(1410, 9)
    end
  elseif dialog_id == "crazy_house.guichet_22_sr_ok" then
    sol.map.treasure_give("tapisserie", 1, -1)
    sol.game.remove_item_amount("sac_riz_counter", 1)
    -- Incrémentation branche 1411
    local branche1411 = sol.game.savegame_get_integer(1411)
    if branche1411 > 0 and branche1411 <= 5 then
      sol.game.savegame_set_integer(1411, 6)
    end
    -- Incrémentation branche 1412
    local branche1412 = sol.game.savegame_get_integer(1412)
    if branche1412 >= 6 and branche1412 <= 8 then
      sol.game.savegame_set_integer(1412, 9)
    end
  end
end

function event_hero_on_sensor(sensor_name)

  -- Mécanisme du coffre farceur dans la salle aux trois portes        
  if sensor_name == "prankster_sensor_top" or sensor_name == "prankster_sensor_bottom" then
    sol.map.npc_set_position("prankster_chest", 440, 509)
  elseif sensor_name == "prankster_sensor_middle" then
    sol.map.npc_set_position("prankster_chest", 360, 509)
  end
end

function event_switch_activated(switch_name)

  -- Mécanisme de la porte qui s'ouvre grâce à deux boutons
  -- dans la salle aux trois portes
  if switch_name == "locked_door_switch_A"
    or switch_name == "locked_door_switch_B" then
    if locked_door_A_value < 2 then
      locked_door_A_value = locked_door_A_value + 1
      if locked_door_A_value == 2 and not sol.map.door_is_open("LD1") then
        sol.map.door_open("LD1")
        sol.main.play_sound("secret")
      end
    end
  end
end

function event_door_open(door_name)

  if door_name == "WW2" then
    sol.main.play_sound("secret")
  end
end

