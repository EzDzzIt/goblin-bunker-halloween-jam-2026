--- @class Input
Input = {}
Input.__index = Input

Input.mapping = {}
Input.mouse_x = 0
Input.mouse_y = 0
Input.mouse_scaling = 1 / UPSCALE
Input.cell_selected = false
Input.stored_cell = { 0, 0 } -- x-y coord of cell in grid last clicked
-- Input.mouse_prev_x = 0
-- Input.mouse_prev_y = 0
-- Input.mouse_vel_x = 0
-- Input.mouse_vel_y = 0

function Input:poll(dt)
  if love.keyboard.isDown("escape") then
    -- love.event.quit()
    if Game_State == Game_States.GAME and Game_Phase == Game_Phases.PLAYER then
      Timer.game_time_left = 0.1
    end
  end
  -- local dt_inv = 1 / dt
  self.mouse_x, self.mouse_y = love.mouse.getPosition()
  self.mouse_x = self.mouse_x * self.mouse_scaling
  self.mouse_y = self.mouse_y * self.mouse_scaling
end

function love.mousepressed()
  if Game_State == Game_States.GAME and Game_Phase == Game_Phases.PLAYER then
    local select_flag = false
    -- start with if it's the second cell
    if Input.cell_selected then
      for row = 0, Grid.row_count - 1 do
        for col = 0, Grid.col_count - 1 do
          if not select_flag then -- "exit... kinda... early"
            if PLAYER:collisionCheck(Grid.cells[row + 1][col + 1]) then
              local stored_row, stored_col = Input.stored_cell[1], Input.stored_cell[2]
              -- is it a special cell?
              if Grid.cells[row + 1][col + 1].type == 8 then
                -- clicked a hex
                -- reset first
                -- honestly DEBUG
                Grid.cells[stored_row + 1][stored_col + 1].selected = false
                select_flag = true
                Input.cell_selected = false
                Grid:doHex(row + 1, col + 1)
              else
                -- is the cell adjacent?
                -- reset the selections
                Grid.cells[stored_row + 1][stored_col + 1].selected = false
                select_flag = true
                -- check the four adj tiles
                if (row == stored_row + 1 and col == stored_col) or (row == stored_row - 1 and col == stored_col) or (row == stored_row and col == stored_col + 1) or (row == stored_row and col == stored_col - 1) then
                  if Grid:trySwap(row + 1, col + 1) then
                    Input.cell_selected = false
                  else
                    Grid.cells[row + 1][col + 1].selected = true
                    Input.stored_cell = { row, col }
                  end
                else
                  Grid.cells[row + 1][col + 1].selected = true
                  Input.stored_cell = { row, col }
                end
              end
            end
          end
        end
      end
    else
      -- no cell currently selected
      for row = 0, Grid.row_count - 1 do
        for col = 0, Grid.col_count - 1 do
          if not select_flag then -- "exit early"
            if PLAYER:collisionCheck(Grid.cells[row + 1][col + 1]) then
              if Grid.cells[row + 1][col + 1].type == 8 then
                -- clicked a hex
                Grid:doHex(row + 1, col + 1)
              else
                Grid.cells[row + 1][col + 1].selected = true
                select_flag = true
                Input.cell_selected = true
                Input.stored_cell = { row, col }
              end
            end
          end
        end
      end
    end
  end
  -- other state?
  if Game_State == Game_States.INTRO then
    if PLAYER:collisionCheck(Start_Button) then
      Start_Button.clicked = true
    elseif PLAYER:collisionCheck(Start_Bones_Button) then
      Start_Bones_Button.clicked = true
    else
      NARRATOR:nextDialogue()
    end
  end
end

function Input:set()

end
