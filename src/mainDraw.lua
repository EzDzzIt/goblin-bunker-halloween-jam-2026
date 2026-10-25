function mainDraw()
  love.graphics.setCanvas(GAME_CANVAS)
  love.graphics.clear(Colors[1])
  if Game_State == Game_States.GAME then
    NARRATOR:draw()
    Grid:draw()
    drawAll(Actors)
    drawAll(Explosions)
    UI:drawGameText()
  elseif Game_State == Game_States.INTRO then
    NARRATOR:draw()
    NARRATOR:drawDialogue()
    UI:drawIntroText()
    UI:drawIntroButts()
  elseif Game_State == Game_States.END then
    UI:drawEndText()
  end
  love.graphics.setCanvas()
  love.graphics.draw(GAME_CANVAS, 0, 0, 0, UPSCALE, UPSCALE)
end

function drawAll(array)
  if #array > 0 then
    for i = 1, #array do
      array[i]:draw()
    end
  end
end
