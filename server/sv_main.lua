if Config.Framework == "ESX" then
    KC = exports.es_extended:getSharedObject()

    if Config.Item or Config.Both then
        KC.RegisterUsableItem(Config.ItemName, function(source)
            TriggerClientEvent("radio:open")
        end)
    end
elseif Config.Framework == "QB" then
    KC = exports['qb-core']:GetCoreObject()

    if Config.Item or Config.Both then
        KC.Functions.CreateUseableItem(Config.ItemName, function(source)
            TriggerClientEvent('radio:open', source)
        end)
    end
end

Radio = {}
