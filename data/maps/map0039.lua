----------------------------------
-- FREAKING CAVE 2 OMFG	        --
----------------------------------

	

function event_map_started(destination_point_name)
	
	-- No light inside the cave at start
	sol.map.light_set(0) 	
	-- Let the trap door openned
	sol.map.door_open("trap_door")
	-- Disable ennemies
	sol.map.enemy_set_enabled("ennemy_1",false)
	sol.map.enemy_set_enabled("ennemy_2",false)
end

function event_hero_on_sensor(sensor_name)
	
	-- Closing trap door	
	if sensor_name == "sensor_close_trap_door" then
		-- Disable sword
		sol.game.set_item("sword", 0)
		-- Close door
		sol.map.door_close("trap_door")
		sol.map.sensor_set_enabled("sensor_close_trap_door",false)
	
	-- Make appear some ennemies	
	elseif sensor_name == "make_appear_c1" then
		sol.map.enemy_set_enabled("ennemy_1",true)
		sol.map.sensor_set_enabled("make_appear_c1",false)
	elseif sensor_name == "make_appear_c2" then
		sol.map.enemy_set_enabled("ennemy_2",true)
		sol.map.light_set(1)	
		sol.map.sensor_set_enabled("make_appear_c2",false)	
	elseif sensor_name == "make_appear_c3" then
		sol.map.light_set(0) 	
		sol.map.sensor_set_enabled("make_appear_c3",false)
	end	

end
