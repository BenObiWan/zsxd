local map = ...

----------------------------------
-- Crazy House 1FA (south)      --
----------------------------------

local guichet_11_error = false

function map:on_map_started(destination_point)

  if game:get_value("b101") then
    sol.map.switch_set_activated("CS3", true)
  else
    sol.map.chest_set_enabled("CK3", false)
  end

  -- Guichetière 12B partie en pause
  if game:get_value("i1410") == 5
      or game:get_value("i1410") == 6 then
    sol.map.npc_remove("GC12BPerson")
    sol.map.npc_remove("GC12B")
  end
end

function map:on_map_opening_transition_finished(destination_point)

  -- Affichage du nom du donjon quand on entre  
  if destination_point:get_name() == "start_position" then
    map:start_dialog("crazy_house.title")
  end
end

function map:on_switch_activated(switch_name)

  if switch_name == "CS3" then
    -- Bouton qui fait apparaitre un coffre contenant la carte (CV3)
    sol.map.chest_set_enabled("CK3", true)
    game:set_value("b101", true)
    sol.main.play_sound("chest_appears")
  end
end

function accueil_branche1()

  if game:get_value("i1411") == 1 then
    map:start_dialog("crazy_house.accueil_epi_eo_1-7")
  elseif game:get_value("i1411") == 2 then
    map:start_dialog("crazy_house.accueil_epi_eo_2-6")
  elseif game:get_value("i1411") == 3 then
    map:start_dialog("crazy_house.accueil_epi_eo_3-5")
  elseif game:get_value("i1411") == 4 then
    map:start_dialog("crazy_house.accueil_epi_eo_4-9")
  elseif game:get_value("i1411") == 5 then
    map:start_dialog("crazy_house.accueil_epi_eo_3-5")
  elseif game:get_value("i1411") == 6 then
    map:start_dialog("crazy_house.accueil_epi_eo_2-6")
  elseif game:get_value("i1411") == 7 then
    map:start_dialog("crazy_house.accueil_epi_eo_1-7")
  elseif game:get_value("i1411") == 8 then
    map:start_dialog("crazy_house.accueil_epi_eo_8-10")
  elseif game:get_value("i1411") == 9 then
    map:start_dialog("crazy_house.accueil_epi_eo_4-9")
  elseif game:get_value("i1411") == 10 then
    map:start_dialog("crazy_house.accueil_epi_eo_8-10")
  end
end

function accueil_branche2()

  if game:get_value("i1412") == 1 then
    map:start_dialog("crazy_house.accueil_bal_eo_1-6-8-10")
  elseif game:get_value("i1412") == 2 then
    map:start_dialog("crazy_house.accueil_bal_eq_2")
  elseif game:get_value("i1412") == 3 then
    map:start_dialog("crazy_house.accueil_bal_eq_3")
  elseif game:get_value("i1412") == 4 then
    map:start_dialog("crazy_house.accueil_bal_eq_4")
  elseif game:get_value("i1412") == 5 then
    map:start_dialog("crazy_house.accueil_bal_eo_5-9")
  elseif game:get_value("i1412") == 6 then
    map:start_dialog("crazy_house.accueil_bal_eo_1-6-8-10")
  elseif game:get_value("i1412") == 7 then
    map:start_dialog("crazy_house.accueil_bal_eq_7")
  elseif game:get_value("i1412") == 8 then
    map:start_dialog("crazy_house.accueil_bal_eo_1-6-8-10")
  elseif game:get_value("i1412") == 9 then
    map:start_dialog("crazy_house.accueil_bal_eo_5-9")
  elseif game:get_value("i1412") == 10 then
    map:start_dialog("crazy_house.accueil_bal_eo_1-6-8-10")
  end
end

