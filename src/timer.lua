--- @Class Timer
Timer = {}
Timer.__index = Timer

Timer.game_time_max = 66.6
Timer.game_time_left = 66.6

function Timer:update(dt)
  self.game_time_left = self.game_time_left - dt
end

function Timer:getTimeLeft()
  return self.game_time_left
end

function Timer:getTimeLeftRatio()
  return self.game_time_left / self.game_time_max
end

function Timer:reset()
  self.game_time_left = Timer.game_time_max
end
