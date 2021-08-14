RegisterCommand('veh', function(source, args)
    -- just incase the argument isnt passed
    local vehicleName = args[1] or 'dubsta'

    -- check if the vehicle is valid
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        TriggerEvent('chat:addMessage', {
            args = {"Car doesn't exist:" .. vehicleName}
        })
    end

    -- load the car model
    RequestModel(vehicleName)

    -- wait for the model to load
    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    -- get player's position
    local playerPed = playerPedId()
    local pos = GetEntityCoords(PlayerPed)

    -- create the car
    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    
    SetPedIntoVehicle(playerPed, vehicle, -1) -- put the player in the drivers seat
    SetEntityAsNoLongerNeeded(vehicle) -- let the game decide when to despawn the car
    SetModelasNoLongerNeeded(vehicleName) -- release the model
    
    -- notify admin that the car has spawned
    TriggerEvent('chat:addMessage', {
        args = {'You have spawned a ' .. vehicleName .. '.'}
    })
end, false)

-- Deleting a vehicle
RegisterCommand('delveh' function()
    local playerPed = PlayerPedId() -- get the local player ped
    local vehicle = GetVehiclePedIsIn(playerPed, false) -- get the vehicle admin is in
    DeleteEntity(vehicle) -- delete the car
end, false)