-- Hôtesse d'accueil ------------------------------------------
function accueil()

  if game:get_value("b120") then
    -- Le joueur a retrouvé ses gants
    map:start_dialog("crazy_house.accueil_fini")
  elseif game:get_value("i1410") == 0 then
    map:start_dialog("crazy_house.accueil_ech_eq_0")
    game:set_value("i1410", 1)
  elseif game:get_value("i1410") == 1 then
    map:start_dialog("crazy_house.accueil_ech_eq_1")
  elseif game:get_value("i1410") == 2 then
    map:start_dialog("crazy_house.accueil_ech_eq_2")
    game:set_value("i1410", 3)
  elseif game:get_value("i1410") == 3 then
    map:start_dialog("crazy_house.accueil_ech_eq_3")
  elseif game:get_value("i1410") == 4 then
    map:start_dialog("crazy_house.accueil_ech_eq_4")
  elseif game:get_value("i1410") == 5 then
    map:start_dialog("crazy_house.accueil_ech_eo_5-7")
  elseif game:get_value("i1410") == 6 then
    map:start_dialog("crazy_house.accueil_ech_eq_6")
  elseif game:get_value("i1410") == 7 then
    map:start_dialog("crazy_house.accueil_ech_eo_5-7")
  elseif game:get_value("i1410") == 8 then
    if game:get_value("i1411") < 10 and game:get_value("i1412") < 10 then        	
      if game:get_value("i1411") > game:get_value("i1412") then
        accueil_branche1()
      else
        accueil_branche2()
      end
    else
      if game:get_value("i1411") == 10 then
        accueil_branche2()
      elseif game:get_value("i1412") == 10 then
        accueil_branche1()
      end
    end
  elseif game:get_value("i1410") == 9 then
    map:start_dialog("crazy_house.accueil_ech_eq_9")
  elseif game:get_value("i1410") == 10 then
    map:start_dialog("crazy_house.accueil_ech_eq_10")
  elseif game:get_value("i1410") == 11 then
    map:start_dialog("crazy_house.accueil_ech_eq_11")
  end
end

-- Guichet 11 -------------------------------------------------
function guichet_11()

  if game:get_value("i1410") >= 8 then
    if game:get_value("i1412") == 9 then
      -- Chercher des haches (mais future erreur : donné : roc magma)
      if sol.game.get_item_amount("tapisserie_counter") >= 1 then
        map:start_dialog("crazy_house.guichet_11_bal_eq_9")
      else        	
        map:start_dialog("crazy_house.guichet_11_ech_eq_9")
      end
    else
      -- Chercher des haches
      if sol.game.get_item_amount("tapisserie_counter") >= 1 then
        map:start_dialog("crazy_house.guichet_11_ech_eq_9_ht")
      else        	
        map:start_dialog("crazy_house.guichet_11_ech_eq_9")
      end
      -- Incrémentation branche 1411
      local branche1411 = game:get_value("i1411")
      if branche1411 > 0 and branche1411 <= 2 then
        game:set_value("i1411", 3)
      end
    end
  else
    -- S'adresser à l'accueil
    map:start_dialog("crazy_house.guichet_11_ech_ne_9")
  end
  -- Incrémentation branche 1412
  local branche1412 = game:get_value("i1412")
  if branche1412 > 0 and branche1412 <= 5 then
    game:set_value("i1412", 6)
  end
end

-- Guichet 12a ------------------------------------------------
function guichet_12A()

  if game:get_value("i1410") == 5 then
    map:start_dialog("crazy_house.guichet_12A_ech_eq_5")
    game:set_value("i1410", 6)
  else
    map:start_dialog("crazy_house.guichet_12A_ech_ne_5")
  end
end

-- Guichet 12b -----------------------------------------------
function guichet_12B()

  if not sol.map.door_is_open("weak_wall_A") then -- hint for the first weak wall
    map:start_dialog("crazy_house.guichet_12B_ech_eq_3")
  elseif not game:get_value("b130") then -- hint for the second weak wall
    map:start_dialog("crazy_house.guichet_12B_aw")
  elseif game:get_value("i1410") == 3 then
    map:start_dialog("crazy_house.guichet_12B_ech_eq_3")
  elseif game:get_value("i1410") >= 7 then
    map:start_dialog("crazy_house.guichet_12B_ech_eq_7")
    if game:get_value("i1410") == 7 then
      game:set_value("i1410", 8)
      game:set_value("i1411", 1)
      game:set_value("i1412", 1)
    end
  else
    map:start_dialog("crazy_house.guichet_12B_aw")
  end
end

