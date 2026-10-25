--- @class Bone : Eye
Bone = setmetatable({}, { __index = Eye })
Bone.__index = Eye


function Bone:new(args)
  --- @class Bone
  local bone = Eye:new(args)
  bone.type = 8 -- reserved for bone
  bone.animation_stage_time = 0
  bone.sprite = love.graphics.random
end
