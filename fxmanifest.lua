--[[ FX Information ]]--
fx_version   'cerulean'
use_experimental_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'

author 'Snowy'
description 'Sleep in any bed, quit or logout'
version '1.0.0'

--[[ Manifest ]]--
ui_page 'html/index.html'
shared_scripts {
    '@ox_lib/init.lua'
}
server_scripts {
    'server/*.lua'
}
client_scripts {
    'client/*.lua'
}
files {
    'config/client.lua',
    'html/index.html',
    'html/style.css',
    'html/app.js',
}
