fx_version 'adamant'
game 'gta5'
lua54 'yes'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/*.lua'
}

client_scripts {
	'config.lua',
	'client/*.lua'
}

--ui_page 'web/dist/index.html'
ui_page 'http://localhost:3000/' -- Dev

files {
    'web/dist/index.html',
    'web/dist/**/*',
}

escrow_ignore {
	'server/sv_config.lua',
	'client/cl_config.lua',
	'config.lua'
}