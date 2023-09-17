--               [[private]]               --
local CHATBOX = {} --module
CHATBOX.tx, CHATBOX.ty = nil, nil
CHATBOX.rx, CHATBOX.ry = nil, nil
--               [[public]]               --
--?make someone or someting say someting
--#_message is a tbl
--#_messageBox is a tbl
--#_people is a tbl
--#_x is a numb
--#_y is a numb
--#_w is a numb
--#_h is a numb
function CHATBOX.say(_message, _messageBox, _people, _x, _y, _w, _h)
--                       ^          ^           ^
--    message text settings/messagebox settinga/who are saying settings
    assert(type(_x) == "number", "bad argument to #4 expected number got " .. type(_x))
    assert(type(_y) == "number", "bad argument to #5 expected number got " .. type(_y))
    assert(type(_w) == "number", "bad argument to #6 expected number got " .. type(_w))
    assert(type(_h) == "number", "bad argument to #7 expected number got " .. type(_h))
    local _currentFont = love.graphics.getFont()
    --&message box
    if _messageBox then
        --%message box texture
        if _messageBox.color then love.graphics.setColor(_messageBox.color)
        else love.graphics.setColor(0, 0, 0, 1) end
        if _messageBox.texture then love.graphics.draw(_messageBox.texture, _x, _y, 0, _w / _messageBox.texture:getWidth(), _h / _messageBox.texture:getHeight())
        else love.graphics.rectangle("fill", _x, _y, _w, _h) end
        --%arrow
        if _messageBox.arrow then
            if _messageBox.arrow.setColor then love.graphics.setColor(_messageBox.arrow.setColor)
            else love.graphics.setColor(1, 1, 1, 1) end
            if _messageBox.arrow.texture then love.graphics.draw(_messageBox.arrow.texture, _x + (_messageBox.arrow.x or _w - _messageBox.arrow.texture:getWidth()), _y + (_messageBox.arrow.y or _h - _messageBox.arrow.texture:getHeight()), 0, _w / _people.arrow.texture:getWidth(), _h / _people.arrow.texture:getHeight())
            else love.graphics.print(">", _x + (_messageBox.arrow.x or _w - love.graphics.getFont():getWidth(">")), _y + (_messageBox.arrow.y or _h - love.graphics.getFont():getHeight())) end
        end
    end
    --&message text
    if _message then
        if _message.color then love.graphics.setColor(_message.color)
        else love.graphics.setColor(1, 1, 1, 1) end
        if _message.font then love.graphics.setFont(_message.font) end
        if _message.text then love.graphics.printf(_message.text, _x + (_message.x or 0), _y + (_message.y or 0), _w - (_message.x or 0), _message.align or "left") end
        love.graphics.setFont(_currentFont)
        if _message.isReleased and CHATBOX.rx and CHATBOX.ry then if CHATBOX.rx > _x and CHATBOX.ry > _y and CHATBOX.rx < _x + _w and CHATBOX.ry < _y + _h then  _message.isReleased() end end
        if _message.isPressed and CHATBOX.tx and CHATBOX.ty then if CHATBOX.tx > _x and CHATBOX.ty > _y and CHATBOX.tx < _x + _w and CHATBOX.ty < _y + _h then  _message.isReleased() end end
    end
    --&people
    if _people then
        if _people.name then
            --%people name box texture
            if _people.name.box then
                if _people.name.box.color then love.graphics.setColor(_people.name.box.color)
                else love.graphics.setColor(0, 0, 0, 1) end
                if _people.name.box.texture then love.graphics.draw(_people.name.box.texture, _x + (_people.name.box.x or 0), _y + (_people.name.box.y or -_people.name.box.texture:getHeight()), 0, (_people.name.box.w or love.graphics.getFont():getWidth(_people.name.text)) / _people.name.box.texture:getWidth(), (_people.name.box.h or love.graphics.getFont():getHeight()) / _people.name.box.texture:getHeight())
                else love.graphics.rectangle("fill", _x + (_people.name.box.x or 0), _y + (_people.name.box.y or -love.graphics.getFont():getHeight()), _people.name.box.w or love.graphics.getFont():getWidth(_people.name.text), _people.name.box.h or love.graphics.getFont():getHeight()) end
            end
            --%people name
            if _people.name.text then
                if _people.name.color then love.graphics.setColor(_people.name.color)
                else love.graphics.setColor(1, 1, 1, 1) end
                if _people.name.font then love.graphics.setFont(_people.name.font) end
                love.graphics.print(_people.name.text, _x + (_people.name.x or 0), _y + (_people.name.y or -love.graphics.getFont():getHeight()))
                love.graphics.setFont(_currentFont)
            end
        end
        --&people image
        if _people.image then
            --%people image frame
            if _people.image.frame then 
                if _people.image.frame.color then love.graphics.setColor(_people.image.frame.color)
                else love.graphics.setColor(1, 1, 1, 1) end
                if _people.image.frame.texture then love.graphics.draw(_people.image.frame.texture, _x + (_people.image.frame.x or 0), _y + (_people.image.frame.y or 0), 0, (_people.image.frame.w / _people.image.texture:getWidth()) or 1, (_people.image.frame.h / _people.image.texture:getHeight() or 1))
                else love.graphics.rectangle("fill", _x + (_people.image.frame.x or 0), _y + (_people.image.frame.y or 0), _people.image.frame.w or _people.image.texture:getWidth(), _people.image.texture.h or _people.image.texture:getHeight()) end
            end
            --%people picture 
            if _people.image.color then love.graphics.setColor(_people.image.color)
            else love.graphics.setColor(1, 1, 1, 1) end
            if _people.image.texture then love.graphics.draw(_people.image.texture, _x + (_people.image.x or 8), _y + (_people.image.y or 8), 0, _people.image.w / _people.image.texture:getWidth(), _people.image.h / _people.image.texture:getHeight())
            else love.graphics.rectangle("fill", _x + (_people.image.x or 0), _y + (_people.image.y or 0), 64, 64) end
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
end

