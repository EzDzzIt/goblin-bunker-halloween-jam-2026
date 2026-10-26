--- @class Grid
Grid = {}
Grid.__index = Grid

Grid.x_px = TILE_SIZE_X
Grid.y_px = TILE_SIZE_Y
Grid.x = 7 * 32 - 8
Grid.y = 8
Grid.row_count = 8
Grid.col_count = 8
Grid.grid_cell_selected_sprite = love.graphics.newQuad(0, 0, Grid.x_px, Grid.y_px, Spritesheet)
Grid.cells = {}
Grid.bone_count = 0
Grid.callDownTimerMax = 0.06
Grid.callDownTimer = Grid.callDownTimerMax
Grid.bones_enabled = false

function Grid:load()
  for i = 1, 10000 do
    self:generateNewGrid()
    if not self:checkGridForMatches() then
      if self:confirmMatchAvailable() then break end
    end
  end
end

function Grid:reset()
  self.bone_count = 0
  self.row_count = 8
  self.col_count = 8
  self.cells = {}
  self.bone_count = 0
  self.bones_enabled = false
  self.callDownTimer = self.callDownTimerMax
  self.hex_timer = self.hex_timer_max
  self:load()
end

function Grid:generateNewGrid()
  for row = 0, self.row_count - 1 do
    self.cells[row + 1] = {} -- add a new row
    for col = 0, self.col_count - 1 do
      self:addEyeBasic(row, col)
    end
  end
end

function Grid:checkGridForMatches()
  local found_match = false
  for row = 0, self.row_count - 1 do
    for col = 0, self.col_count - 1 do
      -- DEBUG next next
      if self.cells[row + 1][col + 1].matched then found_match = true end
      local type = self.cells[row + 1][col + 1].type
      -- check cells to the right if they exist
      if self.cells[row + 1][col + 2] and self.cells[row + 1][col + 3] then
        if type == self.cells[row + 1][col + 2].type then
          if type == self.cells[row + 1][col + 3].type then
            self.cells[row + 1][col + 3].matched = true
            self.cells[row + 1][col + 2].matched = true
            self.cells[row + 1][col + 1].matched = true
            for i = 4, self.col_count - 1 do
              if col + i > self.col_count then break end
              if type == self.cells[row + 1][col + i].type then
                self.cells[row + 1][col + i].matched = true
              else
                break
              end
            end
            found_match = true
          end
        end
      end
      -- check cells up/down if they exist
      if row <= self.row_count - 3 then
        if type == self.cells[row + 2][col + 1].type then
          if type == self.cells[row + 3][col + 1].type then
            self.cells[row + 3][col + 1].matched = true
            self.cells[row + 2][col + 1].matched = true
            self.cells[row + 1][col + 1].matched = true
            for i = 4, self.row_count - 1 do
              if row + i > self.row_count then break end
              if type == self.cells[row + i][col + 1].type then
                self.cells[row + i][col + 1].matched = true
              else
                break
              end
            end
            found_match = true
          end
        end
      end
    end
  end
  return found_match
end

function Grid:confirmMatchAvailable()
  for row = 0, self.row_count - 1 do
    for col = 0, self.col_count - 1 do
      local type = self.cells[row + 1][col + 1].type
      -- check cells to the right for a potential match
      if self.cells[row + 1][col + 2] and self.cells[row + 1][col + 4] then
        if type == self.cells[row + 1][col + 2].type then
          if type == self.cells[row + 1][col + 4].type then
            return true
          end
        elseif type == self.cells[row + 1][col + 3].type then
          if type == self.cells[row + 1][col + 4].type then
            return true
          end
        end
        -- check vertical switch for two right spots
        -- make sure the two to the right exist and we are not on the top or bottom rows
      elseif self.cells[row + 1][col + 2] and self.cells[row + 1][col + 3] then
        if type == self.cells[row + 1][col + 2].type then
          if row > 0 then
            if type == self.cells[row][col + 3].type then
              return true
            end
          end
          if row < self.row_count - 1 then
            if type == self.cells[row + 2][col + 3].type then
              return true
            end
          end
        end
      end
      -- and up/down
      if row <= self.row_count - 4 then
        -- if self.cells[row + 2][col + 1] and self.cells[row + 4][col + 1] then
        if type == self.cells[row + 2][col + 1].type then
          if type == self.cells[row + 4][col + 1].type then
            return true
          end
        elseif type == self.cells[row + 3][col + 1].type then
          if type == self.cells[row + 4][col + 1].type then
            return true
          end
        end
      end
    end
  end
  return false -- no matches available
