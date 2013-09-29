function end_draw()
   gr.setColor(255, 255, 255, 255)
   gr.setFont(font_reg)
   gr.printf("Your score is",
	     0, gr.getHeight() / 2.5,
	     gr.getWidth(),
	     "center")
   gr.setFont(font_big)
   gr.setColor(math.random(0, 255),
	       math.random(0, 255),
	       math.random(0, 255))
   gr.printf(score,
	     0, gr.getHeight() / 2.2,
	     gr.getWidth(),
	     "center")
   
   gr.setColor(255, 255, 255, 255)
   gr.setFont(font_reg)
   gr.printf("Press enter to snake again",
	     0, gr.getHeight() / 1.5,
	     gr.getWidth(),
	     "center")
end
