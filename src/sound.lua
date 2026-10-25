--- @Class Sound
Sound = {}
Sound.__index = Sound

Sound_FX.hex_added = love.audio.newSource("res/sounds/hex_talk.wav", "static")
Sound_FX.hex_triggered = love.audio.newSource("res/sounds/hex_trigger.wav", "static")
Sound_FX.clear_1 = love.audio.newSource("res/sounds/clear_1.wav", "static")
Sound_FX.clear_2 = love.audio.newSource("res/sounds/clear_2.wav", "static")
Sound_FX.clear_3 = love.audio.newSource("res/sounds/clear_3.wav", "static")
Sound_FX.clear_4 = love.audio.newSource("res/sounds/clear_4.wav", "static")
Sound_FX.stack_1 = love.audio.newSource("res/sounds/stack_1.wav", "static")
Sound_FX.stack_2 = love.audio.newSource("res/sounds/stack_2.wav", "static")
Sound_FX.skele_talk_1 = love.audio.newSource("res/sounds/skele_talk_1.wav", "static")
Sound_FX.skele_talk_2 = love.audio.newSource("res/sounds/skele_talk_2.wav", "static")
Sound_FX.skele_talk_3 = love.audio.newSource("res/sounds/skele_talk_3.wav", "static")

Music.game_bgm = love.audio.newSource("res/sounds/fun_shh.ogg", "stream")
Music.game_bgm:setLooping(true)
Music.intro_bgm = love.audio.newSource("res/sounds/intro_trimmed.ogg", "stream")
Music.intro_bgm:setLooping(true)


Sound.currently_playing = ""

function Sound:playTrack(track_id, looping, volume)
  local track = track_id or "intro_bgm"
  local loop = looping or true
  local vol = volume or 0.8
  if self.currently_playing ~= "" then
    self:stopTrack()
  end
  Music[track]:setLooping(loop)
  Music[track]:play()
  Music[track]:setVolume(vol)
  self.currently_playing = track
end

function Sound:stopTrack()
  Music[self.currently_playing]:stop()
  self.currently_playing = ""
end

function Sound:playSFX(sfx_id, volume, pan)
  local vol = volume or 1
  local pos = pan or 0
  Sound_FX[sfx_id]:setVolume(vol)
  if Sound_FX[sfx_id]:getChannelCount() == 1 then
    Sound_FX[sfx_id]:setPosition(pos, 0, 0)
  end
  Sound_FX[sfx_id]:clone():play()
end
