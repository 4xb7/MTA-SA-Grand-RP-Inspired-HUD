function getElementDirectionCardinalPoint(p)
    local rotation = select(3, getElementRotation(p))
    if (rotation <= 22.5) or (rotation > 337.5) then
        return "N"
    elseif (rotation > 22.5 and rotation <= 67.5) then
        return "NW"
    elseif (rotation > 67.5 and rotation <= 112.5) then
        return "W"
    elseif (rotation > 112.5 and rotation <= 157.5) then
        return "SW"
    elseif (rotation > 157.5 and rotation <= 202.5) then
        return "S"
    elseif (rotation > 202.5 and rotation <= 247.5) then
        return "SE"
    elseif (rotation > 247.5 and rotation <= 292.5) then
        return "E"
    elseif (rotation > 292.5 and rotation <= 337.5) then
        return "NE"
    else
        return "N/A"
    end
end


function formatMoney(number, sep)
	assert(type(tonumber(number))=="number", "Bad argument @'formatMoney' [Expected number at argument 1 got "..type(number).."]")
	assert(not sep or type(sep)=="string", "Bad argument @'formatMoney' [Expected string at argument 2 got "..type(sep).."]")
	sep = sep or ','
	local money = number
	for i = 1, tostring(money):len()/3 do
		money = string.gsub(money, "^(-?%d+)(%d%d%d)", "%1"..sep.."%2")
	end
	return '$'..money
end