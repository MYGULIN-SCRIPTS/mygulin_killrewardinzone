Config = Config or {}

Config.zones = {
    {pos = vector3(-418.4659, 1148.6256, 325.8673), radius = 105.0},
    {pos = vector3(200.0, 300.0, 100.0), radius = 50.0},
}

Citizen.CreateThread(function()
    local wasDead = false
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if IsEntityDead(ped) and not wasDead then
            wasDead = true
            local killerPed = GetPedSourceOfDeath(ped)
            if killerPed then
                local killerPlayer = NetworkGetPlayerIndexFromPed(killerPed)
                if killerPlayer and killerPlayer ~= -1 then
                    local killerServerId = GetPlayerServerId(killerPlayer)
                    local coords = GetEntityCoords(ped)
                    for _, zone in ipairs(Config.zones) do
                        local distance = #(coords - zone.pos)
                        if distance <= zone.radius then
                            TriggerServerEvent('killed', killerServerId)
                            break
                        end
                    end
                end
            end
        elseif not IsEntityDead(ped) and wasDead then
            wasDead = false
        end
    end
end)