end

function Grid:trySwap(swap_row, swap_col)
  local swap_cell_type = self.cells[swap_row][swap_col].type
  local swap_cell_sprite = self.cells[swap_row][swap_col].sprite
  local swap_cell_anim = self.cells[swap_row][swap_col].current_animation
  local swap_cell_x_flip = self.cells[swap_row][swap_col].x_flip
  local swap_cell_y_flip = self.cells[swap_row][swap_col].y_flip
  local selected_cell_type = self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].type
  local selected_cell_sprite = self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].sprite
  local selected_cell_anim = self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].current_animation
  local selected_cell_x_flip = self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].x_flip
  local selected_cell_y_flip = self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].y_flip
  self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].type = swap_cell_type
  self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].sprite = swap_cell_sprite
  self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].current_animation = swap_cell_anim
  self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].x_flip = swap_cell_x_flip
  self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].y_flip = swap_cell_y_flip
  self.cells[swap_row][swap_col].type = selected_cell_type
  self.cells[swap_row][swap_col].sprite = selected_cell_sprite
  self.cells[swap_row][swap_col].current_animation = selected_cell_anim
  self.cells[swap_row][swap_col].x_flip = selected_cell_x_flip
  self.cells[swap_row][swap_col].y_flip = selected_cell_y_flip
  if self:checkGridForMatches() then
    self:doMatch()
    return true
  else
    -- swap back if it wasn't a match
    self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].type = selected_cell_type
    self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].sprite = selected_cell_sprite
    self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].current_animation = selected_cell_anim
    self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].x_flip = selected_cell_x_flip
    self.cells[Input.stored_cell[1] + 1][Input.stored_cell[2] + 1].y_flip = selected_cell_y_flip
    self.cells[swap_row][swap_col].type = swap_cell_type
    self.cells[swap_row][swap_col].sprite = swap_cell_sprite
    self.cells[swap_row][swap_col].current_animation = swap_cell_anim
    self.cells[swap_row][swap_col].x_flip = swap_cell_x_flip
    self.cells[swap_row][swap_col].y_flip = swap_cell_y_flip
    return false
  end
end

function Grid:doMatch()
  local match_count = 0
  for col = 0, self.col_count - 1 do
    for row = self.row_count - 1, 0, -1 do
      local current_cell = self.cells[row + 1][col + 1]
      if current_cell.matched then
        match_count = match_count + 1
        PLAYER:addScore(current_cell.type)
        if current_cell.type == 7 then
          self.bone_count = self.bone_count - 1
          if not current_cell.hexed then
            PLAYER.total_bone_pickups = PLAYER.total_bone_pickups + 1
            -- print("bone count: " .. PLAYER.total_bone_pickups)
          else
          end
        end
        local ex_color = nil
        if match_count > 3 then ex_color = Colors[3] end
        Explosion:addExplosions({ count = 3, x = current_cell.x, y = current_cell.y, color = ex_color })
        current_cell.type = 99
        -- current_cell.matched = false
      end
      -- reset
      current_cell.hexed = false
    end
  end
  if match_count > 0 then
    local sfx = tostring(love.math.random(1, 4))
    Sound:playSFX("clear_" .. sfx)
    Game_Phase = Game_Phases.UPDATE_BOARD
  end
end

function Grid:callDown()
  for col = 0, self.col_count - 1 do
    for row = 0, self.row_count - 1 do
      local current_cell = self.cells[row + 1][col + 1]
      if current_cell.matched or current_cell.falling then
        if row == 0 then
          self:addEye(row, col)
        else
          current_cell.sprite = self.cells[row][col + 1].sprite
          current_cell.type = self.cells[row][col + 1].type
          current_cell.x_flip = self.cells[row][col + 1].x_flip
          current_cell.y_flip = self.cells[row][col + 1].y_flip
          current_cell.current_animation = self.cells[row][col + 1].current_animation
          current_cell.matched = false
          current_cell.falling = false
          self.cells[row][col + 1].falling = true
          self.cells[row][col + 1].type = 99
        end
      end
    end
  end
