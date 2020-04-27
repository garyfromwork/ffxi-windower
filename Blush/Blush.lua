--[[
Copyright © 2020, Garyfromwork of Asura
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of DistancePlus nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Sammeh BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

_addon.name = 'Blush'
_addon.author = 'Garyfromwork'
_addon.version = '1.0.0.1'
_addon.command = 'bl'

require('tables')

res = require 'resources'
config = require('config')
texts = require('texts')

settings = config.load(defaults)

bazaar_cmd = settings.bazaar.command
shocked_cmd = settings.shocked.command
jump_cmd = settings.jump.command
joy_cmd = settings.joy.command
blush_cmd = settings.blush.command
online_cmd = settings.online_status.command

options = {}
options.bazaar = false
options.shocked = false
options.jump = false
options.joy = false
options.blush = true
options.status = true

windower.register_event('examined', function(name, sender_index)
    if options.bazaar == true then
        windower.add_to_chat(8, 'Message ' .. bazaar_cmd .. "I'm currently <" )
        windower.send_command('wait 2; input /target ' .. name)
        windower.send_command('wait 2; input /t ' .. name .. ' ' .. bazaar_cmd)
    end
    if options.blush == true then
        windower.send_command('wait 2; input /target ' .. name)
        windower.send_command('wait 2; input /blush <t>')
    end
end)

windower.register_event('addon command', function(command)
    if command:lower() == 'help' then
        windower.add_to_chat(8,'Blush: Valid Modes are //BL <command>:')
        windower.add_to_chat(8,' Bazaar, Blush, Jump, Joy, Shocked, Show')
    elseif command:lower() == 'bazaar' then
            windower.add_to_chat(8, "Bazaar Mode Enabled")
            options.bazaar = true
    elseif command:lower() == 'blush' then
            windower.add_to_chat(8, "Blush Mode Enabled")
            options.blush = true
    elseif command:lower() == 'jump' then
            windower.add_to_chat(8, "Jump Mode Enabled")
            options.jump = true
    elseif command:lower() == 'joy' then
            windower.add_to_chat(8, "Joy Mode Enabled")
            options.joy = true
    elseif command:lower() == 'shocked' then
            windower.add_to_chat(8, "Shocked Mode Enabled")
            options.shocked = true
    elseif command:lower() == 'away' then
        options.status = 'AFK'
    elseif command:lower() == 'asleep' then
        options.status = 'Asleep'
    elseif command:lower() == 'brb' then
        options.status = 'BRB'
    end
end)