function love.conf(t)
   t.title = "Snake in Space"
   t.author = "Kyrre Havik Eriksen"
   t.url = "https://github.com/Kyrremann/snakeInSpace"
   t.identity = nil 
   t.version = "0.9.1"
   t.release = true

   t.console = true
   
   -- t.screen = false
   -- t.screen.width = 1920
   -- t.screen.height = 1080
   -- t.screen.width = 0
   -- t.screen.height = 0
   t.screen.fullscreen = false
   t.screen.vsync = true
   t.screen.fsaa = 0

   t.modules.keyboard = true
   t.modules.event = true
   t.modules.image = true
   t.modules.graphics = true
   t.modules.timer = true

   t.modules.joystick = false
   t.modules.audio = true
   t.modules.mouse = false
   t.modules.sound = true
   t.modules.physics = false
end
