RegisterNUICallback("Close", function(data, cb)
    Radio.ToggleRadioAnimation(false)
    SetNuiFocus(false, false)
    cb(true)
end)

RegisterNUICallback("JoinChannel", function(data, cb)
    local join = Radio.JoinChannel(data.frequency)
    if join then
        KC.TriggerServerCallback("radio:getmembers", function(radiomembers)
            cb({frequency = data.frequency, text = Radio.text, members = radiomembers})
        end, data.frequency)
    else
        cb({frequency = "0", text = "Not In Radio", members = {}})
    end
end)

RegisterNUICallback("ToggleRadio", function(data, cb)
    if data == true then
        Radio.JoinChannel(Radio.channel)
    else
        Radio.LeaveChannel()
    end
end)

RegisterNUICallback("setVolume", function(data, cb)
    Radio.SetVolume(data)
end)


RegisterNUICallback("savesettings", function(data, cb)
    Radio.SaveSettings(data)
end)