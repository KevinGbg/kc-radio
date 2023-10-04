fx_version 'adamant'
game 'gta5'
lua54 'yes'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/*.lua'
}

shared_scripts {
	'config.lua'
}

client_scripts {
	'client/*.lua'
}

ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/**/*',
}