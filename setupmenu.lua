local startbutton = {}
local settingsbutton = {}
local quitbutton = {}
local gfx = {}
local graphics = {}
local player2 = {}
mousedetect = {}

gamestates = {mainmenu = "mainmenu", action = "action", settings = "settings", player2 = "player2"}

current_state = gamestates.mainmenu

fullscreen = "Off"
gfxtoggle = "Bad"
gudgfx = false

function buttons_load()

	love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=800, minheight=600})

	buttons = {}
	buttons.start = love.graphics.newImage("gfx/menu/start.png")
	buttons.player2 = love.graphics.newImage("gfx/menu/2player.png")
	buttons.settings = love.graphics.newImage("gfx/menu/settings.png")
	buttons.quit = love.graphics.newImage("gfx/menu/quit.png")

	logo = love.graphics.newImage("gfx/menu/logo.png")

	startbutton.x = 265
	startbutton.y = 165
	startbutton.width = 250 
	startbutton.height = 50
	 
	player2.x = 265 
	player2.y = 250 
	player2.width = 250 
	player2.height = 50 

	settingsbutton.x = 265 
	settingsbutton.y = 340 
	settingsbutton.width = 250
	settingsbutton.height = 50 

	quitbutton.x = 265 
	quitbutton.y = 430 
	quitbutton.width = 250 
	quitbutton.height = 50

	mousedetect.x = 0  
	mousedetect.y = 0  
	mousedetect.width = 20 
	mousedetect.height = 20 

	gfx.x = 290  
	gfx.y = 165  
	gfx.width = 200 
	gfx.height = 100 

	graphics.x = 290
	graphics.y = 315
	graphics.width = 200
	graphics.height = 100 

	background_load() 

end

function buttons_update()
	if CheckCollision(mousedetect.x, mousedetect.y,  mousedetect.width, mousedetect.height, startbutton.x, startbutton.y, startbutton.width, startbutton.height) then
		current_state = gamestates.action
		mousedetect.x = 0
		mousedetect.y = 0
	end

	if CheckCollision(mousedetect.x, mousedetect.y,  mousedetect.width, mousedetect.height, settingsbutton.x, settingsbutton.y, settingsbutton.width, settingsbutton.height) then
		current_state = gamestates.settings
		mousedetect.x = 0
		mousedetect.y = 0
	end
	
	if CheckCollision(mousedetect.x, mousedetect.y,  mousedetect.width, mousedetect.height, quitbutton.x, quitbutton.y, quitbutton.width, quitbutton.height) then
		love.event.quit()
	end

	if CheckCollision(mousedetect.x, mousedetect.y,  mousedetect.width, mousedetect.height, player2.x, player2.y, player2.width, player2.height) then
		current_state = gamestates.player2
		mousedetect.x = 0
		mousedetect.y = 0
	end

end

function love.mousepressed(x, y, b, istouch)
	if current_state == gamestates.mainmenu or current_state == gamestates.settings then
		mousedetect.x = x 
		mousedetect.y = y 
	end
end

function buttons_draw()
	love.graphics.setFont(myfont)	

	love.graphics.setColor(255, 0, 0, 1)
	love.graphics.rectangle("fill", startbutton.x, startbutton.y, startbutton.width, startbutton.height)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(buttons.start, startbutton.x, startbutton.y)	

	love.graphics.setColor(255, 0, 0, 1)
	love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(buttons.player2, player2.x, player2.y)	

	love.graphics.setColor(0, 255, 0, 1)
	love.graphics.rectangle("fill", settingsbutton.x, settingsbutton.y, settingsbutton.width, settingsbutton.height)

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(buttons.settings, settingsbutton.x, settingsbutton.y)

	love.graphics.setColor(0, 0, 255, 1)
	love.graphics.rectangle("fill", quitbutton.x, quitbutton.y, quitbutton.width, quitbutton.height)

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(buttons.quit, quitbutton.x, quitbutton.y)
	
	love.graphics.setColor(255, 255, 255, 1)
	love.graphics.rectangle("fill", mousedetect.x, mousedetect.y, mousedetect.width, mousedetect.height) 

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(logo, 140, 30)

end

function settings_update()

	if current_state == gamestates.settings then
		if CheckCollision(mousedetect.x, mousedetect.y, mousedetect.width, mousedetect.height, gfx.x, gfx.y, gfx.width, gfx.height) and fullscreen == "Off" then
			mousedetect.x = 0
			mousedetect.y = 0
			fullscreen = "On"
			love.window.setFullscreen(true, "normal")
		end

		if CheckCollision(mousedetect.x, mousedetect.y, mousedetect.width, mousedetect.height, gfx.x, gfx.y, gfx.width, gfx.height) and fullscreen == "On" then
			mousedetect.x = 0
			mousedetect.y = 0
			fullscreen = "Off"
			love.window.setFullscreen(false, "desktop")
		end

		if CheckCollision(mousedetect.x, mousedetect.y, mousedetect.width, mousedetect.height, graphics.x, graphics.y, graphics.width, graphics.height) and gfxtoggle == "Bad" then
			mousedetect.x = 0
			mousedetect.y = 0
			gfxtoggle = "Gud"
			gudgfx = true
		end

		if CheckCollision(mousedetect.x, mousedetect.y, mousedetect.width, mousedetect.height, graphics.x, graphics.y, graphics.width, graphics.height) and gfxtoggle == "Gud" then
			mousedetect.x = 0
			mousedetect.y = 0
			gfxtoggle = "Bad"
			gudgfx = false
		end
		
	end

end

function settings_draw()

	if current_state == gamestates.settings then
		love.graphics.setColor(23, 24, 52)
		love.graphics.rectangle("fill", gfx.x, gfx.y, gfx.width, gfx.height)
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("Fulscreen:"..fullscreen, gfx.x + 40 , gfx.y + 40)	
		love.graphics.setColor(23, 24, 52)
		love.graphics.rectangle("fill", graphics.x, graphics.y, graphics.width, graphics.height)
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("Graphics:"..gfxtoggle, graphics.x + 40, graphics.y + 40)
	end

	love.graphics.setColor(255, 255, 255, 1)
	love.graphics.rectangle("fill", mousedetect.x, mousedetect.y, mousedetect.width, mousedetect.height) 
end

function background_load()
	background_1 = {x = 0, y = 0, width = 802, height = 602}
	background_2 = {x = 0, y = 604, width = 802, height = 602}

	background_speed = 100
end

function background_update(dt)
	if background_1.y + background_1.height > 0 then 
		background_1.y = background_1.y - background_speed * dt
		background_2.y = background_1.y + background_1.height
	end 

	if background_1.y + background_1.height <= 0 then
		background_2.y = background_1.y - background_speed * dt
		background_1.y = background_2.y + background_2.height
	end 
end

function background_drawsel(background_one, background_two, img)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(img, background_one.x, background_one.y)
	love.graphics.draw(img, background_two.x, background_two.y)

	love.graphics.print("background1"..": ".. background_1.y, 0, 0)
end

function background_draw()
	background_drawsel(background_1, background_2, background)
end