----------------------------
-- Caverne maudite script --
----------------------------

function event_hero_interaction(entity_name)
	if entity_name == "sign" then
		sol.map.dialog_start("caverne_maudite.pancarte")
		sol.map.dialog_set_variable("caverne_maudite.pancarte", sol.game.savegame_get_name())
	end
end
