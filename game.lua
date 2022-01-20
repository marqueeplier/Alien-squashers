local player = {}
local enemies = {}
local player2 = {}
 

function player_load()
	background = love.graphics.newImage("gfx/raiders/background.png")
	bullet_img = love.graphics.newImage("gfx/raiders/bullet.png")
	player_img = love.graphics.newImage("gfx/raiders/player.png")
	enemy_img = love.graphics.newImage("gfx/raiders/enemy.png")
	
	player.x = 350
	player.y = 540
	player.width = 64
	player.height = 64
	player.speed = 30
	player.xvel = 0
	player.yvel = 0
	player.friction = 3.5
	player.bullets = {}

	score = 0
end

local enemyspawn = 100
local enemyspawn1 = 250
local enemyspawn2 = 300
local enemyspawn3 = 450
local enemyspawn4 = 480
local cooldown = 15
local cooldown2 = 15
local game_over = false
local counter = 0
local speed = 100

function player_update(dt)

	enemyspawn = enemyspawn - speed * dt
	enemyspawn1 = enemyspawn1 - speed * dt
	enemyspawn2 = enemyspawn2 - speed * dt
	enemyspawn3 = enemyspawn3 - speed * dt
	cooldown = cooldown - speed * dt 
	cooldown2 = cooldown2 - speed * dt 
	
	player.xvel = player.xvel * (1 - math.min(dt * player.friction, 1))

	if love.keyboard.isDown("a") and player.xvel > -100 then
		player.xvel = player.xvel - player.speed * dt
	elseif love.keyboard.isDown("d") and player.xvel < 100 then
		player.xvel = player.xvel + player.speed * dt
	elseif love.keyboard.isDown("r") then
		score = 0
		game_over = false
		player.speed = 30
		player.friction = 3.5
		player2.speed = 30
		player2.friction = 3.5
	end

	if love.keyboard.isDown(" ") and game_over ~= true then
		player_bullets()
	end

	player.x = player.x + player.xvel

	for i, b in ipairs(player.bullets) do
		if b.y <= -10 then
			table.remove(player.bullets, i)
		end
		b.y = b.y - b.speed * dt
	end

	for i, e in ipairs(enemies) do
		if e.y >= 580 or game_over == true then
			table.remove(enemies, i)
		end
		e.y = e.y + e.speed * dt 
	end

	for i, e in pairs(enemies) do
		if e.y >= 580 then  
			game_over = true
		end
	end

	for i1, b in ipairs(player.bullets) do
		for i2, e in ipairs(enemies) do
			if CheckCollision(b.x, b.y, b.width, b.height, e.x, e.y, e.width, e.height) then
				love.audio.play(sounds.destroy)
				table.remove(enemies, i2)
				score = score + 1
				counter = counter + 1
				table.remove(player.bullets, i1)
			elseif score >= 50 and score <= 100 then
				e.speed = 300
				player.speed = 34
				player.friction = 3.2
			elseif score >= 100 and score <= 200 then
				e.speed = 400
				player.speed = 36
				player.friction = 3
			elseif score >= 200 then
				e.speed = 500
				player.speed = 39
				player.friction = 2.5
			end
		end 
	end 

	if gudgfx == true then
		background_update(dt)
	end

player_bounds()
end


function player_draw()
	love.graphics.setColor(255, 255, 255)

	if gudgfx == true then
		background_draw()
	end
	if game_over ~= true then
		love.graphics.draw(player_img, player.x, player.y)
		love.graphics.print("Score:" .. score, 655, 0)
	else
		love.graphics.print("Game Over", 300, 250)
		love.graphics.print("Final score:" .. score, 300, 350)
		love.graphics.print("R to restart:", 300, 450)
	end

	for _, b in pairs(player.bullets) do
		love.graphics.draw(bullet_img, b.x, b.y)
	end

	if game_over ~= true then
		for _, e in pairs(enemies) do
			love.graphics.draw(enemy_img, e.x, e.y)
		end
	end
	

end

function player_bullets()
	if cooldown <= 0 then
		love.audio.play(sounds.shoot)
		cooldown = 15
		bullet = {}
		bullet.x = player.x + 26
		bullet.y = player.y + 20
		bullet.width = 10
		bullet.height = 10
		bullet.speed = 400
		table.insert(player.bullets, bullet)
	end
end

function player_bounds()
	-- player 1

	if player.x < 0 then
		player.x = 0
		player.xvel = 0
	end


	if player.x + player.width > screenWidth then
		player.x = screenWidth - player.width
		player.xvel = 0
	end

	if player.y < 0 then
		player.y = 0
		player.yvel = 0
	end

	if player.y + player.height > screenHeight then
		player.y = screenHeight - player.height
		player.yvel = 0
	end

