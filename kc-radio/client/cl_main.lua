KC = exports.es_extended:getSharedObject()
Radio = {
    channel = 0
}

RegisterCommand("radio", function()
    Radio.Open()
end)

Radio.Open = function()
    SendNUIMessage({
        type = "Open",
        data = {
            name = "Neger",
            channel = Radio.channel
        }
    })
    SetNuiFocus(true, true)
end

Radio.JoinChannel = function(frequency)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
    exports["pma-voice"]:setRadioChannel(tonumber(frequency))
end

Radio.LeaveChannel = function()
    exports["pma-voice"]:removePlayerFromRadio()
end

RegisterCommand("radioch", function()
    print(Radio.channel)
end)