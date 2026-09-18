local script = [==[
local sx, sy = guiGetScreenSize()
local sxx, syy = sx / 1920, sy / 1080
local textScale = math.min(math.max(sy / 1080, 0.7), 1.2)
local dxfont0_GPS = dxCreateFont("assets/fonts/GPS.ttf", textScale*21)
local dxfont1_GPS = dxCreateFont("assets/fonts/GPS.ttf", textScale*12)

local dxfont3_GPS, dx1Variables = dxCreateFont("assets/fonts/GPS.ttf", textScale*14), ""

local dxfont2_GPS, dx1values = dxCreateFont("assets/fonts/gilroy-semibold.ttf", textScale*12), ""

local dxfont2_Title = dxCreateFont("assets/fonts/Title.ttf", textScale*24)
local dxfont0_Title = dxCreateFont("assets/fonts/Title.ttf", textScale*14)

local dxfont0_gilroysemibold = dxCreateFont("assets/fonts/gilroy-semibold.ttf", textScale*19)
local dxfont1_gilroysemibold = dxCreateFont("assets/fonts/gilroy-semibold.ttf", textScale*13)

local text = "ZONE" 
local fontScale, font = 1.0, dxCreateFont("assets/fonts/GPS.ttf", textScale*10, true, "antialiased")
local dxfont55, dxGreenZone = dxCreateFont("assets/fonts/GPS.ttf", textScale*19, true, "antialiased"), ""
  
local renderTarget = dxCreateRenderTarget(dxGetTextWidth(text:gsub("#%x%x%x%x%x%x", ""), fontScale, font), dxGetFontHeight(fontScale, font), true) 
local shader = dxCreateShader("textureReplace.fx") 
  
function updateRenderTarget() 
    dxSetRenderTarget(renderTarget, true) 
    -- dxSetBlendMode('modulate_add')
    dxDrawText(text, 0, 0, 0, 0, tocolor(148, 220, 26, 255), fontScale, font) 
    -- dxSetBlendMode('blend')
    dxSetRenderTarget()
    dxSetShaderValue(shader, "tex", renderTarget) 
end 
  
addEventHandler("onClientRestore", root, 
function() 
     updateRenderTarget() 
end) 

local fadeStart
local duration = 2

function renderZone() 
    if not fadeStart then
        fadeStart = getTickCount()
    end

    local timeNow = getTickCount()
    local elapsed = timeNow - fadeStart

    -- Calculate the oscillating alpha value
    local progress = (elapsed / (duration * 1000)) % 1 -- Normalize elapsed time to a 0-1 range
    local alpha = math.floor((math.sin(progress * math.pi * 2) + 1) / 2 * 255)

    
    local textX, textY = sxx * 1823, syy * 195
    local textWidth, textHeight = sxx * (1888 - 1823), syy * (220 - 195)

    dxDrawText("GREEN", textX, textY, textX + textWidth, textY + textHeight, tocolor(141, 213, 29, alpha), 1.00, dxfont55, "right", "center", false, false, false, false, false)

    local shieldWidth, shieldHeight = sxx * 40, syy * 40
    local shieldOffsetX, shieldOffsetY = -40, -1
    local shieldX = textX + shieldOffsetX
    local shieldY = textY + ((textHeight - shieldHeight) / 2) + shieldOffsetY

    dxDrawImage(shieldX, shieldY, shieldWidth, shieldHeight, "assets/shield.png", 0, 0, 0, tocolor(255, 255, 255, alpha), false)

    local shaderPaddingX, shaderPaddingY = sxx * 65, syy * 4
    local shaderX = textX + shaderPaddingX
    local shaderY = textY + shaderPaddingY
    local shaderWidth, shaderHeight = dxGetMaterialSize(renderTarget)

    dxSetShaderTransform(shader, 0, 0, -90)
    dxDrawImage(shaderX, shaderY, shaderWidth, shaderHeight, shader, 0, 0, 0, tocolor(255, 255, 255, alpha))
end

local EventHandled = false
addEventHandler("onClientRender", root,
    function()

        dxDrawText(formatMoney(getPlayerMoney(localPlayer)), sxx * 1739, syy * 247, sxx * 1895, syy * 270, tocolor(255, 255, 255, 255), 1.00, dxfont0_gilroysemibold, "right", "center", false, false, false, false, false)
        local padding = -115

        local text = formatMoney(getElementData(localPlayer, Saif.MoneyBankData) or 0)
        local textX, textY, textW, textH = sxx * 1775, syy * 290, sxx * 1896, syy * 306
        
        local textWidth = dxGetTextWidth(text, 1.00, dxfont1_gilroysemibold)
        
        local imageW, imageH = 30, 32
        local imageX = textX - textWidth - imageW - padding * sxx
        local imageY = textY + (textH - textY) / 2 - imageH / 2*syy - 1
        
        dxDrawText(text, textX, textY, textW, textH, tocolor(255, 255, 255, 255), 1.00, dxfont1_gilroysemibold, "right", "center", false, false, false, false, false)
        dxDrawImage(imageX, imageY, sxx * imageW, syy * imageH, "assets/bank.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        
        if getElementData(localPlayer, Saif.GreenZoneData) == true then
            if not EventHandled then
            fadeStart = getTickCount()
            addEventHandler("onClientRender", root, renderZone)
            updateRenderTarget()
            EventHandled = true
            end
        else
            removeEventHandler("onClientRender", root, renderZone)
            EventHandled = false
        end
        ------------------------------------------------------------------------
        -- رقم السيرفر
        -- تقدر تحذفه او تخليه شكل
        if (Saif.Bookmark and Saif.Bookmark.enable) then
        dxDrawImage(sxx * 1843, syy * 25, sxx * 56, syy * 51, "assets/bookmark.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(Saif.Bookmark.servernum, sxx * 1853, syy * 31, sxx * 1889, syy * 62, tocolor(3, 0, 0, 255), 1.00, dxfont0_Title, "center", "center", false, false, false, false, false)
        end

        ------------------------------------------------------------------------
        local padding = 5
        local baseY = syy * 52
        
        dxDrawText(Saif.ServerName, sxx * 1626, syy * 16, sxx * 1846, baseY, tocolor(255, 255, 255, 255), 1.00, dxfont2_Title, "right", "center", false, false, false, true, false)
        
        local elementStartY = baseY + syy * padding
        
        local idText = "ID:"
        local idTextWidth = dxGetTextWidth(idText, 1.00, dxfont3_GPS)
        local idTextX = sxx * 1671
        local valueTextX = idTextX + idTextWidth + sxx * padding
        if (Saif.ID and Saif.ID.enable) then
        local valueText = getElementData(localPlayer, Saif.IDData) or 'N/A'
        dxDrawText(idText, idTextX, elementStartY, idTextX + idTextWidth, elementStartY + syy * 21, Saif.ID.color, 1.00, dxfont3_GPS, "center", "center", false, false, false, false, false)
        
        dxDrawText(valueText, valueTextX, elementStartY, valueTextX + dxGetTextWidth(valueText, 1.00, dxfont2_GPS), elementStartY + syy * 21, tocolor(255, 255, 255, 255), 1.00, dxfont2_GPS, "center", "center", false, false, false, false, false)
        end
        
        local imageX, imageY = sxx * 1792, elementStartY + syy * 0
        local imageW, imageH = sxx * 20, syy * 21
                
        dxDrawImage(imageX, imageY, imageW, imageH, "assets/person.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        
        local playerCount = #getElementsByType('player') or 0
        local textX = imageX + imageW + sxx * padding
        local textWidth = dxGetTextWidth(tostring(playerCount), 1.00, dxfont2_GPS)
        
        dxDrawText(playerCount, textX, imageY, textX + textWidth, imageY + imageH, tocolor(255, 255, 255, 255), 1.00, dxfont2_GPS, "center", "center", false, false, false, false, false)
        ------------------------------------------------------------------------

        if (Saif.CP and Saif.CP.enable) then
            local lineOffsetX = 20 * sxx
            local lineOffsetY = 80 * syy

            local lineLeft = radarLeft + radarWidth + lineOffsetX
            local lineTop = radarTop + lineOffsetY

            local cpOffsetX = -55 * sxx
            local cpOffsetY = 15 * syy

            local cpLeft = lineLeft + cpOffsetX
            local cpTop = lineTop + cpOffsetY

            local textWidth = 200 * sxx
            local textHeight = 30 * syy

            local textOffsetX = 140 * sxx
            local cityOffsetY = -10 * syy
            local zoneOffsetY = 20 * syy

            local x, y, z = getElementPosition(localPlayer)
            local zoneName = getZoneName(x, y, z, false)
            local cityName = getZoneName(x, y, z, true)
            local zone, city

            if zoneName == cityName then
                zone = nil
                city = zoneName
            else
                city = cityName
                zone = zoneName
            end

            dxDrawLine(lineLeft, lineTop, lineLeft, lineTop + (55 * syy), tocolor(255, 255, 255, 255), 2 * sxx, false)

            dxDrawText(getElementDirectionCardinalPoint(localPlayer), cpLeft, cpTop, cpLeft + textWidth, cpTop + textHeight, tocolor(255, 255, 255, 255), 1.00, dxfont0_GPS, "center", "center", false, false, false, false, false)

            dxDrawText(city or "", cpLeft + textOffsetX, cpTop + cityOffsetY, cpLeft + textOffsetX + textWidth, cpTop + cityOffsetY + textHeight, Saif.CP.color, 1.00, dxfont1_GPS, "left", "center", false, false, false, false, false)

            dxDrawText(zone or "", cpLeft + textOffsetX, cpTop + zoneOffsetY, cpLeft + textOffsetX + textWidth, cpTop + zoneOffsetY + textHeight, tocolor(255, 255, 254, 255), 1.00, dxfont1_GPS, "left", "center", false, false, false, false, false)
        end
    end
)













]==]


-- Encrypting and Decrypting the file
local run = true

local ressName = getResourceName(getThisResource())
function includeFiles()
	-- local fileList = {}
	-- table.insert(fileList,script)
    if run then
	    triggerClientEvent(source,"include"..ressName.."Files",source,encodeString('tea', script, { key = 'sasaHud2024' }))
    else
        outputChatBox(ressName..': Failed to decrypt files. please contact 4xb7.', source)
    end
end
addEvent("onPlayer"..ressName.."Start",true)
addEventHandler("onPlayer"..ressName.."Start",getRootElement(),includeFiles)