local map = ...

-- The end

function event_map_started(destination_point_name)

  sol.map.hud_set_enabled(false)
  sol.map.hero_freeze()
  sol.game.add_life(sol.game.get_max_life())
  sol.game.save()
  sol.main.timer_start(credits, 7000)
  sol.main.play_sound("hero_dying")
end

function credits()

  sol.map.dialog_start("the_end.credits")
end

function event_dialog_finished(dialog_id)

  if dialog_id == "the_end.credits" then
    sol.game.reset()
  end
end

