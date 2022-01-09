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

_addon.name = 'Vwatch'
_addon.author = 'Garyfromwork'
_addon.version = '1.1.0.0'
_addon.command = 'watch'

require('tables')

res = require 'resources'
config = require('config')
texts = require('texts')

message = 'to complete the battle'

options = {}
options.enabled = true
options.auto = true
targets = {}
targets.vnm = '17502577'
targets.vnm_name = ''
targets.planar_rift = '17502702'
targets.chest = '17502705'

has_target = false
fighting = false

cycle = {}
cycle.popping_rift = false
cycle.fighting_vnm = false
cycle.looting_chest = false

windower.register_event('load', function()
    windower.send_command('input //lua r settarget')
    windower.send_command('input //lua r enternity')
end)

windower.register_event('addon command', function(command)
    if command:lower() == 'target' then
        target = windower.ffxi.get_mob_by_target('t')
        if target then
            targets.vnm = target.id
        end
    end
    if command:lower() == 'setrift' then
        target = windower.ffxi.get_mob_by_target('t')
        if target then
            targets.planar_rift = target.id
        end
    end
    if command:lower() == 'box' then
        -- set_box_id()
    elseif command:lower() == 'rift' then
        windower.send_command('input //settarget ' .. targets.planar_rift)
        coroutine.sleep(2)
        for i=1,5 do
            windower.send_command('input /item "Phase Displacer" <t>')
        end
        windower.send_command('input /item "Rubicund Cell" <t>')
        windower.send_command('input /item "Cobalt Cell" <t>')
        coroutine.sleep(1)
        windower.send_command('input //watch pop')

    elseif command:lower() == 'pop' then
        if windower.ffxi.get_info().menu_open ~= true then
            windower.send_command('input //settarget ' .. targets.planar_rift)
            coroutine.sleep(2)
            windower.send_command('setkey enter down;wait 0.1;setkey enter up;')
            coroutine.sleep(2)
            windower.send_command('setkey down down;wait 0.1;setkey down up;')
            coroutine.sleep(2)
            windower.send_command('setkey enter down;wait 0.1;setkey enter up;')
            coroutine.sleep(2)
            windower.send_command('setkey j down;wait 0.1;setkey j up;')
            coroutine.sleep(2)
            windower.send_command('setkey enter down;wait 0.1;setkey enter up;')
            coroutine.sleep(2)
            for i=1,5 do
                windower.send_command('setkey down down; wait 0.5;setkey down up;')
            end
            coroutine.sleep(2)
            windower.send_command('setkey enter down; wait 0.1;setkey enter up;')
        end
    end

end)

windower.register_event('incoming text', function(original, modified)
	if (string.find(original, message)) then
        if options.enabled then
		    windower.add_to_chat(8, 'Beginning VNM fight.')
            --begin fight macro
            coroutine.sleep(10)
            vnm = windower.ffxi.get_mob_by_id(targets.vnm)
            windower.send_command('input //settarget ' .. targets.vnm)
            has_target = true
            targets.vnm_name = vnm.name
            
            coroutine.sleep(1)
            windower.send_command('input /a <t>')
            fighting = true
            windower.add_to_chat(8, 'Fighting ' .. targets.vnm_name)
        end
	end

    if (string.find(original, 'vulnerable to thief abilities')) then
        windower.send_command('input /ja "Bully" <t>')
    end
end)

windower.register_event('time change', function()
    vnm = windower.ffxi.get_mob_by_id(targets.vnm)
    me = windower.ffxi.get_player()

    if vnm and has_target and fighting then
        windower.send_command('input /follow <t>')
        has_target = false
        fighting = false
    end
end)

windower.register_event('status change', function(new, old)
    if old == 1 and new == 0 then
        has_target = false
        fighting = false
        windower.ffxi.follow()
    end
end)