--?make someting ask someting
--#_texture is a tbl
--#_answers is a tbl
--#_x is a numb
--#_y is a numb
--#_w is a numb
--#_h is a numb
function CHATBOX.ask(_texture, _answers, _w, _h)
    local _currentFont = love.graphics.getFont()
    for _, answer in ipairs(_answers) do
        --&background
        --%background color
        if answer.bgColor then love.graphics.setColor(answer.bgColor) 
        else love.graphics.setColor(0, 0, 0, .5) end
        if CHATBOX.tx and CHATBOX.ty then
            if CHATBOX.tx > answer.x and CHATBOX.ty > answer.y and CHATBOX.tx < answer.x + _w and CHATBOX.ty < answer.y + _h then
                if answer.bgColorPressed then love.graphics.setColor(answer.bgColorPressed)
                else love.graphics.setColor(.5, .5, .5, .5) end
            end
        end
        --%background texture
        if answer.texture then 
            if answer.texture.normal then love.graphics.draw(answer.texture.normal, answer.x, answer.y, 0, (_w or answer.text:getWidth()) / answer.texture.normal:getWidth(), (_h or answer.text:getWidth()) / answer.texture.normal:getHeight())
            elseif answer.texture.pressed and CHATBOX.tx > answer.x and CHATBOX.ty > answer.y and CHATBOX.tx < answer.x + _w and CHATBOX.ty < answer.y + _h then love.graphics.draw(answer.texture.pressed, _x, _y, 0, (_w or answer.text:getWidth()) / answer.texture.pressed:getWidth(), (_h or answer.text:getWidth()) / answer.texture.pressed:getHeight()) end
        elseif _texture then 
            if _texture.normal then love.graphics.draw(_texture.normal, answer.x, answer.y, 0, (_w or answer.text:getWidth()) / _texture.pressed:getWidth(), (_h or answer.text:getWidth()) / _texture.normal:getHeight())
            elseif _texture.pressd and CHATBOX.tx > answer.x and CHATBOX.ty > answer.y and CHATBOX.tx < answer.x + _w and CHATBOX.ty < answer.y + _h then love.graphics.draw(_texture.pressed, answer.x, answer.y, 0, (_w or answer.text:getWidth()) / _texture.pressed:getWidth(), (_h or answer.text:getWidth()) / _texture.pressed:getHeight())  end
        else love.graphics.rectangle("fill", answer.x, answer.y, _w or answer.text:getWidth(), _h or answer.text:getHeight()) end
        --%fontgrund color
        if answer.fgColor then love.graphics.setColor(answer.fgColor)
        else love.graphics.setColor(1, 1, 1, 1) end
        --%fontgrund text
        if answer.text.font then love.graphics.setFont(answer.text.font) end
        if answer.text.message then love.graphics.print(answer.text.message, answer.x + _w / 2 - _currentFont:getWidth(answer.text.message) / 2, answer.y + _h / 2 - _currentFont:getHeight() / 2, answer.text.y) end
        love.graphics.setFont(_currentFont)
        if answer.isPressed then if CHATBOX.rx and CHATBOX.ry then if CHATBOX.rx > answer.x and CHATBOX.ry > answer.y and CHATBOX.rx < answer.x + _w and CHATBOX.ry < answer.y + _h then answer.isPressed() end end end
    end
    love.graphics.setColor(1, 1, 1, 1)
end

-- function CHATBOX.update()
--     CHATBOX.rx, CHATBOX.ry = nil, nil
-- end

function CHATBOX.touchpressed(x, y)
    CHATBOX.tx, CHATBOX.ty = x, y
end

function CHATBOX.touchmoved(x, y)
    CHATBOX.tx, CHATBOX.ty = x, y
end

function CHATBOX.touchreleased(x, y)
    CHATBOX.rx, CHATBOX.ry = x, y
    CHATBOX.tx, CHATBOX.ty = nil, nil
end

return CHATBOX