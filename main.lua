function love.load(_argc, _argv)
    --^libs^--
    --#graphicals libs#--
    gs = require "libs/gamestate"
    chatBox = require "libs/chatBox"
    --^tables^--
    --#gamestate states#--
    states = {}
    states.firstState = require "src/states/firstState"
    --^vars^--
    font = love.graphics.setNewFont(12) --defaultFont
    --^cmds^--
    love.graphics.setDefaultFilter("nearest", "nearest") --defaultfilter
    gs.registerEvents({"update"; "textinput"; "textedited"; "keypressed"; "touchpressed"; "touchmoved"; "touchreleased"})
    gs.switch(states.firstState)
end

function love.draw() gs.current():draw() end

function love.textedited(_t, _s, _l) suit.textedited(_t, _s, _l) end

function love.keypressed(_k) suit.keypressed(_k) end

function love.textinput(_t) suit.keypressed(_t) end