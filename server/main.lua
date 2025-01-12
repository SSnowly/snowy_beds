local config = require 'config.client'
RegisterServerEvent('snowy_bed:server:logout', function()
    local isNearBed = false
    for _, bed in pairs(config.beds) do
        if #(bed.left.box.coords - GetEntityCoords(GetPlayerPed(source))) < 5.5 then
            isNearBed = true
            break
        end
    end
    if not isNearBed then
        lib.print.warning(('Player %s is not near a bed, but tried to logout'):format(source))
        return
    end
    if GetResourceState('qbx_core') == 'started' then
        exports.qbx_core:Logout(source)
    elseif GetResourceState('qb-core') == 'started' then
        local QBCore = exports['qb-core']:GetCoreObject()
        QBCore.Player.Logout(source)
    elseif GetResourceState('es_extended') == 'started' then
        DropPlayer(source, 'Logged out')
    end
end)

RegisterServerEvent('snowy_bed:server:quit', function()
    local isNearBed = false
    for _, bed in pairs(config.beds) do
        if #(bed.coords - GetEntityCoords(GetPlayerPed(source))) < 5.5 then
            isNearBed = true
            break
        end
    end
    if not isNearBed then
        lib.print.warning(('Player %s is not near a bed, but tried to quit'):format(source))
        return
    end
    DropPlayer(source, 'Quit')
end)
