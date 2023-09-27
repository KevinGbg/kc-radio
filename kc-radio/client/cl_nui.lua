RegisterNUICallback("Close", function(data, cb)
    SetNuiFocus(false, false)
    cb(true)
end)

RegisterNUICallback("JoinChannel", function(data, cb)
    Radio.channel = data.frequency
    cb(data.frequency)
    Radio.JoinChannel(data.frequency)
end)

RegisterNUICallback("ToggleRadio", function(data, cb)
    if data == true then
        Radio.JoinChannel(Radio.channel)
    else
        Radio.LeaveChannel()
    end
end)