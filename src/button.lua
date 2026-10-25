Quads.butt_highlight = love.graphics.newQuad(0, 512 + 64, 32 * 3, 32 * 2, Spritesheet)
--- @class Start_Button : Actor
Start_Button = setmetatable({}, { __index = Actor })
Start_Button.__index = Start_Button

Start_Button.sprite = love.graphics.newQuad(0, 448, 32 * 3, 32 * 2, Spritesheet)
Start_Button.clicked = false
Start_Button.x = 360
Start_Button.y = GAME_HEIGHT - 64 - 8
Start_Button.w = 32 * 3
Start_Button.h = 64
Start_Button.collision_x = Start_Button.x
Start_Button.collision_y = Start_Button.y
Start_Button.collision_w = Start_Button.w
Start_Button.collision_h = Start_Button.h
Start_Button.highlight = false

function Start_Button:update(dt)
  if self.clicked then
    self.clicked = false
    Game_State = Game_States.GAME
    Grid.bones_enabled = false
    if PLAYER.high_score_bone_mode > 0 then
      if love.math.random(0, 1) == 0 then
        Sound:playTrack("intro_bgm", true, 0.7)
      else
        Sound:playTrack("game_bgm", true, 0.7)
      end
    else
      Sound:playTrack("game_bgm", true, 0.7)
    end
  end
  if self:collisionCheck(PLAYER) then
    self.highlight = true
  else
    self.highlight = false
  end
end

function Start_Button:draw()
  Actor.draw(self)
  if self.highlight then
    love.graphics.draw(Spritesheet, Quads.butt_highlight, self.x, self.y)
  end
end

--- @class Start_Bones_Button : Actor
Start_Bones_Button = setmetatable({}, { __index = Actor })
Start_Bones_Button.__index = Start_Bones_Button

Start_Bones_Button.sprite = love.graphics.newQuad(0, 512, 32 * 3, 32 * 2, Spritesheet)
Start_Bones_Button.clicked = false
Start_Bones_Button.x = 360
Start_Bones_Button.y = GAME_HEIGHT - 64 - 8 - 68
Start_Bones_Button.w = 32 * 3
Start_Bones_Button.h = 64
Start_Bones_Button.collision_x = Start_Bones_Button.x
Start_Bones_Button.collision_y = Start_Bones_Button.y
Start_Bones_Button.collision_w = Start_Bones_Button.w
Start_Bones_Button.collision_h = Start_Bones_Button.h
Start_Bones_Button.highlight = false

function Start_Bones_Button:update(dt)
  if self.clicked then
    self.clicked = false
    Game_State = Game_States.GAME
    Grid.bones_enabled = true
    Sound:playTrack("intro_bgm", true, 0.85)
  end
  if self:collisionCheck(PLAYER) then
    self.highlight = true
  else
    self.highlight = false
  end
end

function Start_Bones_Button:draw()
  Actor.draw(self)
  if self.highlight then
    love.graphics.draw(Spritesheet, Quads.butt_highlight, self.x, self.y)
  end
end
