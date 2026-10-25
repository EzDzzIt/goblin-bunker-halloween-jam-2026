--- @class Actor
--- @field x number actor x-position
--- @field y number actor y-position
--- @field w number actor width
--- @field h number actor height
--- @field collision_x number
--- @field collision_y number
--- @field collision_w number
--- @field collision_h number
--- @field x_vel number actor x-velocity
--- @field y_vel number actor y-velocity
--- @field physics boolean actor physics enabled
--- @field sprite table spritesheet quad dimensions
--- @field x_flip any
--- @field y_flip any
Actor = {}
Actor.__index = Actor

function Actor:new(args)
  local actor = setmetatable({}, Actor)
  actor.x = args.x or 0
  actor.y = args.y or 0
  actor.w = args.w or TILE_SIZE_X
  actor.h = args.h or TILE_SIZE_Y
  actor.collision_x = args.collision_x or actor.x
  actor.collision_y = args.collision_y or actor.y
  actor.collision_w = args.collision_w or actor.w
  actor.collision_h = args.collision_h or actor.h
  actor.x_vel = args.x_vel or 0
  actor.y_vel = args.y_vel or 0
  actor.x_flip = args.x_flip or 0
  actor.y_flip = args.y_flip or 0
  -- actor.physics = args.physics or false
  actor.sprite = args.sprite or {}
  return actor
end

function Actor:update(dt)
  -- if self.physics then
  --   self:applyPhysics(dt)
  -- end
  if self.dead then return true else return false end
  -- return false -- returns true if actor needs to be removed
end

function Actor:applyPhysics(dt)
  -- apply forces
  -- gravity
  self.y_vel = self.y_vel + (100 * dt)
  self.y = self.y + self.y_vel * dt
end

function Actor:draw()
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
  -- love.graphics.rectangle("fill", self.x, self.y, 10, 10)
end

--collide function
function Actor:collisionCheck(object)
  if self.collision_x > object.collision_x + object.collision_w then return false end
  if self.collision_x + self.collision_w < object.collision_x then return false end
  if self.collision_y > object.collision_y + object.collision_h then return false end
  if self.collision_y + self.collision_h < object.collision_y then return false end
  return true
end
