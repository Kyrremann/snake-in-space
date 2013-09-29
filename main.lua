function love.load()
   require "setup"
   gr.setMode(gr.getWidth(), gr.getHeight(), 
	      not true, -- fullscreen
	      true, 0)
   mo.setVisible(false)
   ke.setKeyRepeat(.01, .01)
   
   sound_theme = au.newSource("sounds/theme.ogg")
   sound_theme:setLooping(true)
   sound_theme:setVolume(.4)
   au.play(sound_theme)

   menu_setup()
   ball_setup()
   player_setup()
   score_setup()
   para_setup()
   game_mode = 0
end

function love.update(dt)
   if game_mode == 1 then
      if #triangleX > 0 then
	 player_update(dt)
	 ball_update(dt)
	 score_update(dt)
	 para_update(dt)
      end
   end
end

function love.draw()
   gr.setBackgroundColor(32, 32, 32, 64)
   if game_mode == 0 then
      menu_draw()
   elseif game_mode == 1 then
      if #triangleX > 0 then
	 para_draw()
	 ball_draw()
	 player_draw()
	 score_draw()
      else
	 end_draw()
      end
   end
end

function love.keypressed(key)
   if key == "escape" then
      love.event.push('quit')
   end
   if game_mode == 0 then
      if key == 'return' then
	 game_mode = 1
	 the_start_of_time = os.time()
      end
   elseif game_mode == 1 then
      if key == 'left' then
	 player_keypressed(key)
      elseif key == 'right' then
	 player_keypressed(key)
      elseif key == ' ' then
	 shieldModeOn = true
      end
   end
end

function circlesIntersect(c1X, c1Y, c1Radius, c2X, c2Y, c2Radius)
   -- another hack to avoid nil problems
   c1X = c1X or 0
   c2X = c2X or 0
   c1Radius = c1Radius or 0
   c2Y = c2Y or 0
   c1Y = c1Y or 0

   -- this is a hack
   if #triangleX == 0 
      -- or #appleX == 0 
      or #ballX == 0 then
      return false
   end
   
   local distanceX = c2X - c1X;
   local distanceY = c2Y - c1Y;
   
   local magnitude = math.sqrt(distanceX * distanceX 
				  + distanceY * distanceY);
   return magnitude < c1Radius + c2Radius;
end
