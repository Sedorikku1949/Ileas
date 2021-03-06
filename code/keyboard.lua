function keyboard(key, state, held)
  if state == 1 or (state == 2 and held >= KEYS[".data"].heldTime and math.round(held / KEYS[".data"].heldTimeBetween) > KEYS[key].last) then
    KEYS[key].last = math.round(held / KEYS[".data"].heldTimeBetween);

    print("Touch: " .. key)

    if STATE == "menu" then
      -- menu
      if MENU_CTG == "main" then
        if key == "right" then
          if EXIT_DIALOG then
            EXIT_SELECTED = (EXIT_SELECTED + 1) % 2
          end
        elseif key == "left" then
          if EXIT_DIALOG then
            EXIT_SELECTED = (EXIT_SELECTED - 1) % 2
          end
        elseif key == "down" and not EXIT_DIALOG then
          MENU_SELECTED = (5 + (MENU_SELECTED + 1)) % 5
        elseif key == "up" and not EXIT_DIALOG then
          MENU_SELECTED = (5 + (MENU_SELECTED - 1)) % 5
        elseif key == "return" then
          -- check what is the category
          if MENU_SELECTED == 0 then
            -- new game
            print("new game")
            MENU_CTG = "new";
            INIT_GAME();
          elseif MENU_SELECTED == 1 then
            -- load game
            print("load game")
            MENU_CTG = "load"
          elseif MENU_SELECTED == 2 then
            -- options
            print("options")
            MENU_CTG = "options"
          elseif MENU_SELECTED == 3 then
            -- success
            print("success")
            MENU_CTG = "success"
          elseif MENU_SELECTED == 4 then
            -- exit
            if EXIT_DIALOG == true then
              if EXIT_SELECTED == 1 then
                -- keep open
                print("keep open")
                EXIT_DIALOG = false;
                EXIT_SELECTED = 1;
              else
                love.event.quit(0)
              end
            else
              EXIT_DIALOG = true
            end
          end
        end
      elseif key == "escape" and table.contains({"success", "new", "load"}, MENU_CTG) then
        MENU_CTG = "main";
      elseif MENU_CTG == "options" then
        if OPTIONS_CTG == "select" then
          if key == "escape" then
            MENU_CTG = "main";
          end
        end
      end
    elseif STATE == "game" then
      -- game
      if key == "escape" then
        MENU_CTG = "main";
        STATE = "menu"
      else 
        
        if key == "up" and (KEYS["right"].state == 0 and KEYS["left"].state == 0 and KEYS["down"].state == 0) then
          -- up
          PLAYER_MOVE = "UP"
        elseif key == "down" and (KEYS["right"].state == 0 and KEYS["left"].state == 0 and KEYS["up"].state == 0) then
          -- down
          PLAYER_MOVE = "DOWN"
        elseif key == "right" and (KEYS["down"].state == 0 and KEYS["up"].state == 0 and KEYS["left"].state == 0) then
          -- right
          PLAYER_MOVE = "RIGHT"
        elseif key == "left" and (KEYS["down"].state == 0 and KEYS["up"].state == 0 and KEYS["right"].state == 0) then
          -- left
          PLAYER_MOVE = "LEFT"
        elseif key == "up" and (KEYS["right"].state ~= 0 and KEYS["left"].state == 0 and KEYS["down"].state == 0) then
          -- up right
          PLAYER_MOVE = "UP_RIGHT"
        elseif key == "up" and (KEYS["left"].state ~= 0 and KEYS["right"].state == 0 and KEYS["down"].state == 0) then
          -- up left
          PLAYER_MOVE = "UP_LEFT"
        elseif key == "down" and (KEYS["right"].state ~= 0 and KEYS["left"].state == 0) then
          -- down right
          PLAYER_MOVE = "DOWN_RIGHT"
        elseif key == "down" and (KEYS["left"].state ~= 0 and KEYS["right"].state == 0) then
          -- down left
          PLAYER_MOVE = "DOWN_LEFT"
        elseif KEYS["up"].state ~= 0 and KEYS["down"].state ~= 0 and KEYS["left"].state ~= 0 and KEYS["right"].state ~= 0 then
          PLAYER_MOVE = "IDLE_DOWN"
        end;
        
        if key == "lshift" or key == "rshift" then
          -- sneak
          MAX_PLAYER_MOVE = MAX_PLAYER_MOVE / 3;
        elseif key ~= "lshift" and key ~= "rshift" then
          MAX_PLAYER_MOVE = DEFAULT_MAX_PLAYER_MOVE
        end

      end
    end
  end
end



function love.keypressed(key)
  if KEYS[key] then
    KEYS[key].state = 1;
  end
end


function love.keyreleased(key)
  if KEYS[key] then
    KEYS[key].state = 3;
  end
end