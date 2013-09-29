function score_setup()
   score = 0
   hungryMode = false
   hungryTimer = 5
   hungryTrigger = 1000000
end

function score_update(dt)
   score = score + 1
   score = score + (#triangleX * 10)
   if score >= hungryTrigger then
      hungryMode = true
      hungryTrigger = hungryTrigger + 1000000
   end
   
   if hungryMode then
      hungryTimer = hungryTimer - dt
   end

   if hungryTimer <= 0 then
      hungryMode = false
      hungryTimer = 5
   end
end

function score_draw()
   gr.setColor(255, 255, 255, 255)
   gr.setFont(font_reg)
   gr.printf(score,
	     0, 0,
	     gr.getWidth(),
	     "center")	    

   if hungryMode then
      gr.setColor(math.random(0, 255),
		  math.random(0, 255),
		  math.random(0, 255),
		  math.random(0, 255))
      gr.setFont(font_space)
      gr.printf("HUNGRY MODE",
		0, gr.getHeight() 
		   - font_space:getHeight("HUNGRY MODE"),
		gr.getWidth(),
		"center")
   end
   if cookyMode then
      gr.setColor(math.random(0, 255),
		  math.random(0, 255),
		  math.random(0, 255),
		  math.random(0, 255))
      gr.setFont(font_space)
      gr.printf("COOKY MODE",
		0, gr.getHeight() 
		   - font_space:getHeight("HUNGRY MODE"),
		gr.getWidth(),
		"center")
   end
end
