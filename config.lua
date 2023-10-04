Config = {}

Config.Framework = 'ESX' -- ESX or QB

Config.Item = true --if item = false then use a key
Config.ItemName = "bread"
Config.Key = "F6"
Config.Both = true

Config.AnonymousName = 'Anonymous'

Config.Channels = {

    ['911'] = {
        label = "Police Radio",
        jobs = {"police", "ambulance"}
    },
    ['011'] = {
        label = "Cardealer Radio",
        jobs = {"cardealer"}
    }
}