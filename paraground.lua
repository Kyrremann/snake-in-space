function para_setup()
   stars = {}
   max_stars = 2000
   for i=1, max_stars do
      local x = math.random(-(gr.getWidth() / 2), 
			    gr.getWidth() * 1.5)
      local y = math.random(-(gr.getHeight() / 2), 
			    gr.getHeight() * 1.5)
      local decider = math.random(0, 3)
      if  decider == 0 then
	 stars[i] = {x, y, 10}
      elseif decider == 1 then
	 stars[i] = {x, y, 15}
      else
	 stars[i] = {x, y, 25}
      end
   end
end

function para_update(dt)
   if #triangleX > 0 then
      for i=1, #stars do
	 stars[i][1] = stars[i][1] + 
	    (math.cos(triangleA[1]) * dt * stars[i][3])
	 stars[i][2] = stars[i][2] + 
	    (math.sin(triangleA[1]) * dt * stars[i][3])
      end
   end
end

function para_draw()
   for i=1, #stars do
      love.graphics.point(stars[i][1], stars[i][2])
   end
end
