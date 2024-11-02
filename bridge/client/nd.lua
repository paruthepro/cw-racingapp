if GetResourceState('ND_Core') ~= 'started' then return end

if Config.Debug then print('Using ND Core bridge') end

local core = exports.ND_Core

RegisterNetEvent("ND:characterLoaded", function()
    initialSetup()
end)

function getPlayerJobName()
    local playerData = core:getPlayer()
    if playerData and playerData.job then
        return playerData.job
    end
end

function getPlayerJobLevel()
    local playerData = core:getPlayer()
    if playerData and playerData.job and playerData.jobInfo.rank then
        return playerData.jobInfo.rank
    end
end

function hasGps()
    if exports.ox_inventory:Search('count', Config.ItemName.gps) >= 1 then
        return true
    end
    return false
end

function getCitizenId()
    return core:getPlayer().id
end

function getVehicleModel(vehicle)
    local model = GetEntityModel(vehicle)
    return GetDisplayNameFromVehicleModel(model)
end

function getClosestPlayer()
    local coords = GetEntityCoords(cache.ped)
    local playerId, _, playerCoords = lib.getClosestPlayer(coords, 50, false)
    local closestDistance = playerCoords and #(playerCoords - coords) or nil
    return playerId, closestDistance
end

function notify(text, type)
    -- Remove this block if you dont want in-app notifications
    if UiIsOpen then
        SendNUIMessage({
            type = "notify",
            data = {
                title = text,
                type = type,
            },
        })
        return
    end

    lib.notify({
        title = text,
        type = type,
    })
end
