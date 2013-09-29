function player_setup()
   triangleX = {gr.getWidth() / 2, 
		100, 100, 100, 100, 100, 100, 100, 100,
		100, 100, 100, 100, 100, 100, 100, 100, 100}
   triangleY = {gr.getHeight() / 2, 
		100, 100, 100, 100, 100, 100, 100, 100,
		100, 100, 100, 100, 100, 100, 100, 100, 100}
   triangleA = {0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0}
   triangleX1 = gr.getWidth() / 2
   triangleY1 = gr.getHeight() / 2
   speed = 400
   appleSpawnTime = 1
   appleSpawner = appleSpawnTime
   appleX = {}
   appleY = {}
   spawnApple()
   triangleRad = 10

   cookyMode = false
   cookyTimer = 5
   cookySize = 5
   
   shieldModeOn = false
   mode_shield = false
   shield_timer_default = .1
   shield_timer = shield_timer_default
   shield_current = 1
end

function player_update(dt)

   if shieldModeOn then
      shield_timer = shield_timer - dt
      if shield_timer <= 0 then
	 mode_shield = true
	 local leftover = math.abs(shield_timer)
	 shield_timer = shield_timer_default - shield_timer
	 shield_current = shield_current + 1
	 if shield_current > #triangleX then
	    shield_current = 1
	    mode_shield = false
	    shieldModeOn = false
	 end
      end
   end

   cookyTimer = cookyTimer - dt
   if cookyTimer <= 0 then
      cookyMode = true
      triangleRad = 30
      local leftover = math.abs(cookyTimer)
      cookyTimer = 5 - cookyTimer
      speed = 600
   end
   
   if #triangleX == 0 then return end

   appleSpawner = appleSpawner - dt
   if appleSpawner <= 0 then
      spawnApple()
      local leftover = math.abs(appleSpawner)
      appleSpawner = appleSpawnTime - appleSpawner
   end

   triangleX1 = triangleX1 + (math.cos(triangleA[1]) * dt * speed)
   triangleY1 = triangleY1 + (math.sin(triangleA[1]) * dt * speed)
   
   calc_triangle(1, triangleX1, triangleY1)
   for i=1, #triangleX - 1 do
      calc_triangle(i + 1, triangleX[i], triangleY[i])
   end

   hitWall()
   eatApple()
end

function calc_triangle(i, xin, yin)
   local dx = xin - triangleX[i]
   local dy = yin - triangleY[i]
   triangleA[i] = math.atan2(dy, dx)
   triangleX[i] = xin - (math.cos(triangleA[i]) * triangleRad)
   triangleY[i] = yin - (math.sin(triangleA[i]) * triangleRad)
end

function hitWall()
   if triangleX[1] > gr.getWidth() or triangleX[1] < 0 then
      remove_triangle(1)
   elseif triangleY[1] > gr.getHeight() or triangleY[1] < 0 then
      remove_triangle(1)
   end
end

function remove_triangle(i)
   au.play(au.newSource("sounds/explosion.ogg", 
			"static"))
   table.remove(triangleX, i)
   table.remove(triangleY, i)
   table.remove(triangleA, i)
   if i == 1 then
      triangleX1 = triangleX[i]
      triangleY1 = triangleY[i]
   end
   cookyTimer = 5
   cookyMode = false
   triangleRad = 10
   speed = 400
end

function player_draw()
   for i=1, #triangleX do
      draw_triangle(triangleX[i], triangleY[i], triangleA[i], i)
   end
   
   for i=1, #appleX do
      gr.setColor(255, 0, 0, 255)
      draw_apple(i)
   end
end

function draw_apple(i)
   gr.circle("line", appleX[i], appleY[i], 10, 100)
end

function draw_triangle(x, y, a, i)
   gr.push()
   if mode_shield and i == shield_current then
      gr.setColor(255, 255, 255, 255)
      gr.circle("line", x, y, triangleRad, 100)
   end
   gr.setColor(triangleX[i], triangleY[i], triangleA[i], 255)
   gr.translate(x, y)
   gr.rotate(a)
   if cookyMode then
      gr.triangle("line", 
		  0, -15, 
		  0, 15, 
		  30, 0)
   else
      gr.triangle("line", 
		  0, -5, 
		  0, 5, 
		  10, 0)
   end
   gr.pop()
end

function player_keypressed(key)
   if #triangleX == 0 then return end

   if key == 'left' then
      if cookyMode then
	 triangleA[1] = triangleA[1] - 1
	 return
      end
      if #triangleX < 10 then
	 triangleA[1] = triangleA[1] - .7
      elseif #triangleX < 20 then
	 triangleA[1] = triangleA[1] - .6
      elseif #triangleX < 30 then
	 triangleA[1] = triangleA[1] - .5
      else
	 triangleA[1] = triangleA[1] - .3
      end
   elseif key == 'right' then
      if cookyMode then
	 triangleA[1] = triangleA[1] + 1
	 return
      end
      if #triangleX < 10 then
	 triangleA[1] = triangleA[1] + .7
      elseif #triangleX < 20 then
	 triangleA[1] = triangleA[1] + .6
      elseif #triangleX < 30 then
	 triangleA[1] = triangleA[1] + .5
      else
	 triangleA[1] = triangleA[1] + .3
      end
   end
end

function eatApple()
   for i=1, #appleX do
      if circlesIntersect(triangleX[1], triangleY[1],
			  triangleRad - 3, 
			  appleX[i], appleY[i], 10) then
	 au.play(au.newSource("sounds/nom" .. 
				 math.random(1, 9) .. 
				 ".ogg", 
			      "static"))
	 local size = 3
	 local mod = math.random(0, 100)
	 if mod > 95 then
	    size = 10
	 elseif mod > 80 then
	    size = 5
	 end
	 if hungryMode then
	    size = 20
	 end

	 for j=1, size do
	    addTriangleToWorm()
	 end
	 table.remove(appleX, i)
	 table.remove(appleY, i)
	 score = score + 10
	 return
      end
   end
end

function addTriangleToWorm()
   table.insert(triangleA, triangleA[#triangleA])
   table.insert(triangleX, triangleX[#triangleX])
   table.insert(triangleY, triangleY[#triangleY])
end

function spawnApple()
   local x = math.random(gr.getWidth() - 100) + 100
   local y = math.random(gr.getHeight() - 100) + 100
   table.insert(appleX, x)
   table.insert(appleY, y)
end
