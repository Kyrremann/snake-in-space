function ball_setup()
   rad = { 15 }
   
   ballX = { math.random(50, gr.getWidth() - 50) }
   ballY = { math.random(50, gr.getHeight() - 50) }
   ballDirX = { 1 }
   ballDirY = { 1 }
   
   ballExtraRad = { 1 }   
   ballSpeed = 6
   ballSpawnScore = 100000
end

function ball_update(dt)
   for i=1, #ballX do
      ball_calc(i, dt)
      ball_collision(i)
   end

   if score > ballSpawnScore then
      ball_add()
      ballSpawnScore = ballSpawnScore + 100000
   end
end

function ball_add()
   local x = math.random(gr.getWidth() - 100) + 50
   local y = math.random(gr.getHeight() - 100) + 50
   local r = math.random(25) + 5

   for i=1, #ballX do
      if circlesIntersect(ballX[i], ballY[i], rad[i],
			  x, y, r) then
	 return
      end
   end
   
   table.insert(ballX, x)
   table.insert(ballY, y)
   table.insert(rad, r)
   table.insert(ballDirX, 1)
   table.insert(ballDirY, -1)
   table.insert(ballExtraRad, 1)
end

function ball_remove(i)
   table.remove(ballX, i)
   table.remove(ballY, i)
   table.remove(rad, i)
   table.remove(ballDirX, i)
   table.remove(ballDirY, i)
   table.remove(ballExtraRad, i)
end

function ball_calc(i, dt)
   if ballX[i] == nil then
      return -- more hacks
   end
   ballX[i] = ballX[i] + ( ballSpeed * ballDirX[i] )
   ballY[i] = ballY[i] + ( ballSpeed * ballDirY[i] )
   ballExtraRad[i] = ballExtraRad[i] + 1
   if ballExtraRad[i] > rad[i] then
      ballExtraRad[i] = 1
   end
end

function ball_collision(i)
   if ballX[i] == nil then
      return -- hacky hacky
   end
   if ballX[i] > gr.getWidth() - rad[i] 
   or ballX[i] < rad[i] then
      ballDirX[i] = ballDirX[i] * -1
      au.play(au.newSource("sounds/blop.ogg", 
			"static"))
   end
   if ballY[i] > gr.getHeight() - rad[i] 
   or ballY[i] < rad[i] then
      ballDirY[i] = ballDirY[i] * -1
      au.play(au.newSource("sounds/blop.ogg", 
			"static"))
   end

   for j=1, #triangleA do
      if circlesIntersect(ballX[i], ballY[i], rad[i],
			  triangleX[j], triangleY[j], 
			  triangleRad) then
	 if shieldModeOn and shield_current == j then
	    -- yeah...
	    ballDirY[i] = ballDirY[i] * -1
	    ballDirX[i] = ballDirX[i] * -1
	 else
   	    remove_triangle(j)
	    rad[i] = rad[i] - 1
	    if rad[i] == 0 then
	       ball_remove(i)
	    end
	 end
	 -- ballDirY[i] = ballDirY[i] * -1
	 -- ballDirX[i] = ballDirX[i] * -1
	 return
      end
   end

   for j=1, #appleX do
      if circlesIntersect(ballX[i], ballY[i], rad[i],
			  appleX[j], appleY[j], 10) then
	 
	 ballDirY[i] = ballDirY[i] * -1
	 --ballDirX[i] = ballDirX[i] * -1
	 au.play(au.newSource("sounds/blop.ogg", 
			   "static"))
	 return
      end
   end

   for j=1, #ballX do
      if circlesIntersect(ballX[i], ballY[i], rad[i],
			  ballX[j], ballY[j], rad[j]) 
      and i ~= j then
	 -- ballDirY[i] = ballDirY[i] * -1
	 ballDirX[i] = ballDirX[i] * -1
	 au.play(au.newSource("sounds/blop.ogg", 
			      "static"))
	 return
      end
   end
end

function ball_draw()
   for i=1, #ballX do
      gr.setColor(0, 255, 0, 255)
      gr.circle("line", ballX[i], ballY[i], rad[i], 100)
      -- for j=2, rad[i], 3 do
      gr.setColor(0, 255, 0, 255)
      gr.circle("line", ballX[i], ballY[i], 
		rad[i] - ballExtraRad[i], 100)
      -- end
   end
end
