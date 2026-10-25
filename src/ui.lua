--- @Class UI
UI = {}
UI.__index = UI

UI.timer_text_x = 0
UI.timer_text_y = 50

UI.score_text_x = 0
UI.score_text_y = 25

UI.highscore_text_x = 0
UI.highscore_text_y = 0

UI.combo_multi_text_x = 0
UI.combo_multi_text_y = 75

function UI:drawGameText()
  love.graphics.setFont(Fonts.game_ui_font)
  love.graphics.print(string.format("SCORE: %.0f", tostring(PLAYER.score)), self.score_text_x, self.score_text_y)
  if Grid.bones_enabled then
    love.graphics.print(string.format("HIGH: %.0f", tostring(PLAYER.high_score_bone_mode)), self.highscore_text_x,
      self.highscore_text_y)
  else
    love.graphics.print(string.format("HIGH: %.0f", tostring(PLAYER.high_score)), self.highscore_text_x,
      self.highscore_text_y)
  end
  love.graphics.print(string.format("COMBO: %.2f", tostring(PLAYER.combo_multi)), self.combo_multi_text_x,
    self.combo_multi_text_y)
  -- love.graphics.print(string.format("COMBOTIME: %.3f", tostring(self.combo_timer)), 0, 36)
  love.graphics.print(string.format("TIME: %.2f", tostring(Timer.game_time_left)), self.timer_text_x, self.timer_text_y)
end

function UI:updateGame(dt)

end

function UI:drawIntroText()
  love.graphics.setFont(Fonts.intro_font)
  if PLAYER.high_score > 0 then
    love.graphics.print(string.format("HIGH: %.0f", tostring(PLAYER.high_score)), self.highscore_text_x,
      self.highscore_text_y)
  end
  if PLAYER.high_score_bone_mode > 0 then
    love.graphics.print(string.format("HIGH (BONES): %.0f", tostring(PLAYER.high_score_bone_mode)), self
      .highscore_text_x,
      self.highscore_text_y + 25)
  end
  if PLAYER.total_bone_pickups > 0 then
    love.graphics.print(string.format("BONES: %.0f", tostring(PLAYER.total_bone_pickups)), self.highscore_text_x,
      self.highscore_text_y + 50)
  end
end

function UI:drawIntroButts()
  Start_Button:draw()
  if PLAYER.high_score > 12000 then
    Start_Bones_Button:draw()
  end
end

function UI:updateIntro(dt)
  Start_Button:update(dt)
  if PLAYER.high_score > 12000 then
    Start_Bones_Button:update(dt)
  end
end

function UI:drawEndText()

end