end

function Grid:addEyeBasic(row, col, type)
  self.cells[row + 1][col + 1] = Eye:new({
    x = self.x + col * self.x_px,
    y = self.y + row * self.y_px,
    type = type or love.math.random(0, 6)
  })
end

function Grid:addEye(row, col)
  local addBone = false
  local eyeType = love.math.random(0, 6)
  if self.bones_enabled then
    if self.bone_count == 0 then
      addBone = true
    elseif self.bone_count <= 12 then
      if love.math.random(0, 100) > 85 then
        addBone = true
      end
    end
    if addBone then
      eyeType = 7
      self.bone_count = self.bone_count + 1
    end
  end
  self.cells[row + 1][col + 1] = Eye:new({
    x = self.x + col * self.x_px,
    y = self.y + row * self.y_px,
    type = eyeType
  })
end

function Grid:doHex(row, col)
  for ex_row = -1, 1, 1 do
    for ex_col = -1, 1, 1 do
      if row + ex_row > 0 and row + ex_row <= self.row_count then
        if col + ex_col > 0 and col + ex_col <= self.col_count then
          self.cells[row + ex_row][col + ex_col].matched = true
          self.cells[row + ex_row][col + ex_col].hexed = true
        end
      end
    end
  end
  Sound:playSFX("hex_triggered", 0.5, love.math.random(-1, 1))
  if self:checkGridForMatches() then
    self:doMatch()
  end
end

Grid.hex_timer_max = 6.66
Grid.hex_timer = Grid.hex_timer_max

function Grid:checkEvents(dt)
  local time = Timer:getTimeLeft()
  if self.hex_timer <= 0 then
    for i = 1, 20 do
      local rand_row = love.math.random(2, self.row_count - 1)
      local rand_col = love.math.random(2, self.col_count - 1)
      -- make a random cell a hex if we can
      if (not self.cells[rand_row][rand_col].selected) and self.cells[rand_row][rand_col].type < 7 then
        self:addEyeBasic(rand_row - 1, rand_col - 1, 8)
        self.hex_timer = self.hex_timer_max
        Sound:playSFX("hex_added", love.math.random(40, 50) * 0.01, love.math.random(-10, 10) * 0.1)
        break
      end
    end
  else
    self.hex_timer = self.hex_timer - dt
  end
end

function Grid:update(dt)
  local empty_cell_flag = false
  for row = 0, self.row_count - 1 do
    for col = 0, self.col_count - 1 do
      self.cells[row + 1][col + 1]:update(dt)
      if self.cells[row + 1][col + 1].type == 99 or self.cells[row + 1][col + 1].falling then
        empty_cell_flag = true
      end
    end
  end
  if Game_Phase == Game_Phases.UPDATE_BOARD then
    self.callDownTimer = self.callDownTimer - dt
    if empty_cell_flag and self.callDownTimer <= 0 then
      self:callDown()
      self.callDownTimer = self.callDownTimerMax
      local sfx = tostring(love.math.random(1, 2))
      Sound:playSFX("stack_" .. sfx, 0.2)
    elseif not empty_cell_flag and self.callDownTimer <= 0 then
      Game_Phase = Game_Phases.PLAYER
      self.callDownTimer = self.callDownTimerMax
      if self:checkGridForMatches() then
        self:doMatch()
      end
    end
  else
    -- stuff that happens
    -- should live in some level code
    -- but w/e
    self:checkEvents(dt)
  end
end

function Grid:draw()
  for row = 0, self.row_count - 1 do
    for col = 0, self.col_count - 1 do
      -- draw what's inside each cell
      Grid.cells[row + 1][col + 1]:draw()
      -- draw selector
      if self.cells[row + 1][col + 1].selected then
        love.graphics.draw(Spritesheet, self.grid_cell_selected_sprite, self.x + col * self.x_px,
          self.y + row * self.y_px)
      end
    end
  end
end
