function mainLoad()
  -- Get renderer details
  if DEBUG_ON then
    if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then require("lldebugger").start() end
    print("DEBUG INFO: ")
    print("gfx info: " .. love.graphics.getRendererInfo())
    print("love ver: " .. love.getVersion())
    print("os time: " .. os.time())
  end
  -- love.mouse.setVisible(false)
  love.graphics.setDefaultFilter("nearest")
  NARRATOR = Narrator:new()
  PLAYER = Player:new()
  Grid:load()
  -- intro tune
  -- Sound:playTrack()
end

function resetGame()
  PLAYER:reset()
  NARRATOR:reset()
  Timer:reset()
  Grid:reset()
  Explosions = {}
end
