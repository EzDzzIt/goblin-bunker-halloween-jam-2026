--- @class Eye : Actor
--- @field selected boolean
--- @field matched boolean
--- @field falling boolean
--- @field type number eye type
--- @field current_animation string index to animation quad table
Eye = setmetatable({}, { __index = Actor })
Eye.__index = Eye

Quads.eye_0_idle = { love.graphics.newQuad(TILE_SIZE_X, 0, TILE_SIZE_X, TILE_SIZE_X, Spritesheet), love.graphics
		.newQuad(TILE_SIZE_X * 2, 0, TILE_SIZE_X, TILE_SIZE_X,
			Spritesheet) }
Quads.eye_1_idle = { love.graphics.newQuad(TILE_SIZE_X, 0 + TILE_SIZE_X, TILE_SIZE_X, TILE_SIZE_X, Spritesheet),
	love.graphics.newQuad(TILE_SIZE_X * 2, 0 + TILE_SIZE_X, TILE_SIZE_X,
		TILE_SIZE_X, Spritesheet) }
Quads.eye_2_idle = { love.graphics.newQuad(TILE_SIZE_X, 0 + TILE_SIZE_X * 2, TILE_SIZE_X, TILE_SIZE_X, Spritesheet),
	love.graphics.newQuad(TILE_SIZE_X * 2,
		0 + TILE_SIZE_X * 2,
		TILE_SIZE_X, TILE_SIZE_X, Spritesheet) }
Quads.eye_3_idle = { love.graphics.newQuad(TILE_SIZE_X, 0 + TILE_SIZE_X * 3, TILE_SIZE_X, TILE_SIZE_X, Spritesheet),
	love.graphics.newQuad(TILE_SIZE_X * 2,
		0 + TILE_SIZE_X * 3,
		TILE_SIZE_X, TILE_SIZE_X, Spritesheet) }
Quads.eye_4_idle = { love.graphics.newQuad(TILE_SIZE_X, 0 + TILE_SIZE_X * 4, TILE_SIZE_X, TILE_SIZE_X, Spritesheet),
	love.graphics.newQuad(TILE_SIZE_X * 2,
		0 + TILE_SIZE_X * 4, TILE_SIZE_X, TILE_SIZE_X, Spritesheet) }
Quads.eye_5_idle = { love.graphics.newQuad(TILE_SIZE_X, 0 + TILE_SIZE_X * 5, TILE_SIZE_X, TILE_SIZE_X, Spritesheet),
	love.graphics.newQuad(TILE_SIZE_X * 2,
		0 + TILE_SIZE_X * 5,
		TILE_SIZE_X, TILE_SIZE_X, Spritesheet) }
Quads.eye_6_idle = { love.graphics.newQuad(TILE_SIZE_X, 0 + TILE_SIZE_X * 6, TILE_SIZE_X, TILE_SIZE_X, Spritesheet),
	love.graphics.newQuad(TILE_SIZE_X * 2,
		0 + TILE_SIZE_X * 6, TILE_SIZE_X, TILE_SIZE_X, Spritesheet) }


Quads.bones_0 = love.graphics.newQuad(TILE_SIZE_X, TILE_SIZE_Y * 7, TILE_SIZE_X, TILE_SIZE_Y, Spritesheet)
Quads.bones_1 = love.graphics.newQuad(TILE_SIZE_X + TILE_SIZE_X * 1, TILE_SIZE_Y * 7, TILE_SIZE_X, TILE_SIZE_Y,
	Spritesheet)
Quads.bones_2 = love.graphics.newQuad(TILE_SIZE_X + TILE_SIZE_X * 2, TILE_SIZE_Y * 7, TILE_SIZE_X, TILE_SIZE_Y,
	Spritesheet)
Quads.bones_3 = love.graphics.newQuad(TILE_SIZE_X + TILE_SIZE_X * 3, TILE_SIZE_Y * 7, TILE_SIZE_X, TILE_SIZE_Y,
	Spritesheet)

Quads.pent = love.graphics.newQuad(32, 256, 32, 32, Spritesheet)

function Eye:new(args)
	--- @class Eye
	local eye = Actor:new(args)
	eye.w = TILE_SIZE_X
	eye.h = TILE_SIZE_Y
	eye.selected = false
	eye.matched = false
	eye.hexed = false
	eye.falling = false
	eye.type = args.type or 0
	eye.current_animation_frame = 1
	eye.animation_timer = 0
	eye.animation_stage_time = 1 + (0.5 * 1 / Timer:getTimeLeftRatio()) -- sec
	if eye.type == 0 then
		eye.sprite = Quads.eye_0_idle[1]
		eye.current_animation = "eye_0_idle"
	elseif eye.type == 1 then
		eye.sprite = Quads.eye_1_idle[1]
		eye.current_animation = "eye_1_idle"
	elseif eye.type == 2 then
		eye.sprite = Quads.eye_2_idle[1]
		eye.current_animation = "eye_2_idle"
	elseif eye.type == 3 then
		eye.sprite = Quads.eye_3_idle[1]
		eye.current_animation = "eye_3_idle"
	elseif eye.type == 4 then
		eye.sprite = Quads.eye_4_idle[1]
		eye.current_animation = "eye_4_idle"
	elseif eye.type == 5 then
		eye.sprite = Quads.eye_5_idle[1]
		eye.current_animation = "eye_5_idle"
	elseif eye.type == 6 then
		eye.sprite = Quads.eye_6_idle[1]
		eye.current_animation = "eye_6_idle"
	elseif eye.type == 7 then
		-- BONE
		local bone_sprite = tostring(love.math.random(0, 3))
		eye.sprite = Quads["bones_" .. bone_sprite]
		eye.current_animation = ""
		eye.x_flip = love.math.random(0, 1)
		eye.y_flip = love.math.random(0, 1)
	elseif eye.type == 8 then
		eye.sprite = Quads.pent
		eye.current_animation = ""
	end
	setmetatable(eye, self)
	return eye
end

function Eye:update(dt)
	if self.type < 7 then
		self.animation_timer = self.animation_timer + dt
		if self.animation_timer >= self.animation_stage_time then
			self.animation_timer = 0
			if self.current_animation_frame >= #Quads[self.current_animation] then
				self.current_animation_frame = 1
			else
				self.current_animation_frame =
						self.current_animation_frame + 1
			end
			self.sprite = Quads[self.current_animation][self.current_animation_frame]
		end
	end
end

function Eye:draw()
	if self.type ~= 99 then
		Actor.draw(self)
	end
end
