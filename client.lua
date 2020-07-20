ESX 			    			= nil
local sprzedazzasieg = false
local markerzasieg = false
local miejscesprzedazy          = { x = 1663.77, y = 2669.96, z = 45.5 }
local przycisk  = 38 -- E
local PlayerData	= {} --nie tykaj
local DrawDistance = 20

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
    while true do
      Citizen.Wait(12)
        local coords = GetEntityCoords(PlayerPedId())
            if(GetDistanceBetweenCoords(coords, miejscesprzedazy.x, miejscesprzedazy.y, miejscesprzedazy.z, true) < DrawDistance) then
                DrawMarker(27, miejscesprzedazy.x, miejscesprzedazy.y, miejscesprzedazy.z-0.91, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.001, 2.0001, 0.1001, 213, 1, 32, 100, false, true, 2, false, false, false, false)
                if(GetDistanceBetweenCoords(coords, miejscesprzedazy.x, miejscesprzedazy.y, miejscesprzedazy.z, true) < 2.5) then
                   ESX.ShowHelpNotification("Naciśnij ~INPUT_VEH_HORN~ aby odebrać posiłek", 0)
                    if IsControlJustReleased(1, przycisk) then
                       ESX.ShowNotification('~b~Pojadłeś i popiłeś sobie')
                       TriggerServerEvent('stolowka:jedzonko')
                       Citizen.Wait(5040)
                       TriggerServerEvent('stolowka:pij')
                    end
                end
            end
        end
end)

RegisterNetEvent('stolowka:jedz')
AddEventHandler('stolowka:jedz', function()
	local playerPed  = GetPlayerPed(-1)
	local coords     = GetEntityCoords(playerPed)
	local boneIndex  = GetPedBoneIndex(playerPed, 18905)
	local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

	RequestAnimDict('amb@code_human_wander_eating_donut@male@idle_a')
	while not HasAnimDictLoaded('amb@code_human_wander_eating_donut@male@idle_a') do
		Citizen.Wait(1)
	end
	
	ESX.Game.SpawnObject('prop_sandwich_01', {
		x = coords.x,
		y = coords.y,
		z = coords.z - 3
	}, function(object)
		TaskPlayAnim(playerPed, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", 3.5, -8, -1, 49, 0, 0, 0, 0)
		AttachEntityToEntity(object, playerPed, boneIndex2, 0.15, 0.01, -0.06, 185.0, 215.0, 180.0, true, true, false, true, 1, true)
		Citizen.Wait(5000)
		DeleteObject(object)
		ClearPedSecondaryTask(playerPed)
	end)
end)

RegisterNetEvent('stolowka:picie')
AddEventHandler('stolowka:picie', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

Citizen.CreateThread(function()
    
    RequestModel(GetHashKey("u_m_y_burgerdrug_01"))
    while not HasModelLoaded(GetHashKey("u_m_y_burgerdrug_01")) do
      Wait(10)
    end

      local jedzenieped =  CreatePed(4, 0x8B7D3766, miejscesprzedazy.x, miejscesprzedazy.y+0.5, miejscesprzedazy.z-0.92, 96.87, false, true)
      SetEntityHeading(jedzenieped,  186.87)
      FreezeEntityPosition(jedzenieped, true)
      SetEntityInvincible(jedzenieped, true)
      SetBlockingOfNonTemporaryEvents(jedzenieped, true)
end)