function map:on_npc_interaction(npc_name)

  -- Tableau de mario qui parle ---------------------------------
  if npc_name == "mario_message_1" then
    sol.main.play_sound("sm64_memario")
    map:start_dialog("crazy_house.mario_message_1")
  elseif npc_name == "AccueilFront" then
    accueil()
  elseif npc_name == "GC11Front" then
    guichet_11()
  elseif npc_name == "GC12A" then
    guichet_12A()
  elseif npc_name == "GC12B" then
    guichet_12B()
  elseif npc_name == "Accueil" then
    accueil()
  elseif npc_name == "GC11" then
    guichet_11()
  elseif npc_name == "GC12A" then
    guichet_12A()
  elseif npc_name == "GC12B" then
    guichet_12B()
  end
end

function map:on_hero_on_sensor(sensor_name)

  -- Fonctionnaire en grève
  if sensor_name == "passage_sensor_A" and not sol.map.crystal_get_state() then
    map:start_dialog("crazy_house.public_agent")
  end
end

function map:on_dialog_finished(dialog_id, answer)

  if dialog_id == "crazy_house.guichet_12B_ech_eq_7" then
    -- Echange pour parfum
    if answer == 0 then
      -- Contrôle de quantité bocal d'épices et balai
      if sol.game.get_item_amount("bocal_epice_counter") >= 1
          and sol.game.get_item_amount("balai_counter") >= 1 then
        map:start_dialog("crazy_house.guichet_12B_ech_eq_7_ok")
      else
        if sol.game.get_item_amount("bocal_epice_counter") >= 1 then
          map:start_dialog("crazy_house.guichet_12B_ech_eq_7_un_balai")
        elseif sol.game.get_item_amount("balai_counter") >= 1 then
          map:start_dialog("crazy_house.guichet_12B_ech_eq_7_un_bocal")
        else
          map:start_dialog("crazy_house.guichet_12B_ech_eq_7_un")
        end
      end
    else
      map:start_dialog("crazy_house.guichet_12B_ech_eq_7_no")
    end
  elseif dialog_id == "crazy_house.guichet_12B_ech_eq_7_ok" then
    -- Obtention du parfum (guichet 12B)
    sol.map.treasure_give("parfum", 1, -1)
    sol.game.remove_item_amount("bocal_epice_counter", 1)
    sol.game.remove_item_amount("balai_counter", 1)
    game:set_value("i1410", 10)
  elseif dialog_id == "crazy_house.guichet_11_ech_eq_9_ht" then
    if answer == 0 then
      if sol.game.get_item_amount("tapisserie_counter") >= 1 then
        -- Obtention de la hache (guichet 11)
        sol.map.treasure_give("hache", 1, -1)
        sol.game.remove_item_amount("tapisserie_counter", 1)
        -- Incrémentation branche 1411
        local branche1411 = game:get_value("i1411")
        if branche1411 > 0 and branche1411 <= 6 then
          game:set_value("i1411", 7)
        end
      end
    end
  elseif dialog_id == "crazy_house.guichet_11_bal_eq_9" then
    if answer == 0 then
      if sol.game.get_item_amount("tapisserie_counter") >= 1 then
        -- Obtention du roc magma (guichet 11)
        guichet_11_error = true
        sol.map.treasure_give("roc_magma", 1, -1)
        sol.game.remove_item_amount("tapisserie_counter", 1)
        -- Incrémentation branche 1412
        local branche1412 = game:get_value("i1412")
        game:set_value("i1412", 10)
      end
    end
  end
end

function map:on_door_open(door_name)

  if door_name == "weak_wall_A" then
    sol.main.play_sound("secret")
  elseif door_name == "DK1" then
    -- Opening the locked door: never give the final small key
    game:set_value("b128", true)
  end
end

function map:on_chest_empty(chest_name)

  if chest_name == "CK3" then
    if game:get_value("b141") then
      -- The locked door in 3F is already open
      sol.map.treasure_give("rupee", 4, -1)
    else
      -- Normal case: give a small key
      sol.map.treasure_give("small_key", 1, -1)
    end
  else
    -- Coffre vide classique
    sol.main.play_sound("wrong")
    map:start_dialog("_empty_chest")
    sol.map.hero_unfreeze()
  end
end

function map:on_treasure_obtained(item_name, variant, savegame_variable)

  if item_name == "roc_magma" and guichet_11_error then
    map:start_dialog("crazy_house.guichet_11_bal_err")
  end
end

