--- @class Narrator : Actor
Narrator = {}
Narrator.__index = Narrator
setmetatable(Narrator, { __index = Actor })

Quads.narrator = love.graphics.newQuad(128, 288, 32 * 4, 32 * 4, Spritesheet)
Quads.friendship = love.graphics.newQuad(128, 416, 64, 32 * 3, Spritesheet)
Quads.nar_eye_1 = love.graphics.newQuad(256, 288, 32, 16, Spritesheet)
Quads.nar_eye_2 = love.graphics.newQuad(256, 288 + 16, 32, 16, Spritesheet)
Quads.nar_eye_3 = love.graphics.newQuad(256, 288 + 32, 32, 16, Spritesheet)

Dialogue = {}
Dialogue["low_1"] = "Simply match the EYES and I shall dine."
Dialogue["low_2"] = "It shouldn't be too hard..."
Dialogue["low_3"] = "Three in a row should do it."
Dialogue["low_4"] = "..."
Dialogue["low_5"] = "Activate HEXES to help along the way."
Dialogue["low_6"] = "Feed me as fast as you can..."
Dialogue["low_7"] = "...the ritual only lasts so long."
Dialogue["low_8"] = "..."
Dialogue["low_9"] = "...more EYES..."

Dialogue["med_1"] = "I am less hungry, but so lonely..."
Dialogue["med_2"] = "...food alone mends not my heart..."
Dialogue["med_3"] = "...keep an EYE out for BONES..."
Dialogue["med_4"] = "..."
Dialogue["med_5"] = "But please, do not HEX them..."
Dialogue["med_6"] = "HEXED BONES mend not my heart..."
Dialogue["med_7"] = "..."

Dialogue["plat_1"] = "Friendship is the real EYES and BONES!"
Dialogue["plat_2"] = "We both hunger..."
Dialogue["plat_3"] = "...but we dine together."
Dialogue["plat_4"] = "..."
Dialogue["plat_5"] = "..."
Dialogue["plat_6"] = "..."
Dialogue["plat_7"] = "..."
Dialogue["plat_8"] = "I wish to dance..."
Dialogue["plat_9"] = "But there is not enough music in this game..."

function Narrator:new()
  --- @class Narrator
  local nar = Actor:new({})
  nar.x = 5
  nar.y = 130
  nar.sprite = Quads.narrator
  nar.w = 32 * 4
  nar.h = 32 * 4
  nar.dialogue = "I hunger for EYES in the DARK."
  nar.dialogue_counter = 0
  nar.dialogue_x_position = love.math.random(8, 24)
  nar.dialogue_y_position = love.math.random(68, 80)
  nar.accum = 0
  setmetatable(nar, self)
  return nar
end

function Narrator:draw()
  Actor.draw(self)
  if PLAYER.high_score > 10000 then
    love.graphics.draw(Spritesheet, Quads.nar_eye_1, self.x + 28, self.y + 14)
  end
  if PLAYER.high_score > 15000 then
    love.graphics.draw(Spritesheet, Quads.nar_eye_2, self.x + 48, self.y + 13)
  end
  if PLAYER.high_score > 20000 then
    love.graphics.draw(Spritesheet, Quads.nar_eye_3, self.x + 39, self.y + 22)
  end
  if PLAYER.total_bone_pickups > 30 then
    love.graphics.draw(Spritesheet, Quads.friendship, self.x + self.w, self.y + 24)
  end
end

function Narrator:update(dt)
  if Game_State == Game_States.INTRO then
    self.accum = self.accum + dt
    local sin = math.sin(self.accum)
    self.x_vel = 48 * sin
    self.x = self.x + self.x_vel * dt
    -- self.y_vel = 8 * sin
    -- self.y = self.y + self.y_vel * dt
  elseif Game_State == Game_States.GAME then
    self.x = 5
    self.y = 130
  end
end

function Narrator:drawDialogue()
  if Game_State == Game_States.INTRO then
    love.graphics.print(self.dialogue, self.dialogue_x_position, self.dialogue_y_position)
  end
end

function Narrator:nextDialogue()
  self.dialogue_x_position = love.math.random(8, 16)
  self.dialogue_y_position = love.math.random(68, 80)
  self.dialogue_counter = self.dialogue_counter + 1
  if PLAYER.high_score < 6000 then
    if Dialogue["low_" .. self.dialogue_counter] then
      self.dialogue = Dialogue["low_" .. self.dialogue_counter]
    else
      self.dialogue_counter = 1
      self.dialogue = Dialogue["low_" .. self.dialogue_counter]
    end
  elseif PLAYER.total_bone_pickups < 30 then
    if Dialogue["med_" .. self.dialogue_counter] then
      self.dialogue = Dialogue["med_" .. self.dialogue_counter]
    else
      self.dialogue_counter = 1
      self.dialogue = Dialogue["med_" .. self.dialogue_counter]
    end
  else
    if Dialogue["plat_" .. self.dialogue_counter] then
      self.dialogue = Dialogue["plat_" .. self.dialogue_counter]
    else
      self.dialogue_counter = 1
      self.dialogue = Dialogue["plat_" .. self.dialogue_counter]
    end
  end
  local talk_sound = tostring(love.math.random(1, 3))
  Sound:playSFX("skele_talk_" .. talk_sound)
end

function Narrator:reset()
  self.dialogue = "You're back..."
  self.dialogue_counter = 0
  self.accum = 0
  self.x = 5
  self.y = 130
end
