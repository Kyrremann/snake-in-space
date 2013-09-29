function ball_setup()
   ppm = 15
   g = { 900 }

   m = .46
   vX = { 100 }
   vY = { 50 }
   rX = { ppm + 5 }
   rY = { ppm + 5 }
   speedX = 3
end

function ball_update(dt)
   for i=1, #rX do
      ballCollision(i)
      calc_ball(i, dt)
   end
end

function calc_ball(i, dt)
   local fX = g[i]
   local fY = m * g[i]

   local aX = fX / m
   local aY = fY / m
   
   vX[i] = vX[i] + aX * dt
   rX[i] = rX[i] + vX[i] * dt

   vY[i] = vY[i] + aY * dt
   rY[i] = rY[i] + vY[i] * dt
end

function ball_draw()
   for i=1, #rX do
      gr.circle("line", rX[i], rY[i], ppm, 100)
   end
   -- gr.rectangle("line", 300, 300, 100, 10
end

function ballCollision(i)
   if rY[i] > gr.getHeight() - ppm then
      rY[i] = gr.getHeight() - ppm
      vY[i] = -vY[i] + 10
   elseif rY[i] < 0 + ppm then
      rY[i] = 0 + ppm
      vY[i] = math.abs(vY[i]) + 10
   end  

   for j=1, #triangleA do
      if circlesIntersect(rX[i], rY[i], ppm,
			  triangleX[j], triangleY[j], 10) then
	 remove_triangle(j)
	 return
      end
   end
   
   --[[if rY + ppm >= 300 and rY - ppm <= 310 then
      if rX + ppm > 300 and rX - ppm< 400 then
      vY = -vY
      end
      end]]

   if rX[i] > gr.getWidth() - ppm then
      vX[i] = -vX[i]
   elseif rX[i] < 0 + ppm then
      vX[i] = math.abs(vX[i])
   end
end
