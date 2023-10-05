if Config.Framework == "ESX" then
    KC = exports.es_extended:getSharedObject()

    if Config.Item or Config.Both then
        KC.RegisterUsableItem(Config.ItemName, function(source)
            TriggerClientEvent("radio:open")
        end)
    end
elseif Config.Framework == "REVOKED" then
    KC = exports[Config.Base]:getSharedObject()

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

Radio = {
    members = {}
}

KC.RegisterServerCallback("radio:getmembers", function(source, cb, radiochannel)
    cb(Radio.GetMembers(radiochannel))
end)

KC.RegisterServerCallback("radio:setmember", function(source, cb, memberData, radiochannel)
    Radio.SetMember(memberData, radiochannel)
end)

KC.RegisterServerCallback("radio:removemember", function(source, cb, memberData, radiochannel)
    Radio.RemoveMember(memberData, radiochannel)
end)

Radio.GetMembers = function(radiochannel)
    return Radio.members[radiochannel]
end

Radio.SetMember = function(memberData, radiochannel)
    if not Radio.members[radiochannel] then
        Radio.members[radiochannel] = {}
    end
    table.insert(Radio.members[radiochannel], memberData)
end


Radio.RemoveMember = function(memberData, radiochannel)
    if Radio.members[radiochannel] then
        for i, data in ipairs(Radio.members[radiochannel]) do
            if data.id == memberData.id then
                table.remove(Radio.members[radiochannel], i)
                break
            end
        end
    end
end