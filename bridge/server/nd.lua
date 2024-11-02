if GetResourceState('ND_Core') ~= 'started' then return end

NDCore = exports.ND_Core

AddEventHandler('ox_inventory:usedItem', function(playerId, name, slotId, metadata)
    if UseDebug then print('opening ui') end

    if name == Config.ItemName.gps then
        openRacingApp(playerId)
    end
end)

-- Adds money to user
function addMoney(src, moneyType, amount)
    local ply = NDCore:getPlayer(src)
    ply.addMoney(moneyType, math.floor(amount))
end

-- Removes money from user
function removeMoney(src, moneyType, amount, reason)
    local ply = NDCore:getPlayer(src)
    return ply.deductMoney(moneyType, math.floor(amount))
end

-- Checks that user can pay
function canPay(src, moneyType, cost)
    local ply = NDCore:getPlayer(src)
    return ply[moneyType] >= cost
end

-- Updates Crew
function updateCrew(src, crewName)
    local ply = NDCore:getPlayer(src)
    ply.setMetadata("selectedCrew", crewName)
end

-- Fetches the CitizenId by Source
function getCitizenId(src)
    local ply = NDCore:getPlayer(src)
    return ply.id
end

-- Fetches the Source of an online player by citizenid
function getSrcOfPlayerByCitizenId(citizenId)
    return NDCore:fetchCharacter(citizenId)
end