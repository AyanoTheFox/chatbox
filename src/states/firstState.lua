firsState = {}

function firsState:enter(_argc, _argv)
    animegril = love.graphics.newImage("assets/images/animegril.png")
    animegrilportatil = love.graphics.newImage("assets/images/animegrilportatil.png")
    testVar = true
end

function firsState:draw()
    love.graphics.setBackgroundColor(1, 1, 1, 1)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print(tostring(testVar))
    love.graphics.rectangle("line", 32, 32, love.graphics.getWidth() - 64, love.graphics.getHeight())
    love.graphics.line(32, 32, 0, 0)
    love.graphics.line(love.graphics.getWidth() - 32, 32, love.graphics.getWidth(), 0)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(animegril, love.graphics.getWidth() / 2 - animegril:getWidth() / 2, 0)
    chatBox.say(
        {
            text = "ohayõu :3\ni'm a anime gril\nhow are you?";
            x = 80; y = 16;
            isReleased = function() testVar = false end
        },
        {
            color = {0; 0; 0; .5};
            texture = nil;
            arrow = {
                setColor = {1; 1; 1; 1};
                texture = nil;
                x = nil; y = nil
            }
        },
        {
            name = {
                box = {
                    texture = nil;
                    color = {0; 0; 0; .5};
                    w = 128
                };
                text = "Anime gril";
                color = {1; 0; 1; 1};
                x = 64 - love.graphics.getFont():getWidth("Anime gril") / 2; y = nil
            },
            image = {
                frame = {
                    texture = nil;
                    x = 0; y = 0; w = 80; h = 64
                };
                texture = animegrilportatil;
                w = 64; h = 64
            };
        },
        love.graphics.getWidth() / 2 - 200,
        love.graphics.getHeight() - 64,
        400,
        64
    )
    chatBox.ask(
        nil,
        {
            {
                bgColor = {0; 0; 0; .5};
                texture = nil;
                fgColor = {1; 1; 1; 1};
                text = {
                    message = "fine"
                };
                isPressed = function() end;
                x = love.graphics.getWidth() / 2 - 200; y = 128
            },
            {
                bgColor = {0; 0; 0; .5};
                texture = nil;
                fgColor = {1; 1; 1; 1};
                text = {
                    font = nil;
                    message = "bad"
                };
                isPressed = function() end;
                x = love.graphics.getWidth() / 2 - 200; y = 192
            }
        },
        400,
        16
    )
end

function firsState:update(_elapsed)
    --chatBox.update()
end

function firsState:touchpressed(_id, _x, _y, _dx, _dy, _pressed)
    chatBox.touchpressed(_x, _y)
end

function firsState:touchmoved(_id, _x, _y, _dx, _dy, _pressed)
    chatBox.touchmoved(_x, _y)
end

function firsState:touchreleased(_id, _x, _y, _dx, _dy, _pressed)
    chatBox.touchreleased(_x, _y)
end

return firsState