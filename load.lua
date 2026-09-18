-- Encrypting and Decrypting the file

local ressName = getResourceName(getThisResource())
function includeFiles(fileList)
	-- for _,v in ipairs(fileList) do
		func = assert(loadstring(decodeString('tea', fileList, { key = 'sasaHud2024' })))
		func()
        local components = { "weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted" }

        for _, component in ipairs( components ) do
            setPlayerHudComponentVisible( component, false )
        end
	-- end
end
addEvent("include"..ressName.."Files",true)
addEventHandler("include"..ressName.."Files",getRootElement(),includeFiles)

 

addEventHandler("onClientResourceStart",getResourceRootElement(),function()
	triggerServerEvent("onPlayer"..ressName.."Start",getLocalPlayer())
end)