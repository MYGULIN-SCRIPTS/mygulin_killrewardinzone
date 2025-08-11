ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('killed')
AddEventHandler('killed', function(killerId)
    if killerId then
        local xPlayer = ESX.GetPlayerFromId(killerId)
        if xPlayer then
            local reward = math.random(1000, 2500)  -- Hráč dostane náhodný počet mezi 1000 a 2500 / The player receives a random amount between 1000 and 2500
            exports.ox_inventory:AddItem(killerId, 'money', reward) -- 'money' Název itemu který dostane hráč když někoho zabije                                           
        end                                                         -- "money" – the name of the item the player receives when they kill someone.
    end
end)
