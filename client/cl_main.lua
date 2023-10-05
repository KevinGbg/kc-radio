local QORE = false
Radio = {
    channel = "0",
    volume = 100,
    text = "Not In Radio",
    name = "Undefined",
    id = "Undefined",
    members = {}
}

Settings = {
    anon = false,
    size = '1.0'
}

if Config.Framework == "ESX" then
    KC = exports.es_extended:getSharedObject()

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(d)
        KC.PlayerData = d

        Radio.name = KC.PlayerData.firstName.. " " .. KC.PlayerData.lastName
        Radio.id = KC.PlayerData.identifier

        GetJob = function()
            return KC.PlayerData.job.name
        end

        QORE()

        Radio.GetSettings()
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        KC.PlayerData.job = job
    end)

    Notify = function(text, type)
        KC.ShowNotification(text)
    end
elseif Config.Framework == "QB" then
    KC = exports['qb-core']:GetCoreObject()

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        local player = QBCore.Functions.GetPlayerData()

        Radio.name = KC.Functions.GetPlayerData().charinfo.firstname .. " " .. KC.Functions.GetPlayerData().charinfo.lastname
        Radio.id = KC.Functions.GetPlayerData().citizenid

        GetJob = function()
            return KC.Functions.GetPlayerData().job.name
        end

        QORE()

        Radio.GetSettings()
    end)

    Notify = function(text, type)
        KC.Functions.Notify(text, type)
    end
elseif Config.Framework == "REVOKED" then
    KC = exports[Config.Base]:getSharedObject()

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(d)
        KC.PlayerData = d

        Radio.name = KC.PlayerData.character.firstname.. " " .. KC.PlayerData.character.lastname
        Radio.id = KC.PlayerData.characterId
    
        GetJob = function()
            return KC.PlayerData.job.name
        end

        QORE()

        Radio.GetSettings()
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        KC.PlayerData.job = job
    end)

    Notify = function(text, type)
        KC.ShowNotification(text)
    end
end


QORE = function()
    function LoadAnimDic(dict)
        if not HasAnimDictLoaded(dict) then
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Wait(0)
            end
        end
    end

    Radio.ToggleRadioAnimation = function(state)
        LoadAnimDic("cellphone@")
        if state then
            TriggerEvent("attachItemRadio","radio01")
            TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
            prop = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
            AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
        else
            StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 1.0)
            ClearPedTasks(PlayerPedId())
            if prop ~= 0 then
                DeleteObject(prop)
                prop = 0
            end
        end
    end

    Radio.GetSettings = function()
        local kvpValue = GetResourceKvpString(Radio.id)
        if kvpValue then
            local settingsvalue = json.decode(kvpValue)
            if settingsvalue then
                Settings = settingsvalue
            end
        end
    end

    Radio.Open = function(callback)
        KC.TriggerServerCallback("radio:getmembers", function(radiomembers)
            Radio.ToggleRadioAnimation(true)
            SendNUIMessage({
                type = "Open",
                data = {
                    name = Radio.name,
                    channel = Radio.channel,
                    volume = Radio.volume,
                    text = Radio.text,
                    members = radiomembers
                },
                settings = {
                    anon = Settings.anon,
                    size = Settings.size
                }
            })
            SetNuiFocus(true, true)
        end, Radio.channel)
    end

    if not Config.Item or Config.Both then
        RegisterCommand("radio", function()
            Radio.Open(function(error)
                if error then
                    print("Error opening radio: " .. error)
                end
            end)        
        end)

        RegisterKeyMapping("radio", "Key To Open Radio", "keyboard", Config.Key)
    end

    Radio.JoinChannel = function(frequency)
        Radio.RemoveMember()

        if frequency == '0' then
            Radio.channel = frequency
            Radio.text = "Not In Radio"
            exports["pma-voice"]:removePlayerFromRadio()
            Notify('You left the radio', 'success')
            return
        else
            local jobMatchFound = false
            for k, c in pairs(Config.Channels) do
                if frequency == k then
                    for i = 1, #c.jobs do
                        if GetJob() == c.jobs[i] then 
                            Radio.channel = frequency
                            Radio.text = c.label
                            Radio.JoinRadio(frequency)
                            jobMatchFound = true
                            return true
                        end
                    end
                    if not jobMatchFound then
                        Radio.text = "Not In Radio"
                        exports["pma-voice"]:removePlayerFromRadio()
                        Notify('You dont´t have access to join this channel', 'error')
                        Radio.channel = "0"
                        return false
                    end
                end
            end

            Radio.channel = frequency
            Radio.JoinRadio(frequency)
            Radio.text = "In Radio"
            return true
        end
    end

    Radio.JoinRadio = function(frequency)
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        exports["pma-voice"]:setRadioChannel(tonumber(frequency))

        Notify('You joined frequency ' .. frequency, 'success')
        Radio.SetMember()
    end

    Radio.LeaveChannel = function()
        exports["pma-voice"]:removePlayerFromRadio()
        Notify('You turned off the radio', 'success')
        Radio.RemoveMember()
    end

    Radio.SetMember = function()
        if Settings.anon then
            KC.TriggerServerCallback("radio:setmember", function()
            end, {id = Radio.id, name = Config.AnonymousName}, Radio.channel)
        else
            KC.TriggerServerCallback("radio:setmember", function()
            end, {id = Radio.id, name = Radio.name}, Radio.channel)
        end
    end

    Radio.RemoveMember = function()
        if Settings.anon then
            KC.TriggerServerCallback("radio:removemember", function()
            end, {id = Radio.id, name = Config.AnonymousName}, Radio.channel)
        else
            KC.TriggerServerCallback("radio:removemember", function()
            end, {id = Radio.id, name = Radio.name}, Radio.channel)
        end
    end

    Radio.SetVolume = function(volume)
        Radio.volume = volume
        exports["pma-voice"]:setRadioVolume(tonumber(volume))
    end

    Radio.SaveSettings = function(settings)
        local jsonSettings = json.encode(settings)
        SetResourceKvp(Radio.id, jsonSettings)

        Radio.GetSettings()
    end

    RegisterNetEvent("radio:open")
    AddEventHandler("radio:open", function()
        Radio.Open(function(error)
            if error then
                print("Error opening radio: " .. error)
            end
        end)    
    end)

    RegisterNetEvent('onPlayerDropped', function(serverId)
        Radio.RemoveMember()
    end)
end