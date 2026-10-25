function mainUpdate(dt)
  Input:poll(dt)
  if Game_State == Game_States.GAME then
    if Game_Phase == Game_Phases.PLAYER then
      PLAYER:update(dt)
      NARRATOR:update(dt)
      updateAll(Explosions, dt)
      updateAll(Buttons, dt)
      Grid:update(dt)
      Timer:update(dt)
      if Timer:getTimeLeft() <= 0 then Game_State = Game_States.END end
      UI:updateGame(dt)
    elseif Game_Phase == Game_Phases.UPDATE_BOARD then
      Grid:update(dt)
      updateAll(Explosions, dt)
    end
  elseif Game_State == Game_States.INTRO then
    PLAYER:update(dt)
    NARRATOR:update(dt)
    UI:updateIntro(dt)
  elseif Game_State == Game_States.END then
    if not Grid.bones_enabled and PLAYER.high_score < PLAYER.score then
      PLAYER.high_score = PLAYER.score
    elseif Grid.bones_enabled and PLAYER.high_score_bone_mode < PLAYER.score then
      PLAYER.high_score_bone_mode = PLAYER.score
    end
    -- clean up
    resetGame()
    Sound:stopTrack()
    Game_State = Game_States.INTRO
  end
end

function updateAll(array, dt)
  if #array > 0 then
    local keep = 1                    -- index that tracks open spots to keep values
    for i = 1, #array, 1 do
      if not array[i]:update(dt) then -- update returns true if an item needs to be removed
        if i ~= keep then
          array[keep] = array[i]
          array[i] = nil
        end
        keep = keep + 1
      else
        array[i] = nil
      end
    end
  end
end