--	player2

	if player2.x < 0 then
		player2.x = 0
		player2.xvel = 0
	end

	if player2.x + player2.width > screenWidth then
		player2.x = screenWidth - player2.width
		player2.xvel = 0
	end

	if player2.y < 0 then
		player2.y = 0
		player2.yvel = 0
	end

	if player2.y + player2.height > screenHeight then
		player2.y = screenHeight - player2.height
		player2.yvel = 0
	end


	enemy_spawn(0, 20)
	enemy_spawn1(150, 20)
	enemy_spawn2(350, 20)
	enemy_spawn3(450, 20)
	enemy_spawn4(550, 20)

end

function player2_load()
	player2_img = love.graphics.newImage("gfx/raiders/player2.png")
	bullet2_img = love.graphics.newImage("gfx/raiders/bullet2.png")

	player2.x = 450
	player2.y = 540
	player2.width = 64
	player2.height = 64
	player2.speed = 30
	player2.xvel = 0
	player2.yvel = 0
	player2.friction = 3.5
	player2.bullets = {}
end

function player2_update(dt)
	if love.keyboard.isDown("left") and player2.xvel > -100 then
		player2.xvel = player2.xvel - player2.speed * dt
	elseif love.keyboard.isDown("right") and player.xvel < 100 then
		player2.xvel = player2.xvel + player2.speed * dt
	end

	player2.xvel = player2.xvel * (1 - math.min(dt * player2.friction, 1))

	player2.x = player2.x + player2.xvel
	
	if love.keyboard.isDown("rshift") and game_over ~= true then
		player2_bullets()
	end

	for i, b in ipairs(player2.bullets) do
		if b.y <= -10 then
			table.remove(player2.bullets, i)
		end
		b.y = b.y - b.speed * dt
	end

	for i1, b in ipairs(player2.bullets) do
		for i2, e in ipairs(enemies) do
			if CheckCollision(b.x, b.y, b.width, b.height, e.x, e.y, e.width, e.height) then
				love.audio.play(sounds.destroy)
				table.remove(enemies, i2)
				score = score + 1
				counter = counter + 1
				table.remove(player2.bullets, i1)
			elseif score >= 50 and score <= 100 then
				player2.speed = 34
				player2.friction = 3.2
			elseif score >= 100 and score <= 200 then
				player2.speed = 36
				player2.friction = 3
			elseif score >= 200 then
				player2.speed = 39
				player2.friction = 2.5
			end
		end 
	end 
end

function player2_draw()
	if game_over ~= true then
		love.graphics.draw(player2_img, player2.x, player2.y)
	end

	for _, b in pairs(player2.bullets) do
		love.graphics.draw(bullet2_img, b.x, b.y)
	end
end

function player2_bullets()
	if cooldown2 <= 0 then
		love.audio.play(sounds.shoot)
		cooldown2 = 15
		bullet = {}
		bullet.x = player2.x + 26
		bullet.y = player2.y + 20
		bullet.width = 10
		bullet.height = 10
		bullet.speed = 400
		table.insert(player2.bullets, bullet)
	end
end



function enemy_spawn(x, y)
	if enemyspawn <= 0 then
		enemyspawn = 100
		enemy = {}
		enemy.x = x
		enemy.y = y
		enemy.width = 64
		enemy.height = 64
		enemy.speed = 200
		enemy.bullets = {}
		table.insert(enemies, enemy)
	end	
end	


function enemy_spawn1(x, y)
	if enemyspawn1 <= 0 then
		enemyspawn1 = 250
		enemy = {}
		enemy.x = x
		enemy.y = y
		enemy.width = 64
		enemy.height = 64
		enemy.speed = 200
		enemy.bullets = {}
		table.insert(enemies, enemy)
	end	
end	

function enemy_spawn2(x, y)
	if enemyspawn2 <= 0 then
		enemyspawn2 = 300
		enemy = {}
		enemy.x = x
		enemy.y = y
		enemy.width = 64
		enemy.height = 64
		enemy.speed = 200
		enemy.bullets = {}
		table.insert(enemies, enemy)
	end	
end	

function enemy_spawn3(x, y)
	if enemyspawn3 <= 0 then
		enemyspawn3 = 450
		enemy = {}
		enemy.x = x
		enemy.y = y
		enemy.width = 64
		enemy.height = 64
		enemy.speed = 200
		enemy.bullets = {}
		table.insert(enemies, enemy)
	end	
end	

function enemy_spawn4(x, y)
	if enemyspawn4 <= 0 then
		enemyspawn4 = 480
		enemy = {}
		enemy.x = x
		enemy.y = y
		enemy.width = 64
		enemy.height = 64
		enemy.speed = 200
		enemy.bullets = {}
		table.insert(enemies, enemy)
	end	
end	







