--get rid of model
vanilla_model.ALL:setVisible(false)

--remove shadow
renderer:shadowRadius(0)

--setup sprite
local sprite = models.model.Camera:newSprite("nextbot_texture")
sprite:setTexture(textures["texture"])

--IMPORTANT! size the texture renders as
local renderSizeX, renderSizeY = 50, 50

--set UV to whole texture, set position relative to anchor, set proper render type
sprite:setUV(0, 0):setRegion(sprite:getDimensions()):setSize(renderSizeX, renderSizeY):setPos(renderSizeX / 2, renderSizeY, 0):setRenderType("TRANSLUCENT")

--sound stuffs
local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

local currentSound

function pings.playSound(sound)
    currentSound = sounds:playSound(sound, player:getPos(), nil, nil, true)
end

function pings.stopSounds()
    currentSound = nil
    sounds:stopSound()
end

mainPage:newAction()
    :title("Stop All Sounds")
    :item("minecraft:barrier")
    :onLeftClick(function()
        pings.stopSounds()
    end)

for _, sound in ipairs(sounds:getCustomSounds()) do
    mainPage:newAction()
        :title("Play " .. sound)
        :item("minecraft:note_block")
        :onLeftClick(function()
            if currentSound then
                print("Already playing something!")
            else
                pings.playSound(sound)
            end
        end)
end

function events.tick()
    if currentSound then
        currentSound:setPos(player:getPos())
    end
end
