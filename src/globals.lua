DEBUG_ON = true
GAME_HEIGHT = 270
GAME_WIDTH = 480
UPSCALE = 2
WINDOW_HEIGHT = GAME_HEIGHT * UPSCALE
WINDOW_WIDTH = GAME_WIDTH * UPSCALE
love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
GAME_CANVAS = love.graphics.newCanvas(GAME_WIDTH, GAME_HEIGHT)
GAME_CANVAS:setFilter("nearest", "nearest")
TILE_SIZE_X = 32
TILE_SIZE_Y = 32
Colors = {}
Colors[1] = { 29 / 255, 28 / 255, 36 / 255, 1 }   --
Colors[2] = { 146 / 255, 70 / 255, 81 / 255, 1 }  -- red eye 1
Colors[3] = { 67 / 255, 107 / 255, 103 / 255, 1 } --
Colors[4] = { 29 / 255, 28 / 255, 36 / 255, 1 }   --
Colors[5] = { 29 / 255, 28 / 255, 36 / 255, 1 }   --
Colors[6] = { 29 / 255, 28 / 255, 36 / 255, 1 }   --
Colors[7] = { 29 / 255, 28 / 255, 36 / 255, 1 }   --
Colors[8] = { 29 / 255, 28 / 255, 36 / 255, 1 }   --
Colors[9] = { 29 / 255, 28 / 255, 36 / 255, 1 }   --
Colors[10] = { 29 / 255, 28 / 255, 36 / 255, 1 }  --
Colors[11] = { 29 / 255, 28 / 255, 36 / 255, 1 }  --
Colors[12] = { 29 / 255, 28 / 255, 36 / 255, 1 }  --
Colors[13] = { 29 / 255, 28 / 255, 36 / 255, 1 }  --
Colors[14] = { 29 / 255, 28 / 255, 36 / 255, 1 }  --
Colors[15] = { 29 / 255, 28 / 255, 36 / 255, 1 }  --
Colors[16] = { 29 / 255, 28 / 255, 36 / 255, 1 }  --
Game_State = 1
Game_States = {}
Game_States.INTRO = 1
Game_States.GAME = 0
Game_States.END = 2
Game_Phase = 1
Game_Phase_Next = 1
Game_Phases = {}
Game_Phases.PLAYER_INIT = 0
Game_Phases.PLAYER = 1
Game_Phases.CHECK_INIT = 2
Game_Phases.CHECK = 3
Game_Phases.UPDATE_BOARD_INIT = 4
Game_Phases.UPDATE_BOARD = 5

Fonts = {}
Fonts.intro_font = love.graphics.newFont("res/fonts/XTypewriter_Font_0_96/TrueType (.ttf)/XTypewriter-Regular.ttf",
  20)
Fonts.game_ui_font = love.graphics.newFont("res/fonts/XTypewriter_Font_0_96/TrueType (.ttf)/XTypewriter-Regular.ttf",
  24)
Spritesheet = love.graphics.newImage("res/gfx/Spritesheet.png")
Quads = {}
Actors = {}
Explosions = {}
Buttons = {}
Sound_FX = {}
Music = {}

function updateGamePhase(queued_phase)
  Game_Phase_Next = queued_phase
end
