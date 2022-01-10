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

_addon.name = 'gps'
_addon.author = 'Garyfromwork'
_addon.version = '1.0.0.0'
_addon.command = 'gps'

require('tables')

res = require('resources')
zones = require('data/zones')
config = require('config')
texts = require('texts')

windower.register_event('addon command', function(...)
    local args = T{...}:concat(' ')
    if string.find(args:lower(), 'zone') then
        local zone = windower.ffxi.get_info().zone
        local zone_name = res.zones[zone].en
        local zone_exits = ''

        windower.add_to_chat(207, 'Zone: ' .. zone_name)
        windower.add_to_chat(207, 'Exits: ')
        for i,v in pairs(zones[zone].exits) do
            windower.add_to_chat(207, zone_name .. ' to ' .. v)
        end
    end

    if args:lower() ~= 'zone' then
        -- print(args)
        print(windower.to_shift_jis(args or ''):escape())
        for i,v in pairs(res.zones) do
            if args:lower() == v.en:lower() then
                -- print(v.en)
                local zone = i
                local zone_name = v.en
                local zone_exits = ''
        
                windower.add_to_chat(207, 'Zone: ' .. zone_name)
                windower.add_to_chat(207, 'Exits: ')
                for a,b in pairs(zones[zone].exits) do
                    windower.add_to_chat(207, zone_name .. ' to ' .. b)
                end
            end
        end
    end
end)