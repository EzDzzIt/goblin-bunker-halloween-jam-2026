--- @class Player : Actor
--- @field high_score number
--- @field score number
Player = {}
Player.__index = Player
setmetatable(Player, { __index = Actor })

function Player:new()
  --- @class Player
  local player = Actor:new({})
  player.x = 0
  player.y = 0
  player.w = 1
  player.h = 1
  player.collision_x = player.x
  player.collision_y = player.y
  player.collision_w = player.w
  player.collision_h = player.h
  player.score = 0
  player.high_score = 0
  player.high_score_bone_mode = 0
  player.combo_multi = 1
  player.combo_timer = 0
  player.combo_stage = 1
  player.score_flag = false
  player.total_bone_pickups = 0
  setmetatable(player, self)
  return player
end

function Player:update(dt)
  self.x = Input.mouse_x
  self.y = Input.mouse_y
  self.collision_x = self.x
  self.collision_y = self.y
  self.combo_match_count = 0
  -- combo
  if self.score_flag then
    self:refreshCombo()
    self.score_flag = false
    self.combo_match_count = 0
  end
  if self.combo_timer <= 0 then
    self.combo_multi = 1
  else
    self.combo_timer = self.combo_timer - dt
  end
end

function Player:addScore(type)
  if not Grid.bones_enabled then
    self.score = self.score + (10 * self.combo_multi)
  else
    if type == 7 then
      self.score = self.score + (100 * self.combo_multi)
    else
      self.score = self.score + (1 * self.combo_multi)
    end
  end
  self.score_flag = true
  self.combo_match_count = self.combo_match_count + 1
end

function Player:refreshCombo()
  if self.combo_timer > 0 then
    self.combo_timer = self.combo_timer + 2 -- sec
    self.combo_multi = self.combo_multi + 0.5 + (0.25 * self.combo_match_count)
  else
    self.combo_timer = 6.66
    self.combo_multi = self.combo_multi + 1
  end
end

function Player:reset()
  self.score = 0
  self.combo_multi = 1
  self.combo_timer = 0
  self.combo_stage = 1
  self.combo_match_count = 0
  self.score_flag = false
  Game_Phase = Game_Phases.PLAYER
end
