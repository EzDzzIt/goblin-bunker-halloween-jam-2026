--- @class Explosion : Actor
Explosion = {}
Explosion.__index = Explosion
setmetatable(Explosion, { __index = Actor })

Quads.ex_skull = love.graphics.newQuad(192, 224, 32, 32, Spritesheet)

function Explosion:new(args)
  --- @class Explosion
  local ex = Actor:new(args)
  ex.x = args.x + 16 or 0
  ex.y = args.y + 16 or 0
  local x_dir = love.math.random(0, 1)
  local y_dir = love.math.random(0, 1)
  if x_dir == 0 then x_dir = -1 end
  if y_dir == 0 then y_dir = -1 end
  ex.x_vel = love.math.random(100, 150) * x_dir
  ex.y_vel = love.math.random(100, 150) * y_dir
  ex.x_flip = love.math.random(0, 1)
  ex.y_flip = love.math.random(0, 1)
  ex.size = love.math.random(3)
  ex.color = args.color or { 1, 1, 1, 1 }
  ex.lifetime = 1.0
  ex.sprite = Quads.ex_skull
  setmetatable(ex, self)
  return ex
end

function Explosion:addExplosions(args)
  for i = 1, args.count do
    Explosions[#Explosions + 1] = Explosion:new(args)
  end
end

function Explosion:update(dt)
  self.x = self.x + self.x_vel * dt
  self.y = self.y + self.y_vel * dt
  self.lifetime = self.lifetime - dt
  if self.lifetime <= 0 then self.dead = true end
  if self.dead then return true else return false end
end

function Explosion:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.lifetime)
  -- love.graphics.circle("fill", self.x, self.y, self.size)
  local scale_x = 1
  local scale_y = 1
  local o_x = 0
  local o_y = 0
  if self.x_flip == 1 then
    scale_x = -1
    o_x = self.w
  end
  if self.y_flip == 1 then
    scale_y = -1
    o_y = self.h
  end
  love.graphics.draw(Spritesheet, self.sprite, self.x, self.y, 0, scale_x, scale_y, o_x, o_y)
  love.graphics.setColor({ 1, 1, 1, 1 })
end
