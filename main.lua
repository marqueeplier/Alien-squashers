require "game"
require "setupmenu"
require "collisions"

function love.load()

	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()

	sounds = {}
	sounds.destroy = love.audio.newSource("sounds/destroy.wav")
	sounds.shoot = love.audio.newSource("sounds/shoot.wav")
	sounds.background = love.audio.newSource("sounds/background.wav")

	sounds.background:setLooping(true)
	love.audio.play(sounds.background)

	player_load()
	buttons_load()
	player2_load()

	myfont = love.graphics.newFont("gfx/raiders/ka1.ttf")
	
	love.graphics.setFont(myfont)

	love.graphics.setBackgroundColor(0, 139, 139)

end

function love.update(dt)
	if current_state == gamestates.mainmenu then
		buttons_update()
	end

	if current_state == gamestates.action then
		player_update(dt)
	end

	if current_state == gamestates.settings then
		settings_update()
	end

	if current_state == gamestates.player2 then
		player_update(dt)
		player2_update(dt)
	end
end

function love.draw()

	if current_state == gamestates.mainmenu then
		buttons_draw()
	end
	
	if current_state == gamestates.action then
		player_draw()
	end

	if current_state == gamestates.player2 then
		player_draw()
		player2_draw()
	end


	if current_state == gamestates.settings then
		settings_draw()
	end
	
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "m" then
		current_state = gamestates.mainmenu
		mousedetect.x = 0
		mousedetect.y = 0
		score = 0
	end
end