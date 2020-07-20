ESX 						   = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('stolowka:jedzonko')
AddEventHandler('stolowka:jedzonko', function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  local identifier = xPlayer.getIdentifier()

  TriggerClientEvent('esx_status:add', source, 'hunger', 150000)
  TriggerClientEvent('stolowka:jedz', source)
end)

RegisterServerEvent('stolowka:pij')
AddEventHandler('stolowka:pij', function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  local identifier = xPlayer.getIdentifier()
  TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
  TriggerClientEvent('stolowka:picie', source)
end)