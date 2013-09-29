function menu_setup()
   font_reg = gr.newFont(32)
   font_big = gr.newFont(64)
   font_space = gr.newFont(128)
end

function menu_draw()
   gr.setColor(255, 255, 255, 255)
   gr.setFont(font_reg)
   gr.printf("welcome to", 
	     0, gr.getHeight() / 5, 
	     gr.getWidth(), 
	     "center")

   gr.setFont(font_big)
   gr.printf("Snakes in",
	    0, gr.getHeight() / 4,
	    gr.getWidth(),
	    "center")

   gr.setFont(font_space)
   local string_space = { 'S', 'P', 'A', 'C', 'E' }
   local sw = font_space:getWidth('S')
   for i=1, #string_space do
      gr.setColor(math.random(0, 255),
		  math.random(0, 255),
		  math.random(0, 255))
      gr.printf(string_space[i],
		0, gr.getHeight() / 3,
		gr.getWidth() - 75 - (#string_space - (i * 2)) * sw,
		"center")
   end

   gr.setFont(font_reg)
   gr.setColor(255, 255, 255, 255)
   gr.printf("press enter to snake",
	     0, gr.getHeight() - (gr.getHeight() / 2.3),
	    gr.getWidth(),
	    "center")
end
