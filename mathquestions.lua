-- This file should be put into the "garrysmod/lua/ulx/modules/" folder.
-- For the chat announcements, special syntax is used to color the messages in coordination with SCB chatbox, so edit that accordingly if needed. ({*text} and {cyan text} are the syntaxes i used )

if SERVER then
    -- ULX Command: !enablemathquestions
    function ulx.enablemathquestions(calling_ply)
        if timer.Exists("MathQuestionTimer") then
            ULib.tsayError(calling_ply, "Math questions are already enabled.")
            return
        end

        -- Configuration
        local questionFrequency = 30 -- Time in seconds between each question
        local minNumber = 1 -- Minimum number for the addition question
        local maxNumber = 99 -- Maximum number for the addition question
        local resultFile = "correct_answers.txt" -- File to store correct answers

        -- Create a timer to send questions periodically
        timer.Create("MathQuestionTimer", questionFrequency, 0, function()
            local number1 = math.random(minNumber, maxNumber)
            local number2 = math.random(minNumber, maxNumber)
            local sum = number1 + number2
            local prefix = "{purple [VIP Giveaway Question]}"
            local question = string.format("%s What is %d + %d?", prefix, number1, number2)

            -- Send the question to all players
            for _, ply in ipairs(player.GetAll()) do
                ply:ChatPrint(question)

                -- Listen for answers from each player individually
                hook.Add("PlayerSay", "CheckMathAnswer_" .. ply:UserID(), function(sender, text)
                    if sender == ply and tonumber(text) == sum then
                        -- Write the first correct answer and SteamID to the file
                        file.Append(resultFile, ply:Nick() .. " (" .. ply:SteamID() .. ") answered " .. sum .. "\n")
                        
                        -- Remove the hook for this player to stop checking answers
                        hook.Remove("PlayerSay", "CheckMathAnswer_" .. ply:UserID())

                        -- Log the correct answer to the console
                        print(prefix .. " " .. ply:Nick() .. " answered correctly.")

                        -- Inform the server
                        timer.Simple(0, function()
                            PrintMessage(HUD_PRINTTALK, prefix .. " {* " .. ply:Nick() .. " was the first to answer correctly and has been added to our list of winners!}")
                        end)
                    end
                end)
            end
        end)

        ULib.tsay(calling_ply, "Math questions have been enabled.")
    end

    local enablemathquestions = ulx.command("Salad's Stuff", "ulx enablemathquestions", ulx.enablemathquestions, "!enablemathquestions")
    enablemathquestions:defaultAccess(ULib.ACCESS_SUPERADMIN)
    enablemathquestions:help("Enables the math question script.")

    -- ULX Command: !disablemathquestions
    function ulx.disablemathquestions(calling_ply)
        if not timer.Exists("MathQuestionTimer") then
            ULib.tsayError(calling_ply, "Math questions are already disabled.")
            return
        end

        timer.Remove("MathQuestionTimer")

        -- Remove all the answer checking hooks for each player
        for _, ply in ipairs(player.GetAll()) do
            hook.Remove("PlayerSay", "CheckMathAnswer_" .. ply:UserID())
        end

        ULib.tsay(calling_ply, "Math questions have been disabled.")
    end

    local disablemathquestions = ulx.command("Salad's Stuff", "ulx disablemathquestions", ulx.disablemathquestions, "!disablemathquestions")
    disablemathquestions:defaultAccess(ULib.ACCESS_SUPERADMIN)
    disablemathquestions:help("Disables the math question script.")
end
