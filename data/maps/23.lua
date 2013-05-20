local map = ...

----------------------------------
-- Crazy House 2FB (north)      --
----------------------------------

local guichet82_sprite

function map:on_map_started(destination_point)

  guichet82_sprite = sol.map.npc_get_sprite("GC82")
end

-- Guichet 82 -------------------------------------------------
function guichet_82()

  map:start_dialog("crazy_house.guichet_82")
  -- Incrémentation branche 1412
  local branche1412 = sol.game.savegame_get_integer(1412)
  if branche1412 > 0 and branche1412 <= 2 then
    sol.game.savegame_set_integer(1412, 3)
  end
end

-- Guichet 84 -------------------------------------------------
function guichet_84()

  if sol.game.savegame_get_integer(1410) == 3 then
    map:start_dialog("crazy_house.guichet_84_ech_eq_3")
  else
    if sol.game.get_item_amount("hache_counter") >= 1 then
      map:start_dialog("crazy_house.guichet_84_ech_ne_3_hh")
    else
      map:start_dialog("crazy_house.guichet_84_ech_ne_3_nh")
    end
  end
end

function map:on_npc_interaction(npc_name)
  if npc_name == "GC82" then
    guichet_82()
  elseif npc_name == "GC82Front" then
    guichet82_sprite:set_direction(3)
    guichet_82()
  elseif npc_name == "GC84" then
    guichet_84()
  end
end

function map:on_dialog_finished(dialog_id, answer)

  if dialog_id == "crazy_house.guichet_82" then
    -- Choix de réponse au guichet 82
    if answer == 0 then
      -- Contrôle de la quantité
      if sol.game.get_item_amount("sac_olive_counter") < 1 then
        sol.main.play_sound("wrong")
        map:start_dialog("crazy_house.guichet_82_un")
      else
        map:start_dialog("crazy_house.guichet_82_ok")
      end
    end
  elseif dialog_id == "crazy_house.guichet_82_ok" then
    -- Obtention du roc magma au guichet 82
    sol.map.treasure_give("roc_magma", 1, -1)
    sol.game.remove_item_amount("sac_olive_counter", 1)
  elseif dialog_id == "crazy_house.guichet_84_ech_ne_3_hh" then
    -- Choix de réponse au guichet 84
    if answer == 0 then
      -- Contrôle de la quantité
      if sol.game.get_item_amount("hache_counter") < 1 then
        sol.main.play_sound("wrong")
        map:start_dialog("crazy_house.guichet_84_ech_ne_3_un")
      else
        sol.map.treasure_give("poivron", 1, -1)
        sol.game.remove_item_amount("hache_counter", 1)
        -- Incrémentation branche 1411
        local branche1411 = sol.game.savegame_get_integer(1411)
        if branche1411 > 0 and branche1411 <= 7 then
          sol.game.savegame_set_integer(1411, 8)
        end
      end
    end
  end
end

