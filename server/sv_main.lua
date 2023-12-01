Radio = {
    members = {}
}

local callback

QORE = function()
    callback("radio:getmembers", function(source, cb, radiochannel)
        cb(Radio.GetMembers(radiochannel))
    end)

    callback("radio:setmember", function(source, cb, memberData, radiochannel)
        Radio.SetMember(memberData, radiochannel)
    end)

    callback("radio:removemember", function(source, cb, memberData, radiochannel)
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
end

if Config.Framework == "ESX" then
    KC = exports.es_extended:getSharedObject()
    callback = KC.RegisterServerCallback

    if Config.Item or Config.Both then
        KC.RegisterUsableItem(Config.ItemName, function(source)
            TriggerClientEvent("radio:open", source)
        end)
    end

    QORE()
elseif Config.Framework == "REVOKED" then
    KC = exports[Config.Base]:getSharedObject()
    callback = KC.RegisterServerCallback

    if Config.Item or Config.Both then
        KC.RegisterUsableItem(Config.ItemName, function(source)
            TriggerClientEvent("radio:open", source)
        end)
    end

    QORE()
elseif Config.Framework == "QB" then
    KC = exports['qb-core']:GetCoreObject()
    callback = KC.Functions.CreateCallback

    if Config.Item or Config.Both then
        KC.Functions.CreateUseableItem(Config.ItemName, function(source)
            TriggerClientEvent('radio:open', source)
        end)
    end

    QORE()